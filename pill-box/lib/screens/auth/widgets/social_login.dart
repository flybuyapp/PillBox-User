import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flybuy/constants/app.dart' show googleClientId;
import 'package:flybuy/constants/constants.dart' show isWeb;
import 'package:flybuy/screens/auth/login_mobile_screen.dart';
import 'package:flybuy/screens/auth/services/login_apple.dart';
import 'package:flybuy/screens/auth/services/login_facebook.dart';
import 'package:flybuy/store/auth/login_store.dart';
import 'package:flybuy/utils/debug.dart';
import 'package:flybuy/widgets/flybuy_button_social.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLogin extends StatefulWidget {
  final LoginStore? store;
  final Function(Map<String, dynamic>)? handleLogin;
  final MainAxisAlignment mainAxisAlignment;

  final Map<String, bool?>? enable;
  final String type;

  const SocialLogin({
    Key? key,
    this.store,
    this.handleLogin,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.enable,
    required this.type,
  }) : super(key: key);

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin>
    with AppleLoginMixin, FacebookLoginMixin {
  GoogleSignInAccount? _currentUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: isWeb || Platform.isAndroid ? googleClientId : null,
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleLogin(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleLogin(GoogleSignInAccount user) async {
    GoogleSignInAuthentication auth = await user.authentication;
    widget.handleLogin!({
      'type': 'google',
      'idToken': auth.idToken,
      'callback': _logout,
    });
  }

  Future<void> loginGoogle(Function? login) async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      avoidPrint('---- Login Google Error---');
      avoidPrint(e);
      avoidPrint('---- End Login Google Error---');
    }
  }

  void _logout() async {
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    bool enableFacebook = widget.enable!['facebook'] ?? true;
    bool enableGoogle = widget.enable!['google'] ?? true;
    bool enableSms = widget.enable!['sms'] ?? true;
    bool apple = widget.enable!['apple'] ?? true;
    bool enableApple = !isWeb && Platform.isIOS && apple;

    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        if (enableFacebook)
          FlybuyButtonSocial.facebook(
            onPressed: () => loginFacebook(widget.handleLogin),
          ),
        if (enableFacebook && (enableGoogle || enableSms || enableApple))
          const SizedBox(
            width: 16,
          ),
        if (enableGoogle)
          FlybuyButtonSocial.google(
            onPressed: () => loginGoogle(widget.handleLogin),
          ),
        if (enableGoogle && (enableSms || enableApple))
          const SizedBox(
            width: 16,
          ),
        if (enableSms)
          FlybuyButtonSocial.sms(
            onPressed: () => Navigator.of(context).pushNamed(
                LoginMobileScreen.routeName,
                arguments: {'type': widget.type}),
          ),
        if (enableSms && enableApple)
          const SizedBox(
            width: 16,
          ),
        if (enableApple)
          FlybuyButtonSocial.apple(
            onPressed: () => loginApple(widget.handleLogin!),
          ),
      ],
    );
  }
}
