import 'package:flutter/material.dart';
import '../const.dart';

class CustomizedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double width;
  final double height;
  final bool rounded;

  const CustomizedButton({
    Key key,
    this.onPressed,
    this.text,
    this.width,
    this.height,
    this.rounded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return FlatButton(
      padding: EdgeInsets.symmetric(
        vertical: _width * 0.035,
        horizontal: _width * 0.12,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(rounded ? 40.0 : 0)),
      onPressed: onPressed,
      color: kColorBlack,
      minWidth: width ?? _width * 0.1,
      child: Text(
        text,
        style: mainStyle.copyWith(
          color: Colors.white,
          fontSize: _height * 0.03,
        ),
      ),
    );
  }
}