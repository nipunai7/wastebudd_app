import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wastebudd_app/Models/direction_model.dart';

import '../direction_repo.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 0;

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
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: Text("Locate your bins"),
          ),
          body: mapView(),
        ),
      ),
      Container(
        child: Scaffold(
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
              Card(

              )
            ],
          ),
        ),
      ),
      Center(
        child: Text("3rd One"),
      ),
      Center(
        child: Text("4th One"),
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
            backgroundColor: Colors.lightGreen,
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
