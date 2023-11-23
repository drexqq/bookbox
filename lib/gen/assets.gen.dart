/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/d1.jpeg
  AssetGenImage get d1 => const AssetGenImage('assets/images/d1.jpeg');

  /// File path: assets/images/e1.jpeg
  AssetGenImage get e1 => const AssetGenImage('assets/images/e1.jpeg');

  /// File path: assets/images/i1.jpeg
  AssetGenImage get i1 => const AssetGenImage('assets/images/i1.jpeg');

  /// File path: assets/images/i2.jpeg
  AssetGenImage get i2 => const AssetGenImage('assets/images/i2.jpeg');

  /// File path: assets/images/i3.jpeg
  AssetGenImage get i3 => const AssetGenImage('assets/images/i3.jpeg');

  /// File path: assets/images/i4.jpeg
  AssetGenImage get i4 => const AssetGenImage('assets/images/i4.jpeg');

  /// File path: assets/images/i5.jpeg
  AssetGenImage get i5 => const AssetGenImage('assets/images/i5.jpeg');

  /// File path: assets/images/i6.jpg
  AssetGenImage get i6 => const AssetGenImage('assets/images/i6.jpg');

  /// File path: assets/images/profile.jpeg
  AssetGenImage get profile =>
      const AssetGenImage('assets/images/profile.jpeg');

  /// File path: assets/images/s1.jpeg
  AssetGenImage get s1 => const AssetGenImage('assets/images/s1.jpeg');

  /// File path: assets/images/s2.jpeg
  AssetGenImage get s2 => const AssetGenImage('assets/images/s2.jpeg');

  /// File path: assets/images/s3.jpeg
  AssetGenImage get s3 => const AssetGenImage('assets/images/s3.jpeg');

  /// File path: assets/images/s4.jpeg
  AssetGenImage get s4 => const AssetGenImage('assets/images/s4.jpeg');

  /// List of all assets
  List<AssetGenImage> get values =>
      [d1, e1, i1, i2, i3, i4, i5, i6, profile, s1, s2, s3, s4];
}

class Assets {
  Assets._();

  static const String env = 'assets/.env';
  static const $AssetsImagesGen images = $AssetsImagesGen();

  /// List of all assets
  List<String> get values => [env];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
