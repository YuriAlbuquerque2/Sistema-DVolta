import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistema_dvolta/paginas/home/perfil/editar_informacoes/editar_informacoes.dart';
import 'package:sistema_dvolta/paginas/home/perfil/meus_posts/meus_posts.dart';


class Tela5Perfil extends StatefulWidget {
  @override
  State<Tela5Perfil> createState() => _Tela5PerfilState();
}

class _Tela5PerfilState extends State<Tela5Perfil> {
  final supabase = Supabase.instance.client;
  String nomeUsuario = '';
  String emailUsuario = '';
  String? fotoPerfilUrl;

  Future<void> carregarDadosUsuario() async {

    final user = supabase.auth.currentUser;

      if (user == null) return;

      final dados = await supabase
          .from('usuarios')
          .select('nome, foto_perfil')
          .eq('id', user.id)
          .single();

      setState(() {

        nomeUsuario = dados['nome'] ?? '';

        fotoPerfilUrl = dados['foto_perfil'];

        emailUsuario = user.email ?? '';

      });
    }

    @override
    void initState() {
      super.initState();
      carregarDadosUsuario();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight:270,
        flexibleSpace: Image.asset(
          'lib/ui/imagens/FundoPerfil.png',
          fit: BoxFit.cover,
        ),

        elevation: 0,
          leading:Padding(
            padding: const EdgeInsets.only(bottom:200.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 240, 232, 213), size: 40),
            ),
          ),
         
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            Transform.translate(
              offset: Offset(40,0),
            child: CircleAvatar( //avatar
                                radius: 90,
                                backgroundImage:
                                  fotoPerfilUrl != null
                                      ? NetworkImage(fotoPerfilUrl!)
                                      : null,

                                child:
                                  fotoPerfilUrl == null
                                      ? Icon(Icons.person)
                                      : null,
                              ),
          ),
           SizedBox(height: 10),
           Transform.translate(
              offset: Offset(-60,0),
            child: Text(// texto do nome do usuário
                                nomeUsuario,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 240, 232, 213),
                                ),               
                       )
          ),

           Transform.translate(
              offset: Offset(-60,0),
            child: Text( //texto do email do usuário
                                emailUsuario,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 240, 232, 213),
                                ),               
                       )
          ),
          
            ]
          )
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
                  crossAxisAlignment: CrossAxisAlignment.start,           
                  children: [
                    SizedBox(height: 350), // Espaçamento entre o avatar e o nome

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tela7EditarInformaEs()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        fixedSize: Size(400, 60),
                      ),
                      child: Align(alignment: Alignment.centerLeft,
                      child: Row( mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit, color: Color.fromARGB(255, 240, 232, 213), size:20),
                        SizedBox(width: 8),
                           Text(
                                'Editar informações',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF0E8D5),
                                ),
                               ),
                      ]
                      
                      )
                      )
                    ),

                    Divider(
                      height: 40,
                      thickness: 1,
                      color: const Color(0xFF24496B),
                      indent: 20,
                      endIndent: 20,
                    ),  

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tela6meuspost()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        fixedSize: Size(400, 60),
                      ),
                      child: Align(alignment: Alignment.centerLeft,
                      child: Row( mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.folder, color: Color.fromARGB(255, 240, 232, 213), size:20),
                        SizedBox(width: 8),
                           Text(
                                'Meus posts',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF0E8D5),
                                ),
                               ),
                      ]
                      
                      )
                      )
                    ),

                    Divider(
                      height: 40,
                      thickness: 1,
                      color: const Color(0xFF24496B),
                      indent: 20,
                      endIndent: 20,
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tela7EditarInformaEs()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        fixedSize: Size(400, 60),
                      ),
                      child: Align(alignment: Alignment.centerLeft,
                      child: Row( mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete, color: Color.fromARGB(255, 240, 232, 213), size:20),
                        SizedBox(width: 8),
                           Text(
                                'Excluir conta',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF0E8D5),
                                ),
                               ),
                      ]
                      
                      )
                      )
                    ),

                    Divider(
                      height: 40,
                      thickness: 1,
                      color: const Color(0xFF24496B),
                      indent: 20,
                      endIndent: 20,
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tela7EditarInformaEs()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        fixedSize: Size(400, 60),
                      ),
                      child: Align(alignment: Alignment.centerLeft,
                      child: Row( mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout, color: Color.fromARGB(255, 240, 232, 213), size:20),
                        SizedBox(width: 8),
                           Text(
                                'Sair da conta',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF0E8D5),
                                ),
                               ),
                      ]
                      
                      )
                      )
                    ),

                    Divider(
                      height: 40,
                      thickness: 1,
                      color: const Color(0xFF24496B),
                      indent: 20,
                      endIndent: 20,
                    ),


                  ],
                ),
        ],
    )
    );
  }
}