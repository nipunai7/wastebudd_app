import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wastebudd_app/Login/auth.dart';
import 'package:wastebudd_app/Models/user.dart';

class MyDrawer extends StatelessWidget {

  Color color;

  MyDrawer(this.color);
  @override
  Widget build(BuildContext context) {
    Color color = this.color;
    return Drawer(
      child: Container(
        color: color,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
            decoration: new BoxDecoration(
              color: color,
            ),
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(80.0),),
                    elevation: 8.0,
                    child: Container(
                      height: 160.0,
                      width: 160.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                         backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/wastebuddmobileapp.appspot.com/o/Images%2FProPics%2Fbear.png?alt=media&token=df61694a-1cfd-47df-b1b9-a3d752a64765"),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  // InkWell(
                  //   // child: Text(
                  //   //   Userbudd.sharedPreferences.getString(Userbudd.userName),style: TextStyle(fontFamily: "Signatra",fontSize: 30.0,color: Colors.white),
                  //   // ),
                  // )

                ],
              ),
          ),
          SizedBox(height: 6.0,),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            decoration: new BoxDecoration(
              color: color,
            ),
            child: Column(
              children: [
                Divider(height: 10.0,color: Colors.white,thickness: 6.0,),
                ListTile(
                  leading: Icon(Icons.logout,color: Colors.white,),
                  title: Text("Logout",style: TextStyle(color: Colors.white),),
                  onTap: (){
                    FirebaseAuth.instance.signOut().then((c){
                      Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
                Divider(height: 10.0,color: Colors.white,thickness: 6.0,),
              ],
            ),
          ),

        ],
      ),
      ),
    );
  }
}
