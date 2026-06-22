import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sistema_dvolta/paginas/home/perfil/meus_posts/meus_posts.dart';
import 'package:sistema_dvolta/paginas/home/home.dart';

class Tela4CriarPost  extends StatefulWidget {

  final Map<String, dynamic>? postEditar;

  const Tela4CriarPost({
    super.key,
    this.postEditar,
  });

  @override
  State<Tela4CriarPost> createState() => _Tela4CriarPostState();
}

class _Tela4CriarPostState extends State<Tela4CriarPost> {
  bool get editando =>
  widget.postEditar != null;
  String telefoneUsuario = '';

  final supabase = Supabase.instance.client;
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController? telefoneController = TextEditingController();
  final TextEditingController? instaController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  Future<void> carregarTelefoneUsuario() async {

    final user = supabase.auth.currentUser;

    if (user == null) return;

    final dados = await supabase
        .from('usuarios')
        .select('telefone')
        .eq('id', user.id)
        .single();

    telefoneUsuario = dados['telefone'] ?? '';
  }

  @override
  void initState() {
    super.initState();

      carregarTelefoneUsuario();

      if (editando) {

        final post = widget.postEditar!;

        tituloController.text =
            post['titulo'] ?? '';

        descricaoController.text =
            post['descricao'] ?? '';

        localController.text =
            post['local'] ?? '';

        tipoSelecionado =
            post['tipo_post'] ?? 'Achado';

        whatsapp =
            post['whatsapp'] ?? false;

        instagram =
            post['instagram'] ?? false;

        telefoneController?.text =
            post['wzap_numero'] ?? '';

        instaController?.text =
            post['usuario_insta'] ?? '';
      }
  }

  List<File> imagensSelecionadas = [];

  Future<void> selecionarImagem() async {

    if (imagensSelecionadas.length >= 4) {
      return;
    }

    final XFile? imagem =
        await picker.pickImage(
          source: ImageSource.gallery,
        );

    if (imagem == null) return;

    setState(() {

      imagensSelecionadas.add(
        File(imagem.path),
      );

    });
  }

  Future<List<String>> uploadImagensPost() async {

    List<String> urls = [];

    for (int i = 0; i < imagensSelecionadas.length; i++) {

      final arquivo = imagensSelecionadas[i];

      final nomeArquivo =
        '${DateTime.now().millisecondsSinceEpoch}_$i.jpg';

      await supabase.storage
        .from('posts')
        .upload(
          nomeArquivo,
          arquivo,
        );

      final url = supabase.storage
        .from('posts')
        .getPublicUrl(nomeArquivo);

      urls.add(url);
    }

    return urls;
  }

  @override
  void dispose() {
    // Limpa os controladores quando a tela for fechada
    tituloController.dispose();
    telefoneController?.dispose();
    instaController?.dispose();
    descricaoController.dispose();
    localController.dispose();
    super.dispose();
  }

  String tipoSelecionado = 'Achado';

  final List<String> tipos = [
    'Achado',
    'Perdido',
  ];

  bool whatsapp = false;
  bool instagram = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 80, 61, 104),
        title: Text(
          editando
              ? 'Editar Post'
              : 'Criar Post',
        ),
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
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), // Marca o início do posicionamento dos elementos
                child: SingleChildScrollView(
                  child: Column( //Se usa Column para colocar coisas uma em baixo da outra
                    crossAxisAlignment: CrossAxisAlignment.start, // alinha "a esquerda"
                    children: [

                      SizedBox(height: 90), // espaçamento entre elementos

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

                              Positioned(
                                left: 10,
                                top: 35,
                                child: SizedBox(
                                  width: 310,
                                  height: 71,
                                  child: Row(
                                    children: [

                                      ...imagensSelecionadas.map(
                                        (imagem) => Container(
                                          margin: EdgeInsets.only(right: 8),
                                          width: 68,
                                          height: 70,

                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),

                                          child: Image.file(
                                            imagem,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      if (imagensSelecionadas.length < 4)

                                        Container(
                                          width: 68,
                                          height: 70,

                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),

                                          child: IconButton(
                                            onPressed: selecionarImagem,
                                            icon: Icon(Icons.add, color: Colors.black),
                                          ),
                                        ),
                                    ],
                                  ),
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

                                  // Expanded(
                                  //   child: Text(
                                  //     "Cuidado com as imagens colocadas...",
                                  //     style: TextStyle(
                                  //       color: Color.fromARGB(255, 240, 232, 213),
                                  //     ),
                                  //   ),
                                  // ),
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

                                setState(() {

                                  whatsapp = value ?? false;

                                  if (whatsapp && telefoneController!.text.isEmpty) {

                                    telefoneController?.text =
                                        telefoneUsuario;

                                  } else {

                                    telefoneController?.clear();

                                  }

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
                            
                            SizedBox(width: 5),
                           Expanded(
                            child: Visibility(
                              visible: whatsapp,
                              child: TextField(
                                controller: telefoneController,
                                keyboardType: TextInputType.number,
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

                          hintText: 'Número de contato',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(191, 240, 232, 213),
                          ),
                        ),
                            )
                              )
                           )
                             


                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Checkbox(
                              value: instagram, 
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onChanged: (bool? value) {
                                setState((){
                                  instagram = value ?? false;
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
                              "Instagram",
                              style: TextStyle(
                              color: Color.fromARGB(255, 240, 232, 213),
                              fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 5),
                           Expanded(
                            child: Visibility(
                              visible: instagram,
                              child: TextField(
                                controller: instaController,
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

                          hintText: '@ do Instagram',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(191, 240, 232, 213),
                          ),
                        ),
                            )
                              )
                           )
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

                            if (!whatsapp && !instagram) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Escolha uma forma de contato."),
                                ),
                              );
                              return;
                            }

                            if (whatsapp && telefoneController!.text.trim().isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Informe seu número do WhatsApp para contato."),
                                ),
                              );
                              return;
                            }

                            if (instagram && instaController!.text.trim().isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Informe seu usuário do Instagram para contato."),
                                ),
                              );
                              return;
                            }

                            if (whatsapp || instagram) {
                              try {
                                if (editando) {
                                   await supabase
                                      .from('posts')
                                      .update({

                                        'titulo': tituloController.text,

                                        'descricao': descricaoController.text,

                                        'tipo_post': tipoSelecionado,

                                        'local': localController.text,

                                        'whatsapp': whatsapp,

                                        'instagram': instagram,

                                        'wzap_numero':
                                            telefoneController!.text,

                                        'usuario_insta':
                                            instaController!.text,

                                      })
                                      .eq(
                                        'id',
                                        widget.postEditar!['id'],
                                      );
                                } else {
                                final postCriado =
                                  await supabase
                                    .from('posts')
                                    .insert({
                                      'titulo': tituloController.text,
                                      'descricao': descricaoController.text,
                                      'tipo_post': tipoSelecionado,
                                      'local': localController.text,
                                      'whatsapp': whatsapp,
                                      'instagram': instagram,
                                      'usuario_id': supabase.auth.currentUser!.id,
                                      'wzap_numero': telefoneController!.text,
                                      'usuario_insta': instaController!.text,
                                    })
                                    .select()
                                    .single();
                                

                                    final postId = postCriado['id'];
                                

                                    final urls =
                                      await uploadImagensPost();

                                      for (int i = 0; i < urls.length; i++) {

                                        await supabase
                                            .from('post_imagens')
                                            .insert({
                                              'post_id': postId,
                                              'url': urls[i],
                                              'ordem': i + 1,
                                            });
                                      }
                                }
                                } catch (e) {
                                    print(e);
                                  }

                              print(supabase.auth.currentUser?.id);           

                              if (editando) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Tela6meuspost())
                              );
                              } else {
                                Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Tela3Feed())
                              );
                              }
                            }
                          }, 
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(250, 60),
                            backgroundColor: Color.fromARGB(255, 240, 232, 213),
                            foregroundColor: Color.fromARGB(255, 46, 37, 58),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            editando
                            ? "Salvar"
                            : "Enviar",
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