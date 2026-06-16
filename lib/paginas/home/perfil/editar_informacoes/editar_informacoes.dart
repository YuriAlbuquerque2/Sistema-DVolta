import 'package:flutter/material.dart';

class Tela7EditarInformaEs extends StatefulWidget {
  @override
  State<Tela7EditarInformaEs> createState() => _Tela7EditarInformaEsState();
}

class _Tela7EditarInformaEsState extends State<Tela7EditarInformaEs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
      image:DecorationImage(
        image: AssetImage('lib/ui/imagens/Fundo.png'),
        fit: BoxFit.cover,
      )
      ),
      child:Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 80, 61, 104),
          elevation: 77,
          title: Text('Minhas informações'),
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

        backgroundColor: Colors.transparent,
        body:SingleChildScrollView(
          child: Column(
      children: [
        Container( // Fundo da tela
          width: 412,
          height: 914,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://placehold.co/412x917"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned( //Barrinha do email
                left: 38,
                top: 301,
                child: Container(
                  width: 336,
                  height: 42,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 80, 61, 104),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned( //texto nome
                left: 47,
                top: 307,
                child: SizedBox(
                  width: 49,
                  height: 30,
                  child: Opacity(
                    opacity: 0.75,
                    child: Text(
                      'Nome',
                      style: TextStyle(
                        color: const Color(0xBFF0E8D5),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                        letterSpacing: -0.32,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned( //barra do email
                left: 38,
                top: 371,
                child: Container(
                  width: 336,
                  height: 42,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF503D68),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned( // Texto Email
                left: 47,
                top: 377,
                child: SizedBox(
                  width: 43,
                  height: 30,
                  child: Opacity(
                    opacity: 0.75,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: const Color(0xBFF0E8D5),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                        letterSpacing: -0.32,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned( //Botão atualizar
                left: 63,
                top: 512,
                child: Container(
                  width: 286,
                  height: 73,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF0E8D5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                ),
              ),
              Positioned( // texto atualizar
                left: 98,
                top: 532,
                child: SizedBox(
                  width: 215,
                  height: 33,
                  child: Text(
                    'Atualizar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF2E253A),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                ),
              ),
              Positioned( //Fotinha da minhoca
                left: 111,
                top: 93,
                child: Container(
                  width: 186,
                  height: 187,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 186,
                          height: 187,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/186x187"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ],
    )
    )
      )
    );
  }
}