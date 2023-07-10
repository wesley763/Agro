import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class VeterinaryRemindersPage extends StatefulWidget {
  @override
  _VeterinaryRemindersPageState createState() =>
      _VeterinaryRemindersPageState();
}

class _VeterinaryRemindersPageState extends State<VeterinaryRemindersPage> {
  List<Reminder> reminders = [];

  @override
  void initState() {
    super.initState();
    fetchReminderData().catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Falha ao buscar os dados do lembrete.'),
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

  Future<void> fetchReminderData() async {
    final response =
        await http.get(Uri.parse('http://10.0.0.206:8000/lembrete/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;

      setState(() {
        reminders = data.map((item) => Reminder.fromJson(item)).toList();
      });
    } else {
      throw Exception(
          'Failed to fetch reminder data: ${response.statusCode}');
    }
  }

  Future<void> addReminder(Reminder reminder) async {
    final response = await http.post(
      Uri.parse('http://10.0.0.206:8000/lembrete/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reminder.toJson()),
    );

    if (response.statusCode == 201) {
      fetchReminderData();
    } else {
      throw Exception('Failed to add reminder: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lembretes Veterinários'),
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      body: reminders.isNotEmpty
          ? ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                Reminder reminder = reminders[index];
                return ListTile(
                  title: Text(reminder.careType,
                      style: TextStyle(color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data: ${reminder.date}',
                          style: TextStyle(color: Colors.white)),
                      Text('Hora: ${reminder.time}',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Sem lembretes',
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
            builder: (context) => AddReminderDialog(
              onReminderAdded: (reminder) {
                addReminder(reminder).catchError((error) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Erro'),
                      content: Text('Falha ao adicionar o lembrete.'),
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
                    'Data: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
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
            String date = DateFormat('yyyy-MM-dd').format(selectedDate);
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

class Reminder {
  final String careType;
  final String date;
  final String time;

  Reminder({
    required this.careType,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'cuidado': careType,
      'data': date,
      'hora':time,
    };
  }

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      careType: json['cuidado'],
      date: json['data'],
      time: json['hora'],
    );
  }
}
