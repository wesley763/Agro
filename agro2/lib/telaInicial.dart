import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cadastro_usuario.dart';
import 'package:agro/home.dart';



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
        '/home': (context) => HomePage(),
      },
    );
  }
}

class Usuario {

  final String nome;

  Usuario({ required this.nome});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
    
      nome: json['nome']
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> login(BuildContext context) async {
    var url = Uri.parse('http://10.0.0.206:8000/user/');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var queryParams = {
      'nome': usernameController.text,
      'senha': passwordController.text,
    };

    var uri = Uri.parse(url.toString() + '?' + Uri(queryParameters: queryParams).query);

    var response = await http.get(uri, headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData is List) {
        // Se a resposta for uma lista, você precisa definir a lógica apropriada para lidar com a lista de usuários retornados
        // Aqui, você pode decidir o que fazer com a lista de usuários retornados

        List<Usuario> usuarios = [];
        responseData.forEach((item) {
          usuarios.add(Usuario.fromJson(item));
        });

        // Exemplo de como acessar os dados de um usuário específico da lista
        var primeiroUsuario = usuarios[0];
        
        print('Nome do usuário: ${primeiroUsuario.nome}');
      } else if (responseData is Map<String, dynamic>) {
        // Se a resposta for um mapa, você pode continuar o processamento conforme antes

        var usuario = Usuario.fromJson(responseData);

       
        print('Nome do usuário: ${usuario.nome}');
      }

      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        if (response.statusCode == 401) {
          errorMessage = 'Usuário ou senha incorretos. Por favor, verifique suas credenciais.';
        } else {
          errorMessage = 'Ocorreu um erro durante o login. Por favor, tente novamente.';
        }
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro de Login'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Fechar'),
              ),
            ],
          );
        },
      );
    }
  }

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
                controller: usernameController,
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
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 193, 186, 186),
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
                      login(context);
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
                            color: Colors.white,
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
              SizedBox(height: 20.0),
              errorMessage.isNotEmpty
                  ? Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}



class UserProvider with ChangeNotifier {
  String? username;

  void login(String username) {
    this.username = username;
    notifyListeners();
  }

  void logout() {
    this.username = null;
    notifyListeners();
  }

  bool get isLoggedIn => username != null;
}