import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 26, 100, 1),
        title: Text('Tela Principal'),
      ), 
      backgroundColor: Color.fromRGBO(1, 26, 100, 1),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            SizedBox(height: 16),


            Expanded(
              child: SizedBox(
                width: 300,
                
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a lista de animais
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AnimalListPage()),
                    // );
                  }, 
                  style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Define o raio de curvatura das bordas
          ),
        ),
      ),
                  child: Text('Animais Registrados'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SizedBox(
                width: 300,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de cadastro de animais
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AddAnimalPage()),
                    // );
                  },
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Define o raio de curvatura das bordas
          ),
        ), ),
                  child: Text('Cadastrar Novo Animal'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de registro de vacinas
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => VaccinationPage()),
                    // );
                  },
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Define o raio de curvatura das bordas
          ),
        ),
                  ),
                  child: Text('Registro de Vacinas'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de controle de parasitas
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ParasiteControlPage()),
                    // );
                  },
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Define o raio de curvatura das bordas
          ),
        ), ),
                  child: Text('Controle de Parasitas'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de histórico de doenças
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => DiseaseHistoryPage()),
                    // );
                  },
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Define o raio de curvatura das bordas
          ),
        ), ),
                  child: Text('Histórico de Doenças'),
                ),
              ),
            ),
            SizedBox(height:16),
            Expanded(
              child: SizedBox(
                
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de lembretes veterinários
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => VeterinaryRemindersPage()),
                    // );
                  },
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Define o raio de curvatura das bordas
          ),
        ), ),
                  child: Text('Lembretes Veterinários'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de configurações
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SettingsPage()),
                    // );
                  },
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Define o raio de curvatura das bordas
          ),
        ), ),
                  child: Text('Configurações'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
