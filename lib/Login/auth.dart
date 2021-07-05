import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastebudd_app/Login/signInPage.dart';
import 'package:wastebudd_app/Login/signup.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.0,
          backgroundColor: Colors.redAccent,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock,color: Colors.white,),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.person_add,color: Colors.white,),
                text: "Register",
              )
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 6.0,
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
              SignUpPage(),
              Register(),
            ],
          ),
        ),
      ),
    );
  }
}
