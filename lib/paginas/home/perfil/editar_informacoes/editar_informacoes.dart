import 'package:flutter/material.dart';

class Tela7EditarInformaEs extends StatefulWidget {
  const Tela7EditarInformaEs({super.key});

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
        image: DecorationImage(
          image: AssetImage('lib/ui/imagens/Fundo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFF503D68),
          elevation: 77,
          title: const Text('Minhas informações'),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            color: Color(0xFFF0E8D5),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Color(0xFFF0E8D5), size: 40),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: Column(
                  children: [

                    // Avatar
                    Container(
                      width: 203,
                      height: 193,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFEADDFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 80,
                        color: Color(0xFF503D68),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Campo Nome
                    TextField(
                      style: const TextStyle(color: Color(0xFFF0E8D5)),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: const TextStyle(
                          color: Color(0xBFF0E8D5),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF503D68),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 180),

                    // Botão Atualizar
                    SizedBox(
                      width: 286,
                      height: 73,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: lógica de atualizar
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF0E8D5),
                          foregroundColor: const Color(0xFF2E253A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),
                        ),
                        child: const Text(
                          'Atualizar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.40,
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
    );
  }
}