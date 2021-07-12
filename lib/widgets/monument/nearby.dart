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
            title: s.storeTitle,
            snippet: s.location,
          ),
        );
        _markers[s.storeTitle] = marker;
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
        body: GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(30.03333, 31.23334),
        zoom: 7.0,
      ),
      markers: _markers.values.toSet(),
    ));
  }
}
