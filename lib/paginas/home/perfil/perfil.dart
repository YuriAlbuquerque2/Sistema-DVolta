import 'package:flutter/material.dart';
import 'package:sistema_dvolta/paginas/home/perfil/editar_informacoes/editar_informacoes.dart';


class Tela5Perfil extends StatefulWidget {
  @override
  State<Tela5Perfil> createState() => _Tela5PerfilState();
}

class _Tela5PerfilState extends State<Tela5Perfil> {
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
                                backgroundImage: NetworkImage("https://placehold.co/80x80"),
                              ),
          ),
           SizedBox(height: 10),
           Transform.translate(
              offset: Offset(-60,0),
            child: Text(// texto do nome do usuário
                                "Nome do usuário",
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
                                "Usuario3@outlook.com",
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
                        backgroundColor: Color(0xFF503D68),
                        padding: EdgeInsets.only(left: 70, right: 180, top: 20, bottom: 20),
                      ),
                      child: Text(
                                'Editar informações',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF0E8D5),
                                ),
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
                        backgroundColor: Color(0xFF503D68),
                        padding: EdgeInsets.only(left: 70, right: 240, top: 20, bottom: 20),
                      ),
                      child: Text(
                                'Meus Posts',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF0E8D5),
                                ),
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
                        backgroundColor: Color(0xFF503D68),
                        padding: EdgeInsets.only(left: 70, right: 240, top: 20, bottom: 20),
                      ),
                      child: Text(
                                'Excluir conta',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF0E8D5),
                                ),
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
                        backgroundColor: Color(0xFF503D68),
                        padding: EdgeInsets.only(left: 50, right: 240, top: 20, bottom: 20),
                      ),
                      child: Text(
                                'Sair da conta',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF0E8D5),
                                ),
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