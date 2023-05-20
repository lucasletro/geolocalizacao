import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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


  CameraPosition _posicaoInicialCamera = const CameraPosition(
    target: LatLng(-19.511221, -42.634916),
    zoom: 18,
  );


  _exibirMarcador(LatLng latLng) async {

    //importar geocoding para usar placemark
    List<Placemark> listaEnderecos = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    if(listaEnderecos != null && listaEnderecos.length > 0){

      Placemark endereco = listaEnderecos[0];
      String rua = " ${endereco.thoroughfare}";

      Marker marcador = Marker(
        markerId: MarkerId("marcador-${latLng.longitude}-${latLng.longitude}"),
        position: LatLng(latLng.latitude, latLng.longitude),
        infoWindow: InfoWindow(
          title: rua,
        ),
      );

      setState(() {
        _marcadores.add(marcador);
      });

    }

  }


  _movimentarCamera() async {

    //recuperar o objeto googleMapController
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(_posicaoInicialCamera),
    );

  }


  //importar geolocator
  //funcao q vai ficar monitorando a localização do usuario
  _adicionarListenerLocalizacao(){

    var locationOptions = const LocationSettings(
      accuracy: LocationAccuracy.high, //precisao da localização
      //distanceFilter: 10, //se mover mais q 10 metros atualiza a localizaçao
    );

    //caso a localizaçao do usuario mude vamos receber este parametro
    //position com a nova localizaçao do usuario
    Geolocator.getPositionStream(locationSettings: locationOptions)
        .listen((Position position) {

      setState(() {
        //vamos recuperar a posição do usuario e em seguida
        //movimentar a camera para esta localização.
        _posicaoInicialCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 17
        );
        _movimentarCamera();
      });
    });

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _adicionarListenerLocalizacao();

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
          initialCameraPosition: _posicaoInicialCamera,
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador, //ao manter pressionado exibe o marcador
          markers: _marcadores,
          myLocationEnabled: true,//mostrar a localização do usuario
        ),
      ),

    );
  }
}
