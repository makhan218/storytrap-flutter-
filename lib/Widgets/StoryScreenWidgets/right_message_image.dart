import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:storytrapflutter/Widgets/extensions.dart';
import 'package:synchronized/extension.dart';

class RightMessageImage extends StatelessWidget {
//  RightMessageImage({Key? key}) : super(key: key);

  // final double screenWidth;
  final String imageURL;
  final String name;
  final String nameColor;

  RightMessageImage(
      {required this.imageURL, required this.nameColor, required this.name});

  final customCacheManager = CacheManager(
    Config('CacheKey', stalePeriod: const Duration(days: 30)),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12,
                color: HexColor(nameColor),
              ),
            ),
          ),
          Flex(direction: Axis.vertical, children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  maxHeight: MediaQuery.of(context).size.height * 0.3),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Hero(
                  tag: "StoryScreenImage",
                  child: GestureDetector(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.3,
                      imageUrl: imageURL,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        color: Colors.black12,
                      ),
                      key: UniqueKey(),
                      cacheManager: customCacheManager,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed("/DetailScreenImage", arguments: imageURL);
                    },
                  ),
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
