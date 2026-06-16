import 'package:flutter/material.dart';
import 'package:sistema_dvolta/paginas/login/main.dart';
import 'package:sistema_dvolta/paginas/home/criar_post/post.dart';

class Tela3Feed extends StatefulWidget {
  @override
  State<Tela3Feed> createState() => _Tela3FeedState();
}

class _Tela3FeedState extends State<Tela3Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,


        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 80, 61, 104),
          elevation: 77,
          title: Text('DVolta'),
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
            IconButton(
              onPressed: () {
                // Ação para o ícone de pesquisa
              },
              icon: Icon(Icons.filter_alt, color: Color.fromARGB(255, 240, 232, 213), size: 30),
            ),
          ],
        ),


        drawer: Drawer(
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

              ListTile(
                leading: Icon(Icons.turned_in, color: Color.fromARGB(255, 240, 232, 213)),
                title: Text('Meus posts'),
                titleTextStyle: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 240, 232, 213)
             ),
                onTap: () {
                  Navigator.pop(context);
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
                  Navigator.pop(context);
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
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Tela1Login())
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
                        child: ElevatedButton(
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