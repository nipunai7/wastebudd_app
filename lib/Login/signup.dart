import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastebudd_app/CustomWidgets/customTextForm.dart';
import 'package:wastebudd_app/CustomWidgets/errorDialog.dart';
import 'package:wastebudd_app/CustomWidgets/loadingDialog.dart';
import 'package:wastebudd_app/Models/user.dart';
import 'package:wastebudd_app/Screens/mapScreen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register> {
  final TextEditingController _nametextcontroller = TextEditingController();
  final TextEditingController _passtextcontroller = TextEditingController();
  final TextEditingController _emailextcontroller = TextEditingController();
  final TextEditingController _cpasstextcontroller = TextEditingController();
  final TextEditingController _userpackagetextcontroller = TextEditingController();
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20.0,),
            InkWell(
              onTap: _selectImage,
              child: CircleAvatar(
                radius: _screenwidth * 0.15,
                backgroundColor: Colors.white,
                backgroundImage: _imageFile == null ? null : FileImage(
                    _imageFile),
                child: _imageFile == null
                    ? Icon(Icons.add_photo_alternate, size: _screenwidth * 0.15,
                  color: Colors.grey,)
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
                  CustomTextForm(
                    controller: _userpackagetextcontroller,
                    data: Icons.monetization_on_sharp,
                    hintText: "Package No:",
                    isObsecure: false,
                  )
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            ElevatedButton(
              onPressed: () {
                uploadAndSaveImage();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: Text("Register",
                style: TextStyle(color: Colors.deepPurple, fontSize: 20,),),
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
    );
  }

  Future<void> _selectImage() async {
    _imageFile = (await picker.getImage(source: ImageSource.camera,
      maxWidth: 970.0,
      maxHeight: 680.0,
      preferredCameraDevice: CameraDevice.rear,)) as File;
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(message: "Please Select an Image",);
          }
      );
    } else {
      _passtextcontroller.text == _cpasstextcontroller.text
          ? _emailextcontroller.text.isNotEmpty &&
          _passtextcontroller.text.isNotEmpty &&
          _cpasstextcontroller.text.isNotEmpty &&
          _nametextcontroller.text.isNotEmpty &&
          _userpackagetextcontroller.text.isNotEmpty

          ? uploadtoStorage()

          : displayDialog("Please fill the required info")

          : displayDialog("Passwords do not match");
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(message: msg,);
        }
    );
  }

  uploadtoStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(message: "Registering, Please wait.....",);
        });

    String imageName = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();

    Reference storageReference = FirebaseStorage.instance.ref().child(
        imageName);

    UploadTask storageUploadTask = storageReference.putFile(_imageFile);

    TaskSnapshot taskSnapshot = await storageUploadTask;

    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImgUrl = urlImage;

      _regUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _regUser() async {
    User firebaseUser;

    await _auth.createUserWithEmailAndPassword(
      email: _emailextcontroller.text.trim(),
      password: _passtextcontroller.text.trim(),
    ).then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(message: error.message.toString(),);
          }
      );
    });

    if (firebaseUser != null) {
      saveUsertoFirebase(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => MapScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUsertoFirebase(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "jdate": DateTime.now().toString(),
      "email": fUser.email,
      "name": _nametextcontroller.text.trim(),
      "url": userImgUrl,
      "userpkg": _userpackagetextcontroller.text.trim(),
      // Userbudd.userCartList: ["garbageValue"],
      Userbudd.items: ["garbageValue"],
    });

    await Userbudd.sharedPreferences.setString("uid", fUser.uid);
    await Userbudd.sharedPreferences.setString("email", fUser.email);
    await Userbudd.sharedPreferences.setString(
        "name", _nametextcontroller.text.trim());
    await Userbudd.sharedPreferences.setString("url", userImgUrl);
    await Userbudd.sharedPreferences.setString(
        "userpkg", _userpackagetextcontroller.text.trim());
    // await Userbudd.sharedPreferences.setStringList(Userbudd.Userbudd, ["garbageValue"]);
    await Userbudd.sharedPreferences.setStringList(
        Userbudd.items, ["garbageValue"]);
    await Userbudd.sharedPreferences.setString(
        "jdate", DateTime.now().toString());
  }
}