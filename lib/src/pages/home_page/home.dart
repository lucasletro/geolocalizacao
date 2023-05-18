import 'package:flutter/material.dart';

import '../map/mapa.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  final List _listaViagens = [
    "Cristo redentor",
    "Grande Muralha da China",
    "Taj Mahal",
    "Machu Pichu",
    "Coliseu",
  ];

  _abrirMapa(){

  }

  _excluirViagem(){

  }

  //usada no floatingActionButton
  _adicionarLocal(){
    Navigator.push(context, MaterialPageRoute(builder: (_) => Mapa()));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapas e Geolocalização"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          _adicionarLocal();
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          Expanded(

            child: ListView.builder(
              itemCount: _listaViagens.length,
              itemBuilder: (context, index){

                String titulo = _listaViagens[index];

                return GestureDetector(
                  onTap: (){
                    _abrirMapa();
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(titulo),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              _excluirViagem();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              },
            ),

          ),

        ],
      ),
    );
  }
}
