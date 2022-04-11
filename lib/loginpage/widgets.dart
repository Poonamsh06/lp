import 'package:flutter/material.dart';


class TextWidget extends StatelessWidget {
  final text;
  TextWidget(String s, {Key? key})
      : text = s,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ));
  }
}