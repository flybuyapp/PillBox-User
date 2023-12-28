import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:video_player/video_player.dart';

class FlybuyVideo extends StatefulWidget {
  final String url;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;

  const FlybuyVideo({
    Key? key,
    required this.url,
    this.autoPlay = false,
    this.aspectRatio = 16 / 9,
    this.looping = false,
  }) : super(key: key);

  @override
  State<FlybuyVideo> createState() => _FlybuyVideoState();
}

class _FlybuyVideoState extends State<FlybuyVideo> with Utility, LoadingMixin {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void didChangeDependencies() async {
    await initializePlayer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await Future.wait([_videoPlayerController!.initialize()]);
    _chewieController = ChewieController(
      autoPlay: widget.autoPlay,
      videoPlayerController: _videoPlayerController!,
      autoInitialize: true,
      looping: widget.looping,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: _chewieController!)
          : iOSLoading(context),
    );
  }
}

class FlybuyVideoPlay extends StatefulWidget {
  final String url;
  final bool autoPlay;
  final bool looping;

  const FlybuyVideoPlay({
    Key? key,
    required this.url,
    this.autoPlay = false,
    this.looping = true,
  }) : super(key: key);

  @override
  State<FlybuyVideoPlay> createState() => _FlybuyVideoPlayState();
}

class _FlybuyVideoPlayState extends State<FlybuyVideoPlay> {
  VideoPlayerController? _controller;

  bool _play = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));

    _controller?.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    _controller?.setLooping(true);

    if (widget.autoPlay) {
      setState(() {
        _play = true;
      });
      _controller?.play();
    }
  }

  void _handlePress() {
    setState(() {
      _play = !_play;
    });

    if (_play) {
      _controller?.pause();
    } else {
      _controller?.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller != null && _controller!.value.isInitialized
          ? GestureDetector(
              onTap: _handlePress,
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Transform.scale(
                    alignment: Alignment.center,
                    scale: 1.1,
                    child: SizedBox(
                      width: _controller?.value.size.width ?? 0,
                      height: _controller?.value.size.height ?? 0,
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                ),
              ),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
