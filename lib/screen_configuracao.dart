import 'package:aplicativo_final_v1/main.dart';
import 'package:aplicativo_final_v1/screen_odometro_0a10.dart';
import 'package:aplicativo_final_v1/screen_odometro_0a5.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: ConfigScreen(),
    ),
  );
}

class ConfigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(260.0, 8.0, 160.0, 150.0), // Ajuste a terceira propriedade para controlar o espaço inferior
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // Centraliza na horizontal
          children: [
            Text(
              'Configurações do Odômetro de Cobertura',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OdometroZeroCincoScreen(densidadeGotas: densidadeGotas),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Substitua "Colors.blue" pela cor desejada
              ),
              child: Text('Definir Odômetro de Cobertura para escala de 0-5%', textScaleFactor: 1.2,),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OdometroScreen(densidadeGotas: densidadeGotas),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Substitua "Colors.blue" pela cor desejada
              ),
              child: Text('Definir Odômetro de Cobertura para escala de 0-10%', textScaleFactor: 1.2),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Substitua "Colors.blue" pela cor desejada
              ),
              child: Text('Definir Odômetro de Cobertura para escala de 0-20%', textScaleFactor: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}

