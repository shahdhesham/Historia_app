import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ui_gp/models/monument.dart';
import 'package:ui_gp/providers/monuments.dart';

class NearbyMaps extends StatefulWidget {
  @override
  _NearbyMapsState createState() => _NearbyMapsState();
}

class _NearbyMapsState extends State<NearbyMaps> {
  GoogleMapController mapController;
  var loadedMaps;
  final Map<String, Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    loadedMaps = Provider.of<Monuments>(
      context,
      listen: false,
    ).returnAll();

    mapController = controller;
    setState(() {
      _markers.clear();
      for (final s in loadedMaps) {
        final marker = Marker(
          markerId: MarkerId(s.monumentName),
          position: LatLng(s.latitude, s.longitude),
          infoWindow: InfoWindow(
            title: s.monumentName,
            snippet: s.location,
          ),
        );
        _markers[s.monumentName] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    loadedMaps = Provider.of<Monuments>(
      context,
      listen: false,
    ).returnAll;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Nearby Monuments",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(31.257, 30.0327),
            zoom: 15.0,
          ),
          markers: _markers.values.toSet(),
        ));
  }
}
