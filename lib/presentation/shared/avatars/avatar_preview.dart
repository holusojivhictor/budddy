import 'package:buddy/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarPreview extends StatelessWidget {
  final String image;
  final String label;
  final double height;
  final Decoration? decoration;
  final EdgeInsets? padding;
  final bool isSvg;

  const AvatarPreview({
    Key? key,
    required this.image,
    required this.label,
    this.height = 56,
    this.decoration,
    this.padding,
    this.isSvg = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final svgChild = SvgPicture.network(
      image,
      semanticsLabel: label,
      placeholderBuilder: (ctx) => const CupertinoActivityIndicator(),
    );

    return ClipOval(
      child: Container(
        height: height,
        width: height,
        decoration: decoration ?? const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.grey2,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(3),
          child: Semantics(
            label: label,
            child: isSvg ? svgChild : CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              placeholder: (ctx, url) => const CupertinoActivityIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
