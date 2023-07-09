import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class VaccinesPage extends StatefulWidget {
  @override
  _VaccinesPageState createState() => _VaccinesPageState();
}

class _VaccinesPageState extends State<VaccinesPage> {
  
  List<Vaccine> vaccines = [];


  Future<List<Vaccine>> fetchVaccines() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.0.206:8000/vacina/'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        List<Vaccine> fetchedVaccines = [];
        for (var vaccineData in data) {
          Vaccine vaccine = Vaccine(
            name: vaccineData['nome_vacina'],
            administrationDate: vaccineData['data_administracao'],
            expirationDate: vaccineData['data_vencimento'],
          );
          fetchedVaccines.add(vaccine);
        }
        return fetchedVaccines;
      } else {
        throw Exception('Failed to fetch vaccines: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch vaccines: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVaccines().then((fetchedVaccines) {
      setState(() {
        vaccines = fetchedVaccines;
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Falha ao buscar as vacinas.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Vacinas'),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      body: ListView.builder(
        itemCount: vaccines.length,
        itemBuilder: (context, index) {
          Vaccine vaccine = vaccines[index];
          return ListTile(
            title: Text(
              vaccine.name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data de Administração: ${vaccine.administrationDate}', style: TextStyle(color: Colors.white)),
                Text('Data de Vencimento: ${vaccine.expirationDate}', style: TextStyle(color: Colors.white)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddVaccineDialog(
              onVaccineAdded: (vaccine) {
                setState(() {
                  vaccines.add(vaccine);
                });
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Vaccine {
  final String name;
  final String administrationDate;
  final String expirationDate;

  Vaccine({
    required this.name,
    required this.administrationDate,
    required this.expirationDate,
  });
}

class AddVaccineDialog extends StatefulWidget {
  final Function(Vaccine) onVaccineAdded;

  AddVaccineDialog({required this.onVaccineAdded});

  @override
  _AddVaccineDialogState createState() => _AddVaccineDialogState();
}

class _AddVaccineDialogState extends State<AddVaccineDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController administrationDateController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();

  void showDatePicker(TextEditingController controller) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime.now(),
      onChanged: (date) {
        setState(() {
          controller.text = DateFormat('dd/MM/yyyy').format(date);
        });
      },
      onConfirm: (date) {
        setState(() {
          controller.text = DateFormat('dd/MM/yyyy').format(date);
        });
      },
      currentTime: DateTime.now(),
    );
  }

  Future<void> addVaccineToAPI(Vaccine vaccine) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.0.206:8000/vacina/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nome_vacina': vaccine.name,
          'data_administracao': DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(vaccine.administrationDate)),
          'data_vencimento': DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(vaccine.expirationDate)),
        }),
      );
      if (response.statusCode == 201) {
        widget.onVaccineAdded(vaccine);
        Navigator.of(context).pop();
      } else {
        throw Exception('Failed to add vaccine to API: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to add vaccine to API:$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Vacina'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nome da Vacina'),
          ),
          GestureDetector(
            onTap: () {
              showDatePicker(administrationDateController);
            },
            child: AbsorbPointer(
              child: TextField(
                controller: administrationDateController,
                decoration: InputDecoration(labelText: 'Data de Administração (dd/MM/yyyy)'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDatePicker(expirationDateController);
            },
            child: AbsorbPointer(
              child: TextField(
                controller: expirationDateController,
                decoration: InputDecoration(labelText: 'Data de Vencimento (dd/MM/yyyy)'),
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
            String administrationDate = administrationDateController.text;
            String expirationDate = expirationDateController.text;

            Vaccine vaccine = Vaccine(
              name: name,
              administrationDate: administrationDate,
              expirationDate: expirationDate,
            );

            addVaccineToAPI(vaccine).then((_) {
              widget.onVaccineAdded(vaccine);
              Navigator.of(context).pop();
            }).catchError((error) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Erro'),
                  content: Text('Falha ao adicionar a vacina.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
            });
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}
