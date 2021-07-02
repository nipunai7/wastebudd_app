import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hint;
  final Function(String) onSave;
  final String Function(String) validator;
  final AutovalidateMode autoValidateMode;
  final TextEditingController textEditingController;
  final Widget icon;
  bool obscureText;

  CustomTextFormField(
      {this.labelText,
        this.hint,
        this.onSave,
        this.validator,
        this.autoValidateMode,
        this.textEditingController,
        this.icon,
        this.obscureText,});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: textEditingController,
            onSaved: onSave,
            validator: validator,
            obscureText: obscureText,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hint,
              border: InputBorder.none,
              prefixIcon: icon,
            ),
          )
        ],
      ),
    );
  }
}
