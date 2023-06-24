import 'package:flutter/material.dart';
import 'cadastro_usuario.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tela de Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/cadastro': (context) => CadastroPage(),
        '/home':(context) => HomePage()
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/animal_monitoring1.png',
                width: 300.0,
                height: 300.0,
              ),

              SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30.0),
              Container(
                height: 50.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.blue,
                  color: Colors.blue,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                       Navigator.pushNamed(context, '/home');
                    },
                    child: Center(
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 50.0,
                color: Color.fromARGB(0, 25, 0, 255),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Center(
                        child: Text(
                          'Entrar com o Facebook',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Definir a cor do texto como azul
        ),
                         
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),

               Container(
                height: 50.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.blue,
                  color: Colors.blue,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                    Navigator.pushNamed(context, '/cadastro');
                    },
                    child: Center(
                      child: Text(
                        'CADASTRAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

