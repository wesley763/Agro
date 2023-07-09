import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class VaccinesPage extends StatefulWidget {
  @override
  _VaccinesPageState createState() => _VaccinesPageState();
}

class _VaccinesPageState extends State<VaccinesPage> {
  List<Vaccine> vaccines = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Vacinas'),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1), // Altere a cor de fundo para o azul desejado
      body: ListView.builder(
        itemCount: vaccines.length,
        itemBuilder: (context, index) {
          Vaccine vaccine = vaccines[index];
          return ListTile(
            title: Text(vaccine.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data de Administração: ${vaccine.administrationDate}'),
                Text('Data de Vencimento: ${vaccine.expirationDate}'),
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
                decoration: InputDecoration(labelText: 'Data de Administração'),
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
                decoration: InputDecoration(labelText: 'Data de Vencimento'),
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

            widget.onVaccineAdded(vaccine);

            Navigator.of(context).pop();
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VaccinesPage(),
  ));
}
