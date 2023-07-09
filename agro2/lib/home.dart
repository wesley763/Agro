import 'package:flutter/material.dart';
import 'package:agro/cadastro_animal.dart';
import 'package:agro/registro.dart';
import 'package:agro/vacinas.dart';
import 'package:agro/parasitas.dart';
import 'package:agro/doencas.dart';
import 'package:agro/lembretes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 26, 100, 1),
        title: Text('ANIMAL MONITORING'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Lógica para lidar com a seleção da opção de configuração
              // ...
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'perfil',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Meu Perfil'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'senha',
                child: ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Alterar Senha'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'sobre',
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Sobre o Sistema'),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 6),
            ElevatedButton(
              onPressed: () {
                // Navegar para a lista de animais
                 Navigator.push(
                    context,
                   MaterialPageRoute(builder: (context) => AnimalListPage()),
               );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              child: SizedBox(
                width: 300,
                height: 50,
                child: Center(child: Text('Animais Registrados')),
              ),
            ),
            SizedBox(height: 36),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => CadastroAnimalPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              child: SizedBox(
                width: 300,
                height: 50,
                child: Center(child: Text('Cadastrar Novo Animal')),
              ),
            ),
            SizedBox(height: 36),
            ElevatedButton(
              onPressed: () {
                // Navegar para a página de registro de vacinas
                Navigator.push(
                 context,
                MaterialPageRoute(builder: (context) => VaccinesPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              child: SizedBox(
                width: 300,
                height: 50,
                child: Center(child: Text('Registro de Vacinas')),
              ),
            ),
            SizedBox(height: 36),
            ElevatedButton(
              onPressed: () {
                // Navegar para a página de controle de parasitas
                Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => ParasitesPage()),
                 );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              child: SizedBox(
                width: 300,
                height: 50,
                child: Center(child: Text('Controle de Parasitas')),
              ),
            ),
            SizedBox(height: 36),
            ElevatedButton(
              onPressed: () {
                // Navegar para a página de histórico de doenças
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => DiseaseHistoryPage()),
                 );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              child: SizedBox(
                width: 300,
                height: 50,
                child: Center(child: Text('Histórico de Doenças')),
              ),
            ),
            SizedBox(height: 36),
            ElevatedButton(
              onPressed: () {
                // Navegar para a página de lembretes veterinários
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => VeterinaryRemindersPage()),
                 );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
              child: SizedBox(
                width: 300,
                height: 50,
                child: Center(child: Text('Lembretes Veterinários')),
              ),
            ),
            SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
