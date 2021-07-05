import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wastebudd_app/CustomWidgets/custom_Text.dart';
import 'package:wastebudd_app/CustomWidgets/custom_TextFormField.dart';

import '../Screens/mapScreen.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _username=TextEditingController();
  TextEditingController _password=TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  topLeft: Radius.circular(50.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Waste Budd Logo
              Container(
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/wastebudd.png"))),
              ),

              //UserForm
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //User
                    Container(
                      width: MediaQuery.of(context).size.width*.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.shade200
                      ),
                      child: CustomTextFormField(
                          labelText: "Email",
                          hint: "Enter Your Email",
                          onSave: (value){

                          },
                          validator: (value) {
                            RegExp emailRegex = RegExp(
                                r'''^^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$''');
                            if (!emailRegex.hasMatch(value)) {
                              return "Enter a Valid email";
                            }
                            return "";
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          textEditingController: _username,
                          icon:Icon(FontAwesomeIcons.userCircle,color: Colors.redAccent,),
                          obscureText: false),
                    ),
                    SizedBox(height: 10.0,),
                    //Password
                    Container(
                      width: MediaQuery.of(context).size.width*.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.shade200
                      ),
                      child: CustomTextFormField(
                          labelText: "Password",
                          hint: "Enter Your Password",
                          onSave: (value){

                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password Can't be Empty";
                            } else if (value.length <= 6) {
                              return "Must be greater than 6";
                            }
                            return "";
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          textEditingController: _password,
                          icon:Icon(FontAwesomeIcons.lock,color: Colors.redAccent,),
                          obscureText: true),
                    )
                  ],
                ),
              ),

              //login Button
              FlatButton(
                  onPressed: () {
                    // _formKey.currentState!.save();
                    // if (_formKey.currentState!.validate()) {
                    //
                    // }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MapScreen()),
                    );

                  },
                  height: MediaQuery.of(context).size.height * .07,
                  minWidth: MediaQuery.of(context).size.width * .7,
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                    child: CustomText(
                      text: "Login",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
