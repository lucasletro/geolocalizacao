import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _listaViagens = [
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

  _adicionarLocal(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapas e Geolocalização"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: (){
          _adicionarLocal();
        },
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
                            child: Padding(
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
