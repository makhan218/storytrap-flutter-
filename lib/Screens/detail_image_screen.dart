import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DetailImageScreen extends StatelessWidget {
  String imageUrl;
  DetailImageScreen({required this.imageUrl});
  // const DetailImageScreen({Key? key}) : super(key: key);

  final customCacheManager = CacheManager(
    Config('CacheKey', stalePeriod: Duration(days: 30)),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0x00707070),
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Hero(
            tag: "StoryScreenImage",
            child: CachedNetworkImage(
              fit: BoxFit.fitWidth,
              imageUrl: imageUrl,
              width: MediaQuery.of(context).size.width,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                color: Colors.black12,
              ),
              key: UniqueKey(),
              cacheManager: customCacheManager,
              // CircularProgressIndicator(
              //     value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
