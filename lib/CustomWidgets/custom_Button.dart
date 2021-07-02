import 'package:flutter/material.dart';

import 'custom_Text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  Color fontColor;
  final Function() onPressed;
  Color borderColor;
  Color buttonColor;

  CustomButton({ this.text,this.fontColor,this.onPressed,this.borderColor,this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.2,
      height:MediaQuery.of(context).size.height/13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(color: borderColor),
      ),
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)
          ),
          padding: EdgeInsets.all(18.0),
          onPressed: onPressed,
          color: buttonColor,
          child: CustomText(
            text: text,
            color: fontColor,
            fontSize:16.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
