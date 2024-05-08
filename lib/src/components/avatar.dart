import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      {super.key,
      required this.minRadius,
      required this.fontSize,
      required this.dpURL,
      required this.maxRadius});
  final String dpURL;
  final double minRadius;
  final double maxRadius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    if (isURL(dpURL)) {
      return CircleAvatar(
        minRadius: minRadius,
        maxRadius: maxRadius,
        backgroundImage: NetworkImage(dpURL),
      );
    } else {
      List<String> list = dpURL.split(" ");
      return CircleAvatar(
        minRadius: minRadius,
        maxRadius: maxRadius,
        child: Text(
          list[0].characters.first + list.last.characters.first,
          style: TextStyle(fontSize: fontSize),
        ),
      );
    }
  }
}

bool isURL(String s) {
  return s.startsWith(RegExp(r'http(s)://'));
}
