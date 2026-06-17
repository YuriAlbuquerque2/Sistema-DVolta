import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:sistema_dvolta/paginas/home/home.dart';

class Tela4CriarPost  extends StatefulWidget {
  const Tela4CriarPost({super.key});

  @override
  State<Tela4CriarPost> createState() => _Tela4CriarPostState();
}

class _Tela4CriarPostState extends State<Tela4CriarPost> {
  final supabase = Supabase.instance.client;
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController localController = TextEditingController();

  String tipoSelecionado = 'Achado';

  final List<String> tipos = [
    'Achado',
    'Perdido',
  ];

  bool whatsapp = false;
  bool telegram = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 80, 61, 104),
        title: const Text('Post'),
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

      body: Stack ( // Se usa Stack para colocar coisas uma em cima da outra
          children: [
            Container( //FUNDO
              width: double.infinity,
              height: double.infinity, 
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/ui/imagens/Fundo.png"),
                  fit: BoxFit.cover,
                )
                
              ),
              
              
              ),

            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 38), // Marca o início do posicionamento dos elementos
                child: SingleChildScrollView(
                  child: Column( //Se usa Column para colocar coisas uma em baixo da outra
                    crossAxisAlignment: CrossAxisAlignment.start, // alinha "a esquerda"
                    children: [

                      Text( // Texto "Tipo de post"
                        "Tipo de post",
                        style: TextStyle(
                          color: Color.fromARGB(255, 240, 232, 213),
                          fontSize: 20,
                        ),
                      ),
                      
                      DropdownButtonFormField<String>( // Seleção do tipo de post
                        initialValue: tipoSelecionado,

                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                          color: Colors.black,
                        ),

                        dropdownColor: const Color.fromARGB(255, 80, 61, 104),

                        style: const TextStyle(
                          color: Color.fromARGB(255, 240, 232, 213),
                          fontSize: 16,
                        ),

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 80, 61, 104),

                          // labelText: 'Tipo de post',

                          // labelStyle: const TextStyle(
                          //   color: Color.fromARGB(255, 240, 232, 213),
                          //   fontSize: 20,
                          // ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 80, 61, 104),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 80, 61, 104),
                            ),
                          ),
                        ),

                        items: tipos.map((tipo) {
                          return DropdownMenuItem<String>(
                            value: tipo,
                            child: Text(tipo),
                          );
                        }).toList(),

                        onChanged: (String? novoTipo) {
                          setState(() {
                            tipoSelecionado = novoTipo!;
                          });
                        },
                      ),

                      SizedBox(height: 30), // espaçamento entre elementos

                      TextField( // Campo de título
                        controller: tituloController,
                        style: TextStyle(
                          color: Color.fromARGB(255, 240, 232, 213),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 80, 61, 104),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 80, 61, 104),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 240, 232, 213),
                          ),
                        ),

                          hintText: 'Título',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(191, 240, 232, 213),
                            
                          ),
                        ),
                      ),

                      SizedBox(height: 10), // espaçamento entre elementos

                      SizedBox(
                        width: 336,
                        height: 168,
                        child: TextField( // Campo de descrição
                          controller: descricaoController,
                          textAlignVertical: TextAlignVertical.top,
                          maxLines: null,
                          expands: true,
                          style: TextStyle(
                            color: Color.fromARGB(255, 240, 232, 213),
                        ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 80, 61, 104),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 80, 61, 104),
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 240, 232, 213),
                            ),
                          ),

                            hintText: 'Descrição (Lembre-se de incluir detalhes como data e hora em que o item foi encontrado ou perdido)',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(191, 240, 232, 213),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30), // espaçamento entre elementos

                      Container( // Campo de imagens
                        width: 336,
                        height: 153,
                        decoration: ShapeDecoration(
                          color: Color.fromARGB(255, 80, 61, 104),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color.fromARGB(255, 80, 61, 104),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        
                        child: Padding (
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const SizedBox(height: 2),

                              Text( // Texto de imagens
                                "Imagem(ns) (Máx 4)",
                                style: TextStyle(
                                  color: Color.fromARGB(191, 240, 232, 213),
                                  fontSize: 15,
                                ),
                                ),

                              const SizedBox(height: 15),

                              Container( // Quadrado de adição de imagem
                                width: 70,
                                height: 70,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                    width: 1,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                  color: Colors.black,
                                ),
                              ),

                              SizedBox(height: 10),

                              Row( // Aviso sobre as imagens - se usa Row para colocar as coisas uma do lado da outra
                                children: [

                                  Icon(
                                    Icons.warning_amber_rounded, 
                                    color: Color.fromARGB(255, 240, 232, 213)
                                  ),

                                  SizedBox(width: 1),

                                  Expanded(
                                    child: Text(
                                      "Cuidado com as imagens colocadas...",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 240, 232, 213),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      TextField( // Campo de localidade
                        controller: localController,
                        style: TextStyle(
                          color: Color.fromARGB(255, 240, 232, 213),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 80, 61, 104),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 80, 61, 104),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 240, 232, 213),
                          ),
                        ),

                          hintText: 'Local onde foi achado/perdido',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(191, 240, 232, 213),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        "Contato",
                        style: TextStyle(
                          color: Color.fromARGB(255, 240, 232, 213),
                          fontSize: 18,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Checkbox(
                              value: whatsapp, 
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onChanged: (bool? value) {
                                setState((){
                                  whatsapp = value ?? false;
                                });
                              },
                              checkColor: Color.fromARGB(255, 80, 61, 104),
                              activeColor: Color.fromARGB(255, 240, 232, 213),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 240, 232, 213),
                                width: 2,
                              ),
                            ),
                            SizedBox(width: 1),
                            const Text(
                              "WhatsApp",
                              style: TextStyle(
                              color: Color.fromARGB(255, 240, 232, 213),
                              fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Checkbox(
                              value: telegram, 
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onChanged: (bool? value) {
                                setState((){
                                  telegram = value ?? false;
                                });
                              },
                              checkColor: Color.fromARGB(255, 80, 61, 104),
                              activeColor: Color.fromARGB(255, 240, 232, 213),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 240, 232, 213),
                                width: 2,
                              ),
                            ),
                            SizedBox(width: 1),
                            const Text(
                              "Telegram",
                              style: TextStyle(
                              color: Color.fromARGB(255, 240, 232, 213),
                              fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {

                            if (tituloController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Digite um título"),
                                ),
                              );
                              return;
                            }

                            if (descricaoController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Digite uma descrição sobre o item que foi $tipoSelecionado"),
                                ),
                              );
                              return;
                            }

                            if (localController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Informe o local que o item foi $tipoSelecionado"),
                                ),
                              );
                              return;
                            }

                            await supabase.from('post').insert({
                              'titulo': tituloController.text.trim(),
                              'descricao': descricaoController.text.trim(),
                              'tipo_post': tipoSelecionado,
                              'local': localController.text.trim(),
                              'whatsapp': whatsapp,
                              'telegram': telegram,
                              'usuario_id': supabase.auth.currentUser!.id,
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Tela3Feed())
                            );
                          }, 
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(250, 60),
                            backgroundColor: Color.fromARGB(255, 240, 232, 213),
                            foregroundColor: Color.fromARGB(255, 46, 37, 58),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Enviar",
                            style: TextStyle(
                              fontSize: 20,
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
    
    );

      

  }
}