import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastebudd_app/CustomWidgets/customTextForm.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController _nametextcontroller = TextEditingController();
  final TextEditingController _passtextcontroller = TextEditingController();
  final TextEditingController _emailextcontroller = TextEditingController();
  final TextEditingController _cpasstextcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String userImgUrl = "";
  File _imageFile;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double _screenwidth = MediaQuery
        .of(context)
        .size
        .width,
        _screenheight = MediaQuery
            .of(context)
            .size
            .height;
    return SingleChildScrollView(
      child: Container(
        color: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0))),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 20.0,),
                InkWell(
                  onTap: null,
                  child: CircleAvatar(

                    radius: _screenwidth * 0.15,
                    backgroundColor: Colors.redAccent,
                    backgroundImage: _imageFile == null ? null : FileImage(
                        _imageFile),
                    child: _imageFile == null
                        ? Icon(Icons.add_photo_alternate, size: _screenwidth * 0.15,
                      color: Colors.white,)
                        : null,
                  ),
                ),
                SizedBox(height: 10.0,),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CustomTextForm(
                        controller: _nametextcontroller,
                        data: Icons.person_add,
                        hintText: "Name",
                        isObsecure: false,
                      ),
                      CustomTextForm(
                        controller: _emailextcontroller,
                        data: Icons.email,
                        hintText: "E-Mail",
                        isObsecure: false,
                      ),
                      CustomTextForm(
                        controller: _passtextcontroller,
                        data: Icons.lock,
                        hintText: "Password",
                        isObsecure: true,
                      ),
                      CustomTextForm(
                        controller: _cpasstextcontroller,
                        data: Icons.lock,
                        hintText: "Password",
                        isObsecure: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0,),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width * .7, height: MediaQuery.of(context).size.height * .07),
                  child: ElevatedButton(
                    onPressed: () {
                      //uploadAndSaveImage();
                    },
                    style: ElevatedButton.styleFrom(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      primary: Colors.redAccent,
                    ),
                    child: Text("Register",
                      style: TextStyle(color: Colors.white, fontSize: 20,),),
                  ),
                ),
                SizedBox(height: 22.0,),
                Container(
                  height: 4.0,
                  width: _screenwidth * 0.8,
                  color: Colors.white,
                ),
                SizedBox(height: 10.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}