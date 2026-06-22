import 'package:flutter/material.dart';
import 'package:sistema_dvolta/paginas/login/main.dart';
import 'package:sistema_dvolta/paginas/home/criar_post/post.dart';
import 'package:sistema_dvolta/paginas/home/perfil/perfil.dart';
import 'package:sistema_dvolta/paginas/home/perfil/meus_posts/meus_posts.dart';
import 'package:sistema_dvolta/paginas/home/perfil/editar_informacoes/editar_informacoes.dart';
import 'package:sistema_dvolta/ui/widgets/search.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class Tela3Feed extends StatefulWidget {
  const Tela3Feed({super.key});

  @override
  State<Tela3Feed> createState() => _Tela3FeedState();
}

class _Tela3FeedState extends State<Tela3Feed> {

  String nomeUsuario = '';
  String emailUsuario = '';
  String? fotoPerfilUrl;

  // Posts e filtro
  List<Map<String, dynamic>> posts = [];
  bool carregandoPosts = true;
  String? filtroSelecionado; // null = mostra todos

  Future<void> carregarDadosUsuario() async {
    print('carregarDadosUsuario chamado');
    final inicio = DateTime.now();
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final dados = await supabase
          .from('usuarios')
          .select('nome, foto_perfil')
          .eq('id', user.id)
          .single();

      if (!mounted) return;
      print(
  'carregarDadosUsuario: ${DateTime.now().difference(inicio).inMilliseconds} ms'
);
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
  final resultado = await supabase
      .from('posts')
      .select()
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
  debugPrint('Erro ao carregar posts: $e');
} finally {
  if (mounted) setState(() => carregandoPosts = false);
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

  // Aplica o filtro Achado/Perdido sobre a lista de posts
  List<Map<String, dynamic>> get postsFiltrados {
    

    return posts.where((dados) {
      final tipoPost = dados['post']['tipo_post'];
      final titulo =  (dados['post']['titulo'] ?? '').toString().toLowerCase();
      final descricao = (dados['post']['descricao'] ?? '').toString().toLowerCase();
      final local = (dados['post']['local'] ?? '').toString().toLowerCase();
      final pesquisa = searchQuery.toLowerCase();

      final correspondeTipo =
        filtroSelecionado == null ||
        tipoPost == filtroSelecionado;

        final correspondePesquisa =
        pesquisa.isEmpty ||
        titulo.contains(pesquisa) || descricao.contains(pesquisa)|| local.contains(pesquisa);
        
      return correspondeTipo && correspondePesquisa;
    }).toList();
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
                  style: const TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               IconButton(
                      icon: Icon(Icons.chat, color: Color.fromARGB(255, 240, 232, 213), size: 30),
                      onPressed: () {

                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Color.fromARGB(255, 80, 61, 104),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Contato',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 240, 232, 213),
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    if (post['wzap_numero'].toString().isNotEmpty && post['wzap_numero'] != null)
                                      Text('WhatsApp: ${post['wzap_numero']}',
                                        style: TextStyle(color: Color.fromARGB(255, 240, 232, 213),)),

                                    const SizedBox(height: 10),

                                    if (post['usuario_insta'].toString().isNotEmpty && post['usuario_insta'] != null)
                                      Text('Instagram: ${post['usuario_insta']}',
                                        style: TextStyle(color: Color.fromARGB(255, 240, 232, 213),)),

                                    if ((post['usuario_insta'].toString().isEmpty || post['usuario_insta'] == null) && (post['wzap_numero'].toString().isEmpty || post['wzap_numero'] == null))
                                      Text('Nenhum contato informado',
                                        style: TextStyle(color: Color.fromARGB(255, 240, 232, 213),)),


                                    const SizedBox(height: 20),

                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 240, 232, 213),
                                        foregroundColor: Color.fromARGB(255, 46, 37, 58),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Fechar'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
              
              const SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }

  bool isSearchClicked = false;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  
  @override
  void dispose() {
    // Limpa os controladores quando a tela for fechada
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 240, 232, 213)),
        backgroundColor: const Color.fromARGB(255, 80, 61, 104),
        elevation: 0,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 46, 37, 58),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value){
                    setState((){

                      searchQuery = value;
                    }

                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Pesquisar...',
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 46, 37, 58),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  style: const TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                )
            )
            : const Text('DVolta'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 240, 232, 213),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchClicked = !isSearchClicked;
                if (!isSearchClicked) {
                  _searchController.clear();
                 
                }
              });
            },
            icon: Icon(
              isSearchClicked ? Icons.close : Icons.search,
              color: const Color.fromARGB(255, 240, 232, 213),
              size: 30,
            ),
          ),

          // Botão de filtro Achado/Perdido — agora funcional
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                // Clicar de novo no mesmo filtro desativa (mostra tudo)
                filtroSelecionado = (filtroSelecionado == value) ? null : value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Achado',
                child: Row(
                  children: [
                    if (filtroSelecionado == 'Achado')
                      const Icon(Icons.check, size: 18, color: Color.fromARGB(255, 240, 232, 213)),
                    if (filtroSelecionado == 'Achado') const SizedBox(width: 6),
                    const Text('Achado', style: TextStyle(color: Color.fromARGB(255, 240, 232, 213))),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Perdido',
                child: Row(
                  children: [
                    if (filtroSelecionado == 'Perdido')
                      const Icon(Icons.check, size: 18, color: Color.fromARGB(255, 240, 232, 213)),
                    if (filtroSelecionado == 'Perdido') const SizedBox(width: 6),
                    const Text('Perdido', style: TextStyle(color: Color.fromARGB(255, 240, 232, 213))),
                  ],
                ),
              ),
            ],
            icon: Icon(
              Icons.filter_alt,
              color: filtroSelecionado != null
                  ? Colors.amber
                  : const Color.fromARGB(255, 240, 232, 213),
              size: 30,
            ),
            color: const Color.fromARGB(255, 80, 61, 104),
          ),
        ],
      ),

      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 46, 37, 58),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 80, 61, 104),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: fotoPerfilUrl != null
                            ? NetworkImage(fotoPerfilUrl!)
                            : null,
                        child: fotoPerfilUrl == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      nomeUsuario,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 240, 232, 213),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      emailUsuario,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 240, 232, 213),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.turned_in, color: Color.fromARGB(255, 240, 232, 213)),
                title: const Text('Meus posts'),
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 240, 232, 213),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tela6meuspost()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Color.fromARGB(255, 240, 232, 213)),
                title: const Text('Perfil'),
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 240, 232, 213),
                ),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tela5Perfil()),
                  );
                  carregarDadosUsuario();
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.settings, color: Color.fromARGB(255, 240, 232, 213)),
              //   title: const Text('Configurações'),
              //   titleTextStyle: const TextStyle(
              //     fontSize: 20,
              //     color: Color.fromARGB(255, 240, 232, 213),
              //   ),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.logout, color: Color.fromARGB(255, 240, 232, 213)),
                title: const Text('Sair'),
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 240, 232, 213),
                ),
                onTap: () async {
                  await supabase.auth.signOut();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Tela1Login()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),

      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/ui/imagens/Fundo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Lista de posts (com filtro aplicado)
                Expanded(
                  child: carregandoPosts
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 240, 232, 213),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: carregarPosts,
                          child: postsFiltrados.isEmpty
                              ? ListView(
                                  // ListView pra permitir o pull-to-refresh mesmo vazio
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      child: Center(
                                        child: Text(
                                          filtroSelecionado != null
                                              ? 'Nenhum post "$filtroSelecionado" encontrado.'
                                              : 'Nenhum post ainda.',
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 240, 232, 213),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: postsFiltrados.length,
                                  itemBuilder: (context, index) {
                                    return construirPost(postsFiltrados[index]);
                                  },
                                ),
                        ),
                ),

                // Botão Criar Post
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tela4CriarPost()),
                        );
                        carregarPosts(); // recarrega o feed ao voltar do criar post
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 60),
                        backgroundColor: const Color.fromARGB(255, 240, 232, 213),
                        foregroundColor: const Color.fromARGB(255, 46, 37, 58),
                      ),
                      child: const Text(
                        "Criar Post",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}