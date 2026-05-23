import 'package:flutter/material.dart';

import 'package:sistema_dvolta/paginas/login/Login.dart';
import 'package:sistema_dvolta/paginas/criar_post/post.dart';

void main() {
  runApp(const MyApp(title: 'Flutter Demo'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required String title});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 16, 83, 56)),
      ),
      home: const MyHomePage(title: 'Feed'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          title: const Text('Login'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
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
                              builder: (context) => Post(),
                          ),
                        );
                        },
                        
                        color: const Color.fromARGB(255, 16, 83, 56),
                        textColor: Colors.white,
                        child: Text('Login'),
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
