import 'package:flutter/material.dart';
import 'obra.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 226, 255, 247)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lectura JSON'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Obra> obras = [];

  @override
  void initState() {
    super.initState();
    _verObras();
  }

  Future<void> _verObras() async {
    // Cambiar la carga del archivo XML a la carga del archivo JSON
    final jsonString = await DefaultAssetBundle.of(context).loadString('documento/obras.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    setState(() {
      // Utilizar los datos del JSON para construir la lista de obras
      obras = jsonData.map((obra) {
        return Obra(
          autor: obra['autor'],
          titulo: obra['titulo'],
          fecha_publicacion: obra['fecha_publicacion'],
          descripcion: obra['descripcion'],
          imagen: obra['imagen'],
        );
      }).toList();
    });
  }

  
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        
      decoration: const BoxDecoration(
        color: Color.fromARGB(159, 154, 169, 169),
        /*image: DecorationImage(
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1579541814924-49fef17c5be5?q=80&w=370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4), 
            BlendMode.dstATop,
            //BlendMode.darken,
          ),
        ),*/
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const NetworkImage(
                          'https://images.unsplash.com/photo-1549289524-06cf8837ace5?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cGludHVyYXN8ZW58MHx8MHx8fDA%3D',
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.9), 
                          BlendMode.dstATop,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'OBRAS ECUATORIANAS',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: [
                      Card(
                        color: Colors.grey[200],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 250,
                              width: double.infinity,
                              child: Image.network(
                                obras[index].imagen,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                obras[index].titulo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Autor: ${obras[index].autor}'),
                                  Text(
                                      'Fecha de Publicación: ${obras[index].fecha_publicacion}'),
                                  Text(
                                      'Descripción: ${obras[index].descripcion}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
                childCount: obras.length,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}