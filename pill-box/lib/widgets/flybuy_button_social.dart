import 'package:flybuy/constants/color_block.dart';
import 'package:flutter/material.dart';
import 'package:awesome_icons/awesome_icons.dart';

enum SocialBoxFit {
  fill,
  outline,
}

enum SocialType { circle, square }

class FlybuyButtonSocial extends StatelessWidget {
  final IconData icon;
  final double size;
  final double sizeIcon;
  final Color color;
  final Color background;
  final VoidCallback? onPressed;
  final SocialType type;
  final double wRadius;
  final bool isBorder;

  const FlybuyButtonSocial({
    Key? key,
    required this.icon,
    this.size = 48,
    this.sizeIcon = 18,
    this.color = Colors.white,
    this.background = Colors.black,
    this.onPressed,
    this.type = SocialType.circle,
    this.wRadius = 4,
    this.isBorder = false,
  }) : super(key: key);

  const factory FlybuyButtonSocial.facebook({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialFacebook;

  const factory FlybuyButtonSocial.google({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialGoogle;

  const factory FlybuyButtonSocial.sms({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialSms;

  const factory FlybuyButtonSocial.apple({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialApple;

  const factory FlybuyButtonSocial.twitter({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialTwitter;

  const factory FlybuyButtonSocial.pinterest({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialPinterest;

  const factory FlybuyButtonSocial.linkedIn({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialLinkedIn;

  const factory FlybuyButtonSocial.youtube({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialYouTube;

  const factory FlybuyButtonSocial.instagram({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialInstagram;

  const factory FlybuyButtonSocial.snapchat({
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialBoxFit boxFit,
    SocialType? type,
    double wRadius,
  }) = _FlybuyButtonSocialSnapchat;

  Widget buildContainer(
    BuildContext context, {
    required double size,
    required Color color,
    required SocialType socialType,
    VoidCallback? onPressed,
    double radius = 4,
    bool showBorder = false,
    Widget? icon,
  }) {
    ThemeData theme = Theme.of(context);

    double valueRadius = socialType == SocialType.circle ? size / 2 : radius;
    BorderRadius borderRadius = BorderRadius.circular(valueRadius);

    Decoration decoration = BoxDecoration(
      color: color,
      border:
          Border.all(width: 1, color: showBorder ? theme.dividerColor : color),
      borderRadius: borderRadius,
    );

    return InkWell(
      borderRadius: borderRadius,
      onTap: onPressed != null ? () => onPressed() : null,
      child: Container(
        width: size,
        height: size,
        decoration: decoration,
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: background,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: isBorder,
      icon: Icon(icon, size: sizeIcon, color: color),
    );
  }
}

class _FlybuyButtonSocialFacebook extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialFacebook({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    this.boxFit = SocialBoxFit.fill,
    SocialType? type,
    double wRadius = 4,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon is IconData
              ? icon
              : boxFit == SocialBoxFit.outline
                  ? FontAwesomeIcons.facebookSquare
                  : FontAwesomeIcons.facebook,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = boxFit == SocialBoxFit.outline
        ? Colors.transparent
        : ColorBlock.facebook;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.facebook : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}

class _FlybuyButtonSocialGoogle extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialGoogle({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialType? type,
    double wRadius = 4,
    this.boxFit = SocialBoxFit.fill,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon is IconData
              ? icon
              : boxFit == SocialBoxFit.outline
                  ? FontAwesomeIcons.googlePlusG
                  : FontAwesomeIcons.googlePlus,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        boxFit == SocialBoxFit.outline ? Colors.transparent : ColorBlock.google;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.google : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}

class _FlybuyButtonSocialSms extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialSms({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialType? type,
    double wRadius = 4,
    this.boxFit = SocialBoxFit.fill,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.solidComment,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        boxFit == SocialBoxFit.outline ? Colors.transparent : ColorBlock.sms;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.sms : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}

class _FlybuyButtonSocialApple extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialApple({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialType? type,
    double wRadius = 4,
    this.boxFit = SocialBoxFit.fill,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.apple,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        boxFit == SocialBoxFit.outline ? Colors.transparent : ColorBlock.black;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.black : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}

class _FlybuyButtonSocialTwitter extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialTwitter({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialType? type,
    double wRadius = 4,
    this.boxFit = SocialBoxFit.fill,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.twitter,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = boxFit == SocialBoxFit.outline
        ? Colors.transparent
        : ColorBlock.twitter;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.twitter : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}

class _FlybuyButtonSocialPinterest extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialPinterest({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialType? type,
    double wRadius = 4,
    this.boxFit = SocialBoxFit.fill,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.pinterest,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = boxFit == SocialBoxFit.outline
        ? Colors.transparent
        : ColorBlock.pinterest;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.pinterest : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}

class _FlybuyButtonSocialLinkedIn extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialLinkedIn({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialType? type,
    double wRadius = 4,
    this.boxFit = SocialBoxFit.fill,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.linkedin,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = boxFit == SocialBoxFit.outline
        ? Colors.transparent
        : ColorBlock.linkedIn;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.linkedIn : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}

class _FlybuyButtonSocialYouTube extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialYouTube({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialType? type,
    double wRadius = 4,
    this.boxFit = SocialBoxFit.fill,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.youtube,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = boxFit == SocialBoxFit.outline
        ? Colors.transparent
        : ColorBlock.youtube;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.youtube : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}

class _FlybuyButtonSocialInstagram extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialInstagram({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialType? type,
    double wRadius = 4,
    this.boxFit = SocialBoxFit.fill,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.instagram,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = boxFit == SocialBoxFit.outline
        ? Colors.transparent
        : ColorBlock.instagram;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.instagram : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}

class _FlybuyButtonSocialSnapchat extends FlybuyButtonSocial {
  final SocialBoxFit boxFit;

  const _FlybuyButtonSocialSnapchat({
    Key? key,
    double? size,
    double? sizeIcon,
    VoidCallback? onPressed,
    IconData? icon,
    SocialType? type,
    double wRadius = 4,
    this.boxFit = SocialBoxFit.fill,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.snapchat,
          type: type ?? SocialType.circle,
          wRadius: wRadius,
        );

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = boxFit == SocialBoxFit.outline
        ? Colors.transparent
        : ColorBlock.snapChat;
    Color color =
        boxFit == SocialBoxFit.outline ? ColorBlock.snapChat : Colors.white;

    return buildContainer(
      context,
      size: size,
      color: backgroundColor,
      onPressed: onPressed,
      socialType: type,
      radius: wRadius,
      showBorder: boxFit == SocialBoxFit.outline,
      icon: Icon(icon, color: color, size: sizeIcon),
    );
  }
}
