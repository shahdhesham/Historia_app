import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ui_gp/providers/monuments.dart';
import 'package:ui_gp/screens/crudmonument.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  Maps(this.monumentId);
  final String monumentId;

  @override
  _MapsState createState() => _MapsState(monumentId);
}

class _MapsState extends State<Maps> {
  _MapsState(this.storeid);
  GoogleMapController mapController;
  final String storeid;

  final Map<String, Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    final loadedMaps = Provider.of<Monuments>(
      context,
      listen: false,
    ).findById(storeid);
    mapController = controller;
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(loadedMaps.monumentName),
        position: LatLng(loadedMaps.latitude, loadedMaps.longitude),
        infoWindow: InfoWindow(
          title: loadedMaps.monumentName,
          snippet: loadedMaps.location,
        ),
      );
      _markers[loadedMaps.monumentName] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loadedMaps = Provider.of<Monuments>(
      context,
      listen: false,
    ).findById(storeid);
    final _center = LatLng(loadedMaps.latitude, loadedMaps.longitude);
    return Scaffold(
        body: GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
      markers: _markers.values.toSet(),
    ));
  }
}
