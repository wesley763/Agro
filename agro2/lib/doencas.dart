import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DiseaseHistoryPage extends StatefulWidget {
  @override
  _DiseaseHistoryPageState createState() => _DiseaseHistoryPageState();
}

class _DiseaseHistoryPageState extends State<DiseaseHistoryPage> {
  List<Disease> diseases = [];

  @override
  void initState() {
    super.initState();
    fetchDiseaseData().catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Falha ao buscar os dados das doenças.'),
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

  Future<void> fetchDiseaseData() async {
    final response =
        await http.get(Uri.parse('http://10.0.0.206:8000/doencas/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;

      setState(() {
        diseases = data.map((item) => Disease.fromJson(item)).toList();
      });
    } else {
      throw Exception(
          'Failed to fetch disease data: ${response.statusCode}');
    }
  }

  Future<void> addDisease(Disease disease) async {
    final response = await http.post(
      Uri.parse('http://10.0.0.206:8000/doencas/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(disease.toJson()),
    );

    if (response.statusCode == 201) {
      fetchDiseaseData();
    } else {
      throw Exception('Failed to add disease: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Doenças'),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      body: diseases.isNotEmpty
          ? ListView.builder(
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                Disease disease = diseases[index];
                return ListTile(
                  title: Text(disease.name,
                      style: TextStyle(color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data de Diagnóstico: ${disease.diagnosisDate}',
                          style: TextStyle(color: Colors.white)),
                      Text(
                          'Tratamentos Realizados: ${disease.treatments.join(", ")}',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Sem doenças',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddDiseaseDialog(
              onDiseaseAdded: (disease) {
                addDisease(disease).catchError((error) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Erro'),
                      content: Text('Falha ao adicionar a doença.'),
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
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Disease {
  final String name;
  final String diagnosisDate;
  final List<String> treatments;

  Disease({
    required this.name,
    required this.diagnosisDate,
    required this.treatments,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome_doenca': name,
      'data_diagnostico': diagnosisDate,
      'tratamento': treatments.join(','),
    };
  }

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      name: json['nome_doenca'],
      diagnosisDate: json['data_diagnostico'],
      treatments: json['tratamento'].split(','),
    );
  }
}

class AddDiseaseDialog extends StatefulWidget {
  final Function(Disease) onDiseaseAdded;

  AddDiseaseDialog({required this.onDiseaseAdded});

  @override
  _AddDiseaseDialogState createState() => _AddDiseaseDialogState();
}

class _AddDiseaseDialogState extends State<AddDiseaseDialog> {
  TextEditingController nameController = TextEditingController();
  DateTime diagnosisDate = DateTime.now();
  TextEditingController treatmentsController = TextEditingController();

  void showDatePickerDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          diagnosisDate = selectedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Doença'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nome da Doença'),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: showDatePickerDialog,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data de Diagnóstico: ${DateFormat('yyyy-MM-dd').format(diagnosisDate)}',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: treatmentsController,
            decoration: InputDecoration(labelText: 'Tratamentos Realizados'),
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
            List<String> treatments = treatmentsController.text.split(',');

            Disease disease = Disease(
              name: name,
              diagnosisDate: DateFormat('yyyy-MM-dd').format(diagnosisDate),
              treatments: treatments,
            );

            widget.onDiseaseAdded(disease);

            Navigator.of(context).pop();
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}
