import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class CadastroAnimalPage extends StatefulWidget {
  @override
  _CadastroAnimalPageState createState() => _CadastroAnimalPageState();
}

class _CadastroAnimalPageState extends State<CadastroAnimalPage> {
  List<String> categorias = ['Cavalo', 'Vaca', 'Porco', 'Frango', 'Cabra'];
  String? selectedCategoria;

  final TextEditingController nomeController = TextEditingController();
  TextEditingController dataNascimentoController = TextEditingController();
  final TextEditingController racaController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();


  

  Future<void> cadastrarAnimal() async {
    String url = 'http://10.0.0.206:8000/animal/';

    String nome = nomeController.text;
    String nascimento = dataNascimentoController.text;
    String raca = racaController.text;
    String peso = pesoController.text;
    String numeroAnimal = numeroController.text;
    String categoria = selectedCategoria ?? '';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> animalData = {
      'categoria': categoria,
      'numero_animal': numeroAnimal,
      'nome': nome,
      'nascimento': nascimento,
      'raca': raca,
      'peso': peso,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(animalData),
      );

      if (response.statusCode == 201) {
        // Sucesso no cadastro
        print('Animal cadastrado com sucesso');
      } else {
        // Falha no cadastro
        print('Falha no cadastro do animal');
      }
    } catch (error) {
      print('Erro ao enviar solicitação POST: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    selectedCategoria = categorias[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Animal'),
        backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: selectedCategoria,
                items: categorias.map((categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Text(
                      categoria,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategoria = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
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
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: numeroController,
                decoration: InputDecoration(
                  labelText: 'Numero do animal',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
  controller: dataNascimentoController,
  decoration: InputDecoration(
    labelText: 'Data de Nascimento',
    // ...
  ),
  onTap: () {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime.now(),
      onConfirm: (date) {
        setState(() {
          dataNascimentoController.text = DateFormat('yyyy-MM-dd').format(date);
        });
      },
      currentTime: DateTime.now(),
    );
  },
),
              TextFormField(
                controller: racaController,
                decoration: InputDecoration(
                  labelText: 'Raça',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: pesoController,
                decoration: InputDecoration(
                  labelText: 'Peso',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
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
                    onTap: cadastrarAnimal,
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
