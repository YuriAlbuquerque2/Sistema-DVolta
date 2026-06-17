import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:sistema_dvolta/paginas/login/main.dart';

class Tela2Cadastro extends StatefulWidget {
  const Tela2Cadastro({super.key});

  @override
  State<Tela2Cadastro> createState() => _Tela2Cadastro();
}

class _Tela2Cadastro extends State<Tela2Cadastro> {

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return Container (
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage('lib/ui/imagens/Fundo.png'),
          fit:BoxFit.cover, 
                  ),
                ),
        child: Scaffold(
          appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 240, 232, 213), size: 40),
          ),
        ),

          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 412,
                  height: 914,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.transparent),

          

          child: Stack(   
            children: [
              Positioned (
                 left: 91,
                 top: 105,
                child: Image.asset("lib/ui/imagens/Logo.png"),
               ),

              Positioned( // borda fina
                left: 61,
                top: 286,
                child: Container(
                  width: 296,
                  height: 500,
                  decoration: ShapeDecoration(
                    color:  Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFF0E8D5),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned( // campo de confirmar senha
                left: 87,
                top: 633,
                

                child: Material (
                  color: Colors.transparent,
                child: SizedBox(
                  width: 242,
                  height: 50,
                  child: TextFormField(
                    controller: confirmarSenhaController,
                    obscureText: true,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: const Color(0xFFF0E8D5),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 80, 61, 104),
                      ),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    ),
                    // onChanged: (String value) {

                    // },
                    // validator: (value) { // IMPLEMENTAR VALIDAÇÃO PARA COMPARAR ESSE CAMPO COM O CAMPO DE SENHA
                      
                    // }
                  ),
                ),
                ),
              ),
              Positioned( // texto de confirmar senha
                left: 83,
                top: 602,
                child: SizedBox(
                  width: 180,
                  height: 26,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Confirmar senha',
                          style: TextStyle(
                            color: const Color(0xFFF0E8D5),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.40,
                          ),
                        ),
                      
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned( // campo de senha
                left: 87,
                top: 533,
                

                child: Material (
                  color: Colors.transparent,
                child: SizedBox(
                  width: 242,
                  height: 50,
                  child: TextFormField(
                    controller: senhaController,
                    obscureText: true,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: const Color(0xFFF0E8D5),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 80, 61, 104),
                      ),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    ),
                    onChanged: (String value) {

                  },
                  validator: (value) {
                    return value!.isEmpty ? 'Por favor digite uma senha válida' : null;
                  },
                  ),
                ),
                ),
              ),
              Positioned( // texto de senha
                left: 83,
                top: 502,
                child: SizedBox(
                  width: 80,
                  height: 26,
                  child: Text(
                    'Senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                ),
              ),
              Positioned( // campo de email
                left: 87,
                top: 442,
                

                child: Material (
                  color: Colors.transparent,
                child: SizedBox(
                  width: 242,
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: const Color(0xFFF0E8D5),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 80, 61, 104),
                      ),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),

                    hintText: 'ex.: juninho247@gmail.com',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(191, 240, 232, 213),
                    ),
                    //prefixIcon: Icon(Icons.email), // Talvez seja melhor sem ícones nessa tela
                    ),
                    onChanged: (String value) {

                  },
                  ),
                ),
                ),
              ),
              Positioned( //texto de email
                left: 83,
                top: 411,
                child: SizedBox(
                  width: 80,
                  height: 26,
                  child: Text(
                    'Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                ),
              ),
              Positioned( // campo de nome
                left: 87,
                top: 339,
                
                child: Material (
                  color: Colors.transparent,
                child: SizedBox(
                  width: 242,
                  height: 50,
                  child: TextFormField(
                    controller: nomeController,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: const Color(0xFFF0E8D5),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 80, 61, 104),
                      ),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    ),
                  ),
                ),
                ),
              ),
              Positioned( // texto de nome
                left: 83,
                top: 308,
                child: SizedBox(
                  width: 80,
                  height: 26,
                  child: Text(
                    'Nome',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF0E8D5),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                ),
              ),
              Positioned( // botão de criar conta
                left: 87,
                top: 711,
                child: Material(
                  
                  color: const Color(0xFFF0E8D5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      ),
                  child: InkWell(
                    
                    onTap: () async {
                      if (nomeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nome não pode ser vazio!"),
                        ),
                      );

                      return;
                    }

                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Email não pode ser vazio!"),
                        ),
                      );

                      return;
                      }

                      if (!emailController.text.contains('@')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Digite um email válido!"),
                        ),
                      );

                      return;
                      }

                      if (senhaController.text.length < 8) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("A senha precisa de no mínimo 8 caracteres."),
                        ),
                      );

                      return;
                    }

                    if (senhaController.text != confirmarSenhaController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("As senhas não coincidem."),
                        ),
                      );

                      return;
                    }

                      final response = await supabase.auth.signUp(
                      email: emailController.text.trim(),
                      password: senhaController.text,
                    );

                    final userId = response.user!.id;

                        await Supabase.instance.client
                              .from('usuarios')
                              .insert({
                                'id': userId,
                                'nome': nomeController.text,
                              });
                       
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tela1Login()),
                      );
                    },
                    highlightColor: Colors.transparent,                    
                     child: SizedBox(
                       width: 242,
                       height: 47,                     
                      child: Center(
                      child: Text(
                        'Criar conta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 46, 37, 58),
                          fontSize: 28,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                          letterSpacing: -0.56,
                        ),
                      ),
                    ),
                    ),
                  ),
                ),
              ),

              // Positioned( // botão de voltar
              //   top: 71,
              //   left: 21,
              //   child: Material (
                  
              //   ),
              // ),
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