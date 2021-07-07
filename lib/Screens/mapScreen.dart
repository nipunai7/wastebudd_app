import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wastebudd_app/CustomWidgets/myDrawer.dart';
import 'package:wastebudd_app/Models/direction_model.dart';
import 'package:wastebudd_app/Screens/singleDustbin.dart';
import 'package:wastebudd_app/Screens/singleDustbinEco.dart';

import '../direction_repo.dart';

class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 1;

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(6.9271, 79.8612),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Container(
        child: Scaffold(
          drawer: MyDrawer(Colors.green),
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Locate your bins"),
          ),
          body: mapView(),
        ),
      ),
      Container(
        child: Scaffold(
          drawer: MyDrawer(Colors.blueAccent),
          appBar: AppBar(
            title: Text("Your Dustbins"),
            actions: [
              IconButton(
                tooltip: "Add new",
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                iconSize: 30.0,
              ),
            ],
          ),
          body: ListView(
            children: [
              InkWell(
                onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SingleDustbin(binName: "Dustbin at Kelaniya",weight: "22KG",lastDate: "2021.05.30",color: Colors.green,status: "Normal",)));},
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dustbin at Kelaniya"),
                              leading: Icon(Icons.delete,color: Colors.green,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 70.0),
                                  child: Text("Weight:22KG")),                          )
                          ],
                        ))),
              )  ,
              InkWell(
                onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SingleDustbin(binName: "Dustbin at IM Department",weight: "42KG",lastDate: "2021.05.30",color: Colors.red,status: "Dustbin is almost full",)));},
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dustbin at IM Department"),
                              leading: Icon(Icons.delete,color: Colors.red,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 70.0),
                                  child: Text("Weight:42KG")),
                            )
                          ],
                        ))),
              ),
              InkWell(
                onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SingleDustbin(binName: "Dustbin at Home",weight: "18KG",lastDate: "2021.04.30",color: Colors.green,status: "Normal",)));},
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dustbin at Home"),
                              leading: Icon(Icons.delete,color: Colors.green,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 70.0),
                                  child: Text("Weight:18KG")),
                            )
                          ],
                        ))),
              ),
              InkWell(
                onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SingleDustbin(binName: "Dustbin at ICT Center",weight: "36KG",lastDate: "2020.12.30",color: Colors.orange,status: "Almost Full, No recent collections",)));},
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dustbin at ICT Center"),
                              leading: Icon(Icons.delete,color: Colors.orange,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 70.0),
                                  child: Text("Weight:36KG")),
                            )
                          ],
                        ))),
              )],
          ),
        ),
      ),
      Container(
        child: Scaffold(
          drawer: MyDrawer(Colors.redAccent),
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text("Alerts"),
          ),
          body: ListView(
            children: [
              InkWell(
                onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SingleDustbin(binName: "Dustbin at ICT Center: No recent collection",weight: "36KG",lastDate: "Last collected date: 2020.12.30",color: Colors.orange,)));},
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dustbin at ICT Center: No recent collection"),
                              leading: Icon(Icons.delete,color: Colors.orange,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 70.0),
                                  child: Text("Last collected date: 2020.12.30")),
                            )
                          ],
                        ))),
              )  ,
              Card(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Dustbin at IM Department: Almost full"),
                            leading: Icon(Icons.delete,color: Colors.red,),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 70.0),
                                child: Text("Last collected date: 2021.04.30")),
                          )
                        ],
                      ))),
              Card(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Dustbin at IT Center: Eco dustbin almost full"),
                            leading: Icon(Icons.delete,color: Colors.red,),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 70.0),
                                child: Text("Temp: 26.5C Moisture: 38% Weight:52KG")),
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
      Container(
        child: Scaffold(
          drawer: MyDrawer(Colors.green),
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Eco Bins"),
            actions: [
              IconButton(
                tooltip: "Add new",
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                iconSize: 30.0,
              ),
            ],
          ),
          body: ListView(
            children: [
              InkWell(
                onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SingleDustbinEco(binName: "Dustbin at Kelaniya",weight: "25KG",lastDate: "2020.12.30",color: Colors.green,moisture: "45%",temp: "25.4",status: "Normal",)));},
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dustbin at Kelaniya"),
                              leading: Icon(Icons.delete,color: Colors.green,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 70.0),
                                  child: Text("Temp: 25.4C Moisture: 45% Weight:25KG")),
                            ),
                          ],
                        ))),
              )  ,
              InkWell(
                onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SingleDustbinEco(binName: "Dustbin at Kelaniya Uni Botanical Garden",weight: "41KG",lastDate: "2021.06.30",color: Colors.deepOrangeAccent,moisture: "42%",temp: "26.3",status: "Dustbin is almost full",)));},
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dustbin at Kelaniya Uni Botanical Garden"),
                              leading: Icon(Icons.delete,color: Colors.deepOrangeAccent,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 70.0),
                                  child: Text("Temp: 26.3C Moisture: 42% Weight:41KG")),
                            ),
                          ],
                        ))),
              ),
              InkWell(
                onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SingleDustbinEco(binName: "Dustbin at IT Center",weight: "52KG",lastDate: "2020.12.30",color: Colors.red,moisture: "38%",temp: "26.5",status: "Dustbin is almost full",)));},
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dustbin at IT Center"),
                              leading: Icon(Icons.delete,color: Colors.red,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 70.0),
                                  child: Text("Temp: 26.5C Moisture: 38% Weight:52KG")),
                            ),
                          ],
                        ))),
              ),
              InkWell(
                onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SingleDustbinEco(binName: "Dustbin at playGround",weight: "32KG",lastDate: "2020.12.30",color: Colors.green,moisture: "37%",temp: "27.1",status: "Temperature is above average",)));},
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dustbin at playGround"),
                              leading: Icon(Icons.delete,color: Colors.green,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 70.0),
                                  child: Text("Temp: 27.1C Moisture: 37% Weight:32KG")),
                            ),
                          ],
                        ))),
              )],
          ),
        ),
      ),
    ];

    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_sharp),
            label: "Locations",
            backgroundColor: Colors.lightGreen,
            //activeIcon: Icon(Icons.store,color: Colors.white)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_forever),
            label: "Dustbins",
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_rounded),
            label: "Alerts",
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco_rounded),
            label: "Eco-Bins",
            backgroundColor: Colors.green,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Waste Budd Company'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: pos,
            onTap: () {
              _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              );
            });
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Dustbin'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos,
            onTap: () {
              _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              );
            });
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }

  mapView() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
            onLongPress: _addMarker,
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDistance}, ${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
