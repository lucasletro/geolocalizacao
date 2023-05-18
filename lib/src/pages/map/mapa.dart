import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  Set<Marker> _marcadores = {}; //lista objetos marcadores

  _exibirMarcador(LatLng latLng){

    Marker marcador = Marker(
      markerId: MarkerId("marcador-${latLng.longitude}-${latLng.longitude}"),
      position: LatLng(latLng.latitude, latLng.longitude),
      infoWindow: const InfoWindow(
        title: "marcador",
      ),

    );

    setState(() {
      _marcadores.add(marcador);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa"),
      ),

      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(-19.511221, -42.634916),
            zoom: 18,
          ),
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador, //ao manter pressionado exibe o marcador
          markers: _marcadores,
        ),
      ),

    );
  }
}
