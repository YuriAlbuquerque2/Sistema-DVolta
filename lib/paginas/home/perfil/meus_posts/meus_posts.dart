import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistema_dvolta/paginas/home/home.dart';
import 'package:sistema_dvolta/paginas/home/criar_post/post.dart';
import 'package:intl/intl.dart';

class Tela6meuspost extends StatefulWidget {
  const Tela6meuspost({super.key});

  @override
  State<Tela6meuspost> createState() => _Tela6meuspostState();
}

class _Tela6meuspostState extends State<Tela6meuspost> {

  final supabase = Supabase.instance.client;

  String nomeUsuario = '';
  String emailUsuario = '';
  String? fotoPerfilUrl;
  

  // Posts e filtro
  List<Map<String, dynamic>> posts = [];
  bool carregandoPosts = true;

  Future<void> carregarDadosUsuario() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final dados = await supabase
          .from('usuarios')
          .select('nome, foto_perfil')
          .eq('id', user.id)
          .single();

      if (!mounted) return;
      setState(() {
        nomeUsuario = dados['nome'] ?? '';
        fotoPerfilUrl = dados['foto_perfil'];
        emailUsuario = user.email ?? '';
      });
    } catch (e) {
      debugPrint('Erro ao carregar dados do usuário: $e');
    }
  }

  Future carregarPosts() async {
    setState(() => carregandoPosts = true);

    try {

      final user = supabase.auth.currentUser;

      if (user == null) return;

      final resultado = await supabase
          .from('posts')
          .select()
          .eq('usuario_id', user.id)
          .order('criado_em', ascending: false);

      List<Map<String, dynamic>> postsCompletos = [];

      for (final post in resultado) {

        final usuario = await supabase
            .from('usuarios')
            .select('nome, foto_perfil')
            .eq('id', post['usuario_id'])
            .single();

        final imagens = await supabase
            .from('post_imagens')
            .select()
            .eq('post_id', post['id'])
            .order('ordem');

        postsCompletos.add({
          'post': post,
          'usuario': usuario,
          'imagens': imagens,
        });
      }

      if (!mounted) return;

      setState(() {
        posts = postsCompletos;
      });

    } catch (e) {

      debugPrint('Erro ao carregar meus posts: $e');

    } finally {

      if (mounted) {
        setState(() => carregandoPosts = false);
      }

    }
  }

  String formatarDataBrasileira(String dataBanco) {

    final data =
        DateTime.parse(dataBanco)
            .toLocal();

    return DateFormat(
      'dd/MM/yyyy',
    ).format(data);
  }

  Future excluirPost(int postId) async {

    try {

      await supabase
          .from('posts')
          .delete()
          .eq('id', postId);

      carregarPosts();

    } catch (e) {

      debugPrint(
        'Erro ao excluir post: $e',
      );

    }
  }

  Widget construirPost(Map<String, dynamic> dados) {
    final post = dados['post'];
    final usuario = dados['usuario'];
    final imagens = dados['imagens'];

    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 80, 61, 104),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: usuario['foto_perfil'] != null
                      ? NetworkImage(usuario['foto_perfil'])
                      : null,
                  child: usuario['foto_perfil'] == null
                      ? const Icon(Icons.person)
                      : null,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usuario['nome'] ?? '',
                      style: const TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                    ),
                    Text(
                      post['tipo_post'] ?? '',
                      style: const TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  formatarDataBrasileira(
                    post['criado_em'],
                  ),
                  style: TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                ),
                PopupMenuButton<String>(
                  iconColor: Color.fromARGB(255, 240, 232, 213),
                  color: Color.fromARGB(255, 80, 61, 104),
                  onSelected: (value) {

                    if (value == 'editar') {
                      Navigator.pushReplacement(

                        context,

                        MaterialPageRoute(

                          builder: (_) => Tela4CriarPost(

                            postEditar: post,

                          ),

                        ),

                      );

                    }

                    if (value == 'excluir') {
                      showDialog(

                      context: context,

                      builder: (_) {

                        return AlertDialog(
                          backgroundColor: const Color.fromARGB(255, 80, 61, 104),

                          title: Text(
                            'Excluir post',
                            style: TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                          ),

                          content: Text(
                            'Tem certeza que deseja excluir este post?',
                            style: TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                          ),

                          actions: [

                            TextButton(

                              onPressed: () {

                                Navigator.pop(context);

                              },

                              child: Text('Cancelar',
                                style: TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                                ),
                            ),

                            TextButton(

                              onPressed: () async {

                                Navigator.pop(context);

                                await excluirPost(
                                  post['id'],
                                );

                              },

                              child: Text('Excluir',
                                style: TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'editar',
                      child: Text('Editar post',
                      style: TextStyle(color: Color.fromARGB(255, 240, 232, 213))),
                    ),
                    const PopupMenuItem(
                      value: 'excluir',
                      child: Text('Excluir post',
                      style: TextStyle(color: Color.fromARGB(255, 240, 232, 213))),
                    ),
                  ],
                ),

                
              ],
            ),
          ),
          if (imagens.isNotEmpty)
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: imagens.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    imagens[index]['url'],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              post['titulo'] ?? '',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 240, 232, 213),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              post['local'] ?? '',
              style: const TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              post['descricao'] ?? '',
              style: const TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    carregarDadosUsuario();
    carregarPosts();
  }

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
           ),
           Column(
            children: [
              Expanded(
                child: carregandoPosts
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {

                          return construirPost(
                            posts[index],
                          );

                        },
                      ),
              ),
            ],
           ),
        ],
      ), 
       
    );

  }
}