import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroPage extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  Future<void> cadastrarUsuario() async {
    String url = 'http://10.0.0.206:8000/user/';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> userData = {
      "nome": nomeController.text,
      "cpf": cpfController.text,
      "numero": numeroController.text,
      "email": emailController.text,
      "senha": senhaController.text,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        // Sucesso no cadastro
        print('Usuário cadastrado com sucesso');
      } else {
        // Falha no cadastro
        print('Falha no cadastro do usuário');
      }
    } catch (error) {
      print('Erro ao enviar solicitação POST: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
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
                controller: cpfController,
                decoration: InputDecoration(
                  labelText: 'CPF',
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
                controller: numeroController,
                decoration: InputDecoration(
                  labelText: 'Número',
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
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
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
                controller: senhaController,
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
                    onTap: cadastrarUsuario,
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
