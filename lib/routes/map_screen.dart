import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

 

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  // Definir las coordenadas (latitud y longitud)
final List<Location>locations =Get.arguments ;
  @override
  Widget build(BuildContext context) {
     final  place= locations[0].place;
  final LatLng _initialPosition = LatLng(place.lat, place.lng); // Ejemplo: San Francisco
    return Scaffold(
      appBar: AppBar(title: Text('Mapa en Flutter')),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition, // Coordenadas
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: MarkerId('initial_position'),
            position: _initialPosition,
            infoWindow: InfoWindow(title: 'Ubicación Inicial'),
          ),
        },
      ),
    );
  }
}