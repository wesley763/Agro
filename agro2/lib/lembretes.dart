import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VeterinaryRemindersPage extends StatefulWidget {
  @override
  _VeterinaryRemindersPageState createState() => _VeterinaryRemindersPageState();
}

class _VeterinaryRemindersPageState extends State<VeterinaryRemindersPage> {
  List<Reminder> reminders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lembretes Veterinários'),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1), // Altere a cor de fundo para o azul desejado
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          Reminder reminder = reminders[index];
          return ListTile(
            title: Text(reminder.careType),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data: ${reminder.date}'),
                Text('Hora: ${reminder.time}'),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddReminderDialog(
              onReminderAdded: (reminder) {
                setState(() {
                  reminders.add(reminder);
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

class Reminder {
  final String careType;
  final String date;
  final String time;

  Reminder({
    required this.careType,
    required this.date,
    required this.time,
  });
}

class AddReminderDialog extends StatefulWidget {
  final Function(Reminder) onReminderAdded;

  AddReminderDialog({required this.onReminderAdded});

  @override
  _AddReminderDialogState createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  TextEditingController careTypeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Lembrete Veterinário'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: careTypeController,
            decoration: InputDecoration(labelText: 'Tipo de Cuidado'),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  setState(() {
                    this.selectedDate = selectedDate;
                  });
                }
              });
            },
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
                    'Data: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((selectedTime) {
                if (selectedTime != null) {
                  setState(() {
                    this.selectedTime = selectedTime;
                  });
                }
              });
            },
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
                    'Hora: ${selectedTime.format(context)}',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(Icons.access_time),
                ],
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
            String careType = careTypeController.text;
            String date = DateFormat('dd/MM/yyyy').format(selectedDate);
            String time = selectedTime.format(context);

            Reminder reminder = Reminder(
              careType: careType,
              date: date,
              time: time,
            );

            widget.onReminderAdded(reminder);

            Navigator.of(context).pop();
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}
