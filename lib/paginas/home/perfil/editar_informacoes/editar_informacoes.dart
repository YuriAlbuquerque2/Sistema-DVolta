import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Tela7EditarInformaEs extends StatefulWidget {
  const Tela7EditarInformaEs({super.key});

  @override
  State<Tela7EditarInformaEs> createState() => _Tela7EditarInformaEsState();
}

class _Tela7EditarInformaEsState extends State<Tela7EditarInformaEs> {
  final supabase = Supabase.instance.client;
  final TextEditingController nomeController = TextEditingController();
  //final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  bool carregando = false;

  Future<void> _atualizarDados() async {
    setState(() => carregando = true);

    try {
      // Pega o ID do usuário atualmente logado no Supabase
      final usuarioId = supabase.auth.currentUser?.id;

      if (usuarioId == null) {
        throw 'Usuário não autenticado!';
      }

      // Envia a atualização com os 3 campos
      await supabase
          .from('usuarios') // Substitua pelo nome da sua tabela
          .update({
            'nome': nomeController.text.trim(),
            //'email': emailController.text.trim(),
            'telefone': telefoneController.text.trim(),
          })
          .eq('id', usuarioId); // Atualiza apenas a linha deste usuário

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    } catch (erro) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $erro')),
      );
    } finally {
      setState(() => carregando = false);
    }
  }

  @override
  void dispose() {
    // Limpa os controladores quando a tela for fechada
    nomeController.dispose();
    //emailController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  File? fotoSelecionada;

  String? fotoPerfilUrl;

  Future<void> selecionarFoto() async {

  final imagem = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

    if (imagem != null) {
      setState(() {
        fotoSelecionada = File(imagem.path);
      });
    }
  }

  Future<String> uploadFotoPerfil() async {

    final userId = supabase.auth.currentUser!.id;

    final caminho = '$userId.jpg';

    await supabase.storage
        .from('avatars')
        .upload(
          caminho,
          fotoSelecionada!,
          fileOptions: const FileOptions(
            upsert: true,
          ),
        );

    return supabase.storage
        .from('avatars')
        .getPublicUrl(caminho);
  }

  Future<void> salvarFotoPerfil() async {

    if (fotoSelecionada == null) {
      return;
    }

    final url = await uploadFotoPerfil();

    await supabase
        .from('usuarios')
        .update({
          'foto_perfil': url,
        })
        .eq(
          'id',
          supabase.auth.currentUser!.id,
        );
  }

  Future<void> carregarFotoPerfil() async {

    final dados = await supabase
        .from('usuarios')
        .select('foto_perfil')
        .eq(
          'id',
          supabase.auth.currentUser!.id,
        )
        .single();

    setState(() {
      fotoPerfilUrl = dados['foto_perfil'];
    });
  }

  @override
  void initState() {
    super.initState();

    carregarFotoPerfil();
  }



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
          elevation: 0,
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
                    GestureDetector(
                      onTap: selecionarFoto,

                      child: Container(
                        width: 203,
                        height: 193,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFEADDFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                        ),

                        child: fotoSelecionada != null

                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                fotoSelecionada!,
                                fit: BoxFit.cover,
                              ),
                            )

                          : fotoPerfilUrl != null

                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                fotoPerfilUrl!,
                                fit: BoxFit.cover,
                              ),
                            )

                          : const Icon(
                              Icons.person,
                              size: 80,
                              color: Color(0xFF503D68),
                            ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Campo Nome
                    TextField(
                      controller: nomeController,
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

                    SizedBox(height: 40),
                    
                    // //Campo email
                    // TextField(
                    //   style: const TextStyle(color: Color(0xFFF0E8D5)),
                    //   decoration: InputDecoration(
                    //     labelText: 'Email',
                    //     labelStyle: const TextStyle(
                    //       color: Color(0xBFF0E8D5),
                    //       fontSize: 16,
                    //       fontFamily: 'Inter',
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //     filled: true,
                    //     fillColor: const Color(0xFF503D68),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: BorderSide.none,
                    //     ),
                    //   ),
                    // ),

                    // SizedBox(height: 40),

                    //Campo Número
                    TextField(
                      controller: telefoneController,
                      style: const TextStyle(color: Color(0xFFF0E8D5)),
                      decoration: InputDecoration(
                        labelText: 'Telefone',
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

                    const SizedBox(height: 150),

                    // Botão Atualizar
                    SizedBox(
                      width: 286,
                      height: 73,
                      child: carregando ? const CircularProgressIndicator() :
                      ElevatedButton(
                        onPressed: () async {
                          await _atualizarDados();
                          await salvarFotoPerfil();
                          await carregarFotoPerfil();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Foto atualizada'),
                            ),
                          );

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