import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../extensions.dart';

class LeftMessageText extends StatelessWidget {
  // const LeftMessage({Key? key}) : super(key: key);

  Animation<double> parent;
  int index;
  Animation<double> animation;
  String name;
  String message;
  String bubbleColor;
  String nameTextColor;
  String contentTextColor;

  ValueChanged<int> tapHandler;

  LeftMessageText(
      {required BuildContext context,
      required this.index,
      required this.animation,
      required this.parent,
      required this.tapHandler,
      required this.name,
      required this.message,
      required this.bubbleColor,
      required this.contentTextColor,
      required this.nameTextColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ScaleTransition(
        key: UniqueKey(),
        scale: animation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                    color: HexColor(bubbleColor),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 12, color: HexColor(nameTextColor)),
                    ),
                    Text(
                      message,
                      style: TextStyle(color: HexColor(contentTextColor)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        tapHandler(index);
      },
    );
  }
}
