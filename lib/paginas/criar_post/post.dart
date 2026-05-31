import 'package:flutter/material.dart';

import 'package:sistema_dvolta/paginas/login/main.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 32, 203, 26)),
      ),
      home: Scaffold( 
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Post'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Post',
              style: TextStyle(
                fontSize: 35,
                color: const Color.fromARGB(255, 228, 142, 19),
                fontWeight: FontWeight.bold
              ), //TextStyle
            ), //Text
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                child: Column(
                  children:[
              
                    SizedBox(height: 30), //SizedBox
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Matrícula',
                          hintText: 'Matrícula',
                          prefixIcon: Icon(Icons.numbers),
                          border: OutlineInputBorder(),
                        ),//Decoration
                        onChanged: (String value) {
                                    
                        }, //onChanged
                        validator: (value) {
                          return value!.isEmpty ? 'Por favor digite uma matrícula' : null;
                        }, //Validator
                                      
                      ),
                    ),//TextFormFild
              
                    SizedBox(height: 30, ),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          hintText: 'Senha',
                          prefixIcon: Icon(Icons.key),
                          border: OutlineInputBorder(),
                        ),//Decoration
                        onChanged: (String value) {
                                    
                        }, 
                        validator: (value) {
                          return value!.isEmpty ? 'Por favor digite uma senha' : null;
                        }, //Validator
                                      
                      ),
                    ),//TextField
                    SizedBox(height: 30, ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tela1Login(),
                          ),
                        );
                        },
                        
                        color: const Color.fromARGB(255, 16, 83, 56),
                        textColor: Colors.white,
                        child: Text('Post'),
                      ),
                    ),
                  ],
                ),//columm
              ),
            ), //form
          ], // children
        ) //collumn
      ), // Scaffold
    ); //materielApp
  }
}