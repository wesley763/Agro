import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
class ParasitesPage extends StatefulWidget {
  @override
  _ParasitesPageState createState() => _ParasitesPageState();
}

class _ParasitesPageState extends State<ParasitesPage> {
  List<Parasite> parasites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Parasitas'),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1), // Altere a cor de fundo para o azul desejado
      body: ListView.builder(
        itemCount: parasites.length,
        itemBuilder: (context, index) {
          Parasite parasite = parasites[index];
          return ListTile(
            title: Text(parasite.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data de Tratamento: ${parasite.treatmentDate}'),
                Text('Próxima Aplicação: ${parasite.nextApplicationDate}'),
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
              onParasiteAdded: (parasite) {
                setState(() {
                  parasites.add(parasite);
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

class Parasite {
  final String name;
  final String treatmentDate;
  final String nextApplicationDate;

  Parasite({
    required this.name,
    required this.treatmentDate,
    required this.nextApplicationDate,
  });
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
                decoration: InputDecoration(labelText: 'Data de Tratamento'),
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
                decoration: InputDecoration(labelText: 'Próxima Aplicação'),
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

            Navigator.of(context).pop();
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}
