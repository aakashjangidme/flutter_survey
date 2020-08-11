
import 'package:flutter/material.dart';

class RoundButon extends StatelessWidget {
  RoundButon({@required this.title, this.width = 150, this.onPressed});
  final String title;
  final double width;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: width,
      child: RaisedButton(
        child: Text(
          title,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
