import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ParasitesPage extends StatefulWidget {
  @override
  _ParasitesPageState createState() => _ParasitesPageState();
}

class _ParasitesPageState extends State<ParasitesPage> {
  List<Parasite> parasites = [];

  @override
  void initState() {
    super.initState();
    fetchParasites().then((parasiteList) {
      setState(() {
        parasites = parasiteList;
      });
    }).catchError((error) {
      print('Failed to fetch parasites: $error');
    });
  }

  Future<List<Parasite>> fetchParasites() async {
    final response = await http.get(Uri.parse('http://10.0.0.206:8000/parasita/'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      return jsonList.map((json) => Parasite.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch parasites');
    }
  }

  Future<void> addParasite(Parasite parasite) async {
    final response = await http.post(
      Uri.parse('http://10.0.0.206:8000/parasita/'),
      body: {
        'nome_parasita': parasite.name,
        'data_tratamento': parasite.treatmentDate,
        'data_prixima_aplicaçao': parasite.nextApplicationDate,
      },
    );

    if (response.statusCode == 201) {
      setState(() {
        parasites.add(parasite);
      });
      print('Parasite added successfully');
    } else {
      print('Failed to add parasite');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Parasitas'),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      body: ListView.builder(
        itemCount: parasites.length,
        itemBuilder: (context, index) {
          Parasite parasite = parasites[index];
          return ListTile(
            title: Text(parasite.name , style: TextStyle(color: Colors.white)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data de Tratamento: ${parasite.treatmentDate}', style: TextStyle(color: Colors.white)),
                Text('Próxima Aplicação: ${parasite.nextApplicationDate}', style: TextStyle(color: Colors.white)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddParasiteDialog(
              onParasiteAdded: (parasite) async {
                await addParasite(parasite);
                Navigator.of(context).pop();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Parasite {
  final String name;
  final String treatmentDate;
  final String nextApplicationDate;

  Parasite({
    required this.name,
    required this.treatmentDate,
    required this.nextApplicationDate,
  });

  factory Parasite.fromJson(Map<String, dynamic> json) {
    return Parasite(
      name: json['nome_parasita'],
      treatmentDate: json['data_tratamento'],
      nextApplicationDate: json['data_prixima_aplicaçao'],
    );
  }
}

class AddParasiteDialog extends StatefulWidget {
  final Function(Parasite) onParasiteAdded;

  AddParasiteDialog({required this.onParasiteAdded});

  @override
  _AddParasiteDialogState createState() => _AddParasiteDialogState();
}

class _AddParasiteDialogState extends State<AddParasiteDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController treatmentDateController = TextEditingController();
  TextEditingController nextApplicationDateController = TextEditingController();

  void showDatePicker(TextEditingController controller) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime.now(),
      onChanged: (date) {
        setState(() {
          controller.text = DateFormat('yyyy-MM-dd').format(date);
        });
      },
      onConfirm: (date) {
        setState(() {
          controller.text = DateFormat('yyyy-MM-dd').format(date);
        });
      },
      currentTime: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Parasita'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nome do Parasita'),
          ),
          GestureDetector(
            onTap: () {
              showDatePicker(treatmentDateController);
            },
            child: AbsorbPointer(
              child: TextField(
                controller: treatmentDateController,
                decoration: InputDecoration(labelText: 'Data de Tratamento (aaaa-mm-dd)'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDatePicker(nextApplicationDateController);
            },
            child: AbsorbPointer(
              child: TextField(
                controller: nextApplicationDateController,
                decoration: InputDecoration(labelText: 'Próxima Aplicação (aaaa-mm-dd)'),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            String name = nameController.text;
            String treatmentDate = treatmentDateController.text;
            String nextApplicationDate = nextApplicationDateController.text;

            Parasite parasite = Parasite(
              name: name,
              treatmentDate: treatmentDate,
              nextApplicationDate: nextApplicationDate,
            );

            widget.onParasiteAdded(parasite);
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}

void main() {
  runApp(ParasitesApp());
}

class ParasitesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Parasitas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ParasitesPage(),
    );
  }
}
