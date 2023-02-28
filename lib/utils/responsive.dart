import 'package:flutter/material.dart';

class Responsive {
  static width(double givenHeight, BuildContext context) {
    var result = 390 / givenHeight; //screen width size of Iphone 12 pro(390px)
    return MediaQuery.of(context).size.width / result;
  }

  static height(double givenWidth, BuildContext context) {
    var result = 844 / givenWidth; //screen height  size of Iphone 12 pro(844px)
    return MediaQuery.of(context).size.height / result;
  }

  static fontSize(double givenFont, BuildContext context) {
    var result = 844 / givenFont;
    return MediaQuery.of(context).size.height / result;
  }

  static radiusSize(double givenRadius, BuildContext context) {
    var result = 844 / givenRadius;
    return MediaQuery.of(context).size.height / result;
  }

  static iconSize(double givenIconSize, BuildContext context) {
    var result = 844 / givenIconSize;
    return MediaQuery.of(context).size.height / result;
  }
}
