import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatefulWidget {
  final String url;
  final Widget Function(BuildContext, ImageProvider<dynamic>) imageBuilder;
  AppCachedImage({Key key, @required this.url, @required this.imageBuilder})
      : super(key: key);

  @override
  _AppCachedImageState createState() => _AppCachedImageState();
}

class _AppCachedImageState extends State<AppCachedImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url,
      placeholder: (context, url) {
        return widget.imageBuilder.call(
          context,
          AssetImage("assets/images/loading_image.gif"),
        );
      },
      errorWidget: (context, url, error) {
        return widget.imageBuilder.call(
          context,
          AssetImage("assets/images/default_image.jpg"),
        );
      },
    );
  }
}
