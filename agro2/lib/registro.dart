import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnimalListPage extends StatefulWidget {
  @override
  _AnimalListPageState createState() => _AnimalListPageState();
}

class _AnimalListPageState extends State<AnimalListPage> {
  List<dynamic> animals = [];
  TextEditingController searchController = TextEditingController();

  Future<void> fetchAnimals() async {
    String url = 'http://10.0.0.206:8000/animal/';

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Sucesso na obtenção dos dados dos animais
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          animals = data;
        });
      } else {
        // Falha na obtenção dos dados dos animais
        print('Falha ao obter os dados dos animais');
      }
    } catch (error) {
      print('Erro ao enviar solicitação GET: $error');
    }
  }

  void searchAnimals() {
    // Lógica para pesquisar animais
    // Implemente conforme sua necessidade
  }

  @override
  void initState() {
    super.initState();
    fetchAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Animais'),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1), // Altere a cor de fundo para o azul desejado
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Pesquisar',
                      labelStyle: TextStyle(color: Colors.white), // Altere a cor do texto para branco
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white), // Altere a cor do ícone para branco
                  onPressed: () {
                    searchAnimals();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: animals.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic animal = animals[index];
                return ListTile(
                  title: Text(
                    animal['nome'],
                    style: TextStyle(color: Colors.white), // Altere a cor do título para branco
                  ),
                  subtitle: Text(
                    animal['categoria'],
                    style: TextStyle(color: Colors.white), // Altere a cor do subtítulo para branco
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnimalDetailsPage(animal: animal)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AnimalDetailsPage extends StatelessWidget {
  final dynamic animal;

  AnimalDetailsPage({required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Animal'),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categoria: ${animal['categoria']}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 8.0),
            Text('Número do Animal: ${animal['numero_animal']}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8.0),
            Text('Nome: ${animal['nome']}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8.0),
            Text('Idade: ${animal['idade']}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8.0),
            Text('Raça: ${animal['raca']}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8.0),
            Text('Peso: ${animal['peso']}', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
