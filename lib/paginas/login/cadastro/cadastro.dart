import 'package:flutter/material.dart';

class Tela2Cadastro extends StatefulWidget {
  const Tela2Cadastro({super.key});

  @override
  State<Tela2Cadastro> createState() => _Tela2Cadastro();
}

class _Tela2Cadastro extends State<Tela2Cadastro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container (
          width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/ui/imagens/Fundo.png'),
                      fit:BoxFit.cover, 
                    ),
                  ),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                 width: 412,
          height: 914,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.transparent),

          

          child: Stack(   
            children: [
              Positioned (
                 left: 91,
                 top: 105,
                child: Image.asset("lib/ui/imagens/Logo.png"),
               ),

              Positioned(
                left: 49,
                top: 291,
                child: Container(
                  width: 296,
                  height: 398,
                  decoration: ShapeDecoration(
                    color:  Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 240, 232, 213),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 82,
                top: 566,
                child: Container(
                  width: 242,
                  height: 31,
                  decoration: ShapeDecoration(
                    color: const Color(0x00F0E8D5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFF0E8D5),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 70,
                top: 535,
                child: SizedBox(
                  width: 180,
                  height: 26,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Confirmar',
                          style: TextStyle(
                            color: const Color(0xFFF0E8D5),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.40,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.40,
                          ),
                        ),
                        TextSpan(
                          text: 'senha',
                          style: TextStyle(
                            color: const Color(0xFFF0E8D5),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                left: 82,
                top: 491,
                child: Container(
                  width: 242,
                  height: 31,
                  decoration: ShapeDecoration(
                    color: const Color(0x00F0E8D5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFF0E8D5),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 70,
                top: 460,
                child: SizedBox(
                  width: 80,
                  height: 26,
                  child: Text(
                    'Senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 82,
                top: 416,
                child: Container(
                  width: 242,
                  height: 31,
                  decoration: ShapeDecoration(
                    color: const Color(0x00F0E8D5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFF0E8D5),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 70,
                top: 385,
                child: SizedBox(
                  width: 80,
                  height: 26,
                  child: Text(
                    'Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 82,
                top: 341,
                child: Container(
                  width: 242,
                  height: 31,
                  decoration: ShapeDecoration(
                    color: const Color(0x00F0E8D5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFF0E8D5),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 70,
                top: 310,
                child: SizedBox(
                  width: 80,
                  height: 26,
                  child: Text(
                    'Nome',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 628,
                child: SizedBox(
                  width: 144,
                  height: 26,
                  child: Text(
                    'Criar conta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF2E253A),
                      fontSize: 28,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.56,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
          ),
        ),
      ),
    );
  }
}