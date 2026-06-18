import 'package:flutter/material.dart';

import 'package:sistema_dvolta/paginas/home/home.dart';

class Tela6meuspost extends StatefulWidget {
  const Tela6meuspost({super.key});

  @override
  State<Tela6meuspost> createState() => _Tela6meuspostState();
}

class _Tela6meuspostState extends State<Tela6meuspost> {

  @override
  Widget build(BuildContext context) {

  return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 80, 61, 104),
        title: const Text('Meus Posts'),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 240, 232, 213)
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 240, 232, 213), size: 40),
          ),
       ),

      body: Stack ( 
        children: [
           Container( //FUNDO
              width: double.infinity,
              height: double.infinity, 
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/ui/imagens/Fundo.png"),
                  fit: BoxFit.cover,
                )
              )
           )
        ],
      ), 
       
    );

  }
}