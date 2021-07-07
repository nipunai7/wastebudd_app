import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastebudd_app/Screens/mapScreen.dart';

class SingleDustbinEco extends StatefulWidget {
  final String binName;
  final String moisture;
  final String temp;
  final String lastDate;
  final String weight;
  final Color color;
  final String status;

  const SingleDustbinEco(
      {Key key,
      this.temp,
      this.binName,
      this.lastDate,
      this.moisture,
      this.weight,
      this.color,
      this.status})
      : super(key: key);

  @override
  _SingleDustbinEcoState createState() => _SingleDustbinEcoState();
}

class _SingleDustbinEcoState extends State<SingleDustbinEco> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(icon: Icon(Icons.delete_forever_rounded,color: Colors.white,size: 34.0,))
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MapScreen()));
              },
            ),
            backgroundColor: widget.color,
            title: Row(mainAxisAlignment:MainAxisAlignment.center,children: [Text("Eco Bin Details  "),Icon(Icons.eco_rounded)],),
            centerTitle: true,
          ),
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(widget.binName,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w800,),textAlign: TextAlign.center,),
                ),
                Center(
                  child: Container(
                    height: 360.0,
                    width: 360.0,
                    child: Icon(
                      Icons.delete_rounded,
                      color: widget.color,
                      size: 300.0,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Last Collected Date: " + widget.lastDate,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Weight: " + widget.weight,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Status: " + widget.status,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Moisture: " + widget.moisture,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Temperature: " + widget.temp,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        // SizedBox(height: 30,),
                        // Container(
                        //   height: 50.0,
                        //     width: 140.0,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10.0),
                        //       color: widget.color
                        //     ),
                        //     child: TextButton(onPressed: (){}, child: Text("Locate",style: TextStyle(color: Colors.white,fontSize: 24.0),),
                        //     ),
                        // ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: widget.color
                      ),
                      child: TextButton(onPressed: (){}, child: Text("Modify",style: TextStyle(color: Colors.white,fontSize: 24.0),),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: widget.color
                      ),
                      child: TextButton(onPressed: (){}, child: Text("Locate",style: TextStyle(color: Colors.white,fontSize: 24.0),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MapScreen()));
        });
  }
}
