import 'package:flutter/material.dart';
import 'package:sistema_dvolta/paginas/login/main.dart';
import 'package:sistema_dvolta/paginas/home/criar_post/post.dart';
import 'package:sistema_dvolta/paginas/home/perfil/perfil.dart';
import 'package:sistema_dvolta/paginas/home/perfil/meus_posts/meus_posts.dart';
import 'package:sistema_dvolta/paginas/home/perfil/editar_informacoes/editar_informacoes.dart';
import 'package:sistema_dvolta/ui/widgets/search.dart';

class Tela3Feed extends StatefulWidget {
  const Tela3Feed({super.key});

  @override
  State<Tela3Feed> createState() => _Tela3FeedState();
}

class _Tela3FeedState extends State<Tela3Feed> {

  bool isSearchClicked = false;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  List<String> searchResults = [
    'Garrafa',
    'capinha de celular',
    'fone de ouvido',
    'chave',
    'carteira',
  ];

  List<String> filteredResults = [];
  @override
  void initState() {
    super.initState();
    filteredResults = List.from(searchResults);
    }

    void _filterSearchResults(String query) {
      setState(() {
        searchQuery = query;
        myFilterItems();
        filteredResults = searchResults
            .where((result) => result.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
    
    void myFilterItems() {
    if (searchResults.isEmpty) {
      filteredResults = List.from(searchResults);
    } else {
      filteredResults = searchResults
          .where(
              (result) => result.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,


        appBar: AppBar( //barra de cima
          backgroundColor: Color.fromARGB(255, 80, 61, 104),
          elevation: 0,

          title: isSearchClicked ? Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 46, 37, 58),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSearchResults,
              decoration: InputDecoration(
                hintText: 'Pesquisar...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 46, 37, 58),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              style: TextStyle(color: Color.fromARGB(255, 240, 232, 213)),
              onSubmitted: (query) {
                // Lógica de pesquisa aqui
              },
            ),
          ):
          Text('DVolta'),

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

          actions: [

            IconButton( // Botão de pesquisa
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                  if (!isSearchClicked) {
                    _searchController.clear();
                    myFilterItems();
                  }
                });
              },
              icon: Icon(isSearchClicked ? Icons.close : Icons.search, color: Color.fromARGB(255, 240, 232, 213), size: 30),
            ),   


            PopupMenuButton<String>(// Botão de filtro
              onSelected: (String value){
                // Ação para quando um item do menu popup for selecionado
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Achado',
                  child: Text('Achado', style: TextStyle(
                    color: Color.fromARGB(255, 240, 232, 213),
                  ),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Perdido',
                  child: Text('Perdido', style: TextStyle(
                    color: Color.fromARGB(255, 240, 232, 213),
                  ),
                  ),
                ),
              ],
               icon: Icon(Icons.filter_alt, color: Color.fromARGB(255, 240, 232, 213), size: 30),
               color:Color.fromARGB(255, 80, 61, 104), 
            ),     
          ],
        ),


        drawer: Drawer( //Menu hamburguer 
          child: Container(
            color: Color.fromARGB(255, 46, 37, 58),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 80, 61, 104),
                ),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                    alignment: Alignment.topLeft,
                     child:CircleAvatar(
                       radius: 40,
                       backgroundImage: NetworkImage("https://placehold.co/80x80"),
                     )
                    ),

                    SizedBox(height: 10),
                    
                    Text(
                      'Nome do Usuário',
                      style: TextStyle(
                        color: Color.fromARGB(255, 240, 232, 213),
                        fontSize: 15,
                      ),
                    ),

                    

                    Text(
                      'Usuario3@outlook.com',
                      style: TextStyle(
                        color: Color.fromARGB(255, 240, 232, 213),
                        fontSize: 15,
                      ),
                    ),
                  ],

                  
                )
              ),

              ListTile(//Opções do menu hamburguer
                leading: Icon(Icons.turned_in, color: Color.fromARGB(255, 240, 232, 213)),
                title: Text('Meus posts'),
                titleTextStyle: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 240, 232, 213)
             ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tela6meuspost()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Color.fromARGB(255, 240, 232, 213)),
                title: Text('Perfil'),
                 titleTextStyle: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 240, 232, 213)
             ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tela5Perfil()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Color.fromARGB(255, 240, 232, 213)),
                title: Text('Configurações'),
                 titleTextStyle: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 240, 232, 213)
             ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Color.fromARGB(255, 240, 232, 213)),
                title: Text('Sair'),
                 titleTextStyle: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 240, 232, 213)
             ),
                onTap: () async {
                  await supabase.auth.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Tela1Login(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
        ),

        backgroundColor: Colors.transparent,

        body: Stack( //feed
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




                  Column(
                    children:[
                      SizedBox(height: 800),
                      Center(
                        child: ElevatedButton( //Botão para criar post
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Tela4CriarPost())
                            );
                          }, 
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(250, 60),
                            backgroundColor: Color.fromARGB(255, 240, 232, 213),
                            foregroundColor: Color.fromARGB(255, 46, 37, 58),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Criar Post",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

         
                    ],
          )
          ]
    )
    );
  }
}