import 'package:flutter/material.dart';

import 'custom_Text.dart';

class CustomButtonSocial extends StatelessWidget {
  final Function() onPress;
  final String text;
  Color borderColor;
  Color textColor;
  final String image;

  CustomButtonSocial(
      {this.onPress,this.text,this.borderColor,this.textColor,this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(color: borderColor),
      ),
      child: FlatButton(
          onPressed: onPress,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              Image.asset(image),
              SizedBox(
                width: 30,
              ),
              CustomText(
                text: text,
                color: textColor,
                fontWeight: FontWeight.bold,
              )
            ],
          )),
    );
  }
}
