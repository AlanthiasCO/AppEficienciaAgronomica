import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SecondScreen extends StatelessWidget {
  final double densidadeGotas;
  double top = -10; //area da tela

  SecondScreen({required this.densidadeGotas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indicadores de Referência', textScaleFactor: 1),
        toolbarHeight: 45.0,
        backgroundColor: Colors.blue[900],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 450,
            top: 255,
            child: Image.asset(
              'assets/legenda_pg_2.png',
              width: 300, // tamanho da imagem
              height: 300, // tamanho
            ),
          ),
          Positioned( // ultimo odometro
            left: 650, // Ajuste as coordenadas X conforme necessário
            top: top,    // Ajuste as coordenadas Y conforme necessário
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: OdometroInseticida(densidadeGotas),
              ),
            ),
          ),
          Positioned( //odometro meio
            left: 320, // Ajuste as coordenadas X conforme necessário
            top: top,    // Ajuste as coordenadas Y conforme necessário
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: OdometroFungicida(densidadeGotas),
              ),
            ),
          ),
           Positioned( // primeiro odometro
            left: 10, // Ajuste as coordenadas X conforme necessário
            top: top,   // Ajuste as coordenadas Y conforme necessário
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: OdometroHerbicida(densidadeGotas),
              ),
            ),
          ),
          Positioned(
            left: 700,
            bottom: 10,
            child: ElevatedButton(
              onPressed: () {
                // Navegar de volta para a tela principal
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Substitua "Colors.blue" pela cor desejada
              ),
              child: Text('Voltar para a Tela Principal', textScaleFactor: 1),
            ),
          ),
          Positioned(
            left: 20,
            bottom:20,
            child: Text('Observações: \n\n(1) Este é um modelo teórico, visa estimar a cobertura da aplicação\nconforme três parâmetros: taxa de aplicação, tamanho da gota e IAF.\n'
                '\n(2) Para os cálculos, considerou-se um tamanho único de gotas e a \nausência de perdas por seca das gotas ou deriva.', textScaleFactor: 1.2),
          ),
        ],
      ),
    );
  }
}

Widget OdometroHerbicida(double densidadeGotas){
  double size = 0.8;
  return SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 100,
        showLabels: true,
        majorTickStyle: MajorTickStyle(length: 30),
        radiusFactor: size, // Ajuste o valor da variavel size conforme necessário
        ranges: <GaugeRange>[
          GaugeRange(
            startValue: 0,
            endValue: 10,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 10,
            endValue: 20,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 20,
            endValue: 30,
            color: Colors.blue[900], // HERBICIDA SISTEMICO
          ),
          GaugeRange(
            startValue: 30,
            endValue: 40,
            color: Colors.orange, // Defina a cor
          ),
          GaugeRange(
            startValue:40,
            endValue: 50,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 50,
            endValue: 60,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 60,
            endValue: 70,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 70,
            endValue: 80,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 80,
            endValue: 90,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 90,
            endValue: 100,
            color: Colors.white30,
          ),
        ],
        pointers: <GaugePointer>[
          MarkerPointer(
            value: densidadeGotas,
            enableDragging: true,
            markerWidth: 20,
            markerHeight: 20,
            markerOffset: -15,
            color: Colors.indigo,
          ),
        ],
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
            positionFactor: 0.5,
            verticalAlignment: GaugeAlignment.center,
            angle: 90,
            widget: Text(
              densidadeGotas.toStringAsFixed(2) + "\n\n\n\n\n HERBICIDAS",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget OdometroFungicida(double densidadeGotas){
  double size = 0.8;
  return SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 100,
        showLabels: true,
        majorTickStyle: MajorTickStyle(length: 30),
        radiusFactor: size, // Ajuste o valor da variavel size conforme necessário
        ranges: <GaugeRange>[
          GaugeRange(
            startValue: 0,
            endValue: 10,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 10,
            endValue: 20,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 20,
            endValue: 30,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 30,
            endValue: 40,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue:40,
            endValue: 50,
            color: Colors.orange,
          ),
          GaugeRange(
            startValue: 50,
            endValue: 60,
            color: Colors.orange, // Defina a cor
          ),
          GaugeRange(
            startValue: 60,
            endValue: 70,
            color: Colors.orange, // Defina a cor
          ),
          GaugeRange(
            startValue: 70,
            endValue: 80,
            color: Colors.blue[900], // Defina a cor
          ),
          GaugeRange(
            startValue: 80,
            endValue: 90,
            color: Colors.blue[900], // Defina a cor
          ),
          GaugeRange(
            startValue: 90,
            endValue: 100,
            color: Colors.blue[900], // Defina a cor
          ),
        ],
        pointers: <GaugePointer>[
          MarkerPointer(
            value: densidadeGotas,
            enableDragging: true,
            markerWidth: 20,
            markerHeight: 20,
            markerOffset: -15,
            color: Colors.indigo,
          ),
        ],
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
            positionFactor: 0.5,
            verticalAlignment: GaugeAlignment.center,
            angle: 90,
            widget: Text(
              densidadeGotas.toStringAsFixed(2) + "\n\n\n\n\n FUNGICIDAS",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget OdometroInseticida(double densidadeGotas){
  double size = 0.8;
  return SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 100,
        showLabels: true,
        majorTickStyle: MajorTickStyle(length: 30),
        radiusFactor: size, // Ajuste o valor da variavel size conforme necessário
        ranges: <GaugeRange>[
          GaugeRange(
            startValue: 0,
            endValue: 10,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 10,
            endValue: 20,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 20,
            endValue: 30,
            color: Colors.blue[900], //  INSETICIDA SISTEMICO
          ),
          GaugeRange(
            startValue: 30,
            endValue: 40,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue:40,
            endValue: 50,
            color: Colors.orange,
          ),
          GaugeRange(
            startValue: 50,
            endValue: 60,
            color: Colors.orange, // Defina a cor
          ),
          GaugeRange(
            startValue: 60,
            endValue: 70,
            color: Colors.orange, // Defina
          ),
          GaugeRange(
            startValue: 70,
            endValue: 80,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 80,
            endValue: 90,
            color: Colors.white30,
          ),
          GaugeRange(
            startValue: 90,
            endValue: 100,
            color: Colors.white30,
          ),
        ],
        pointers: <GaugePointer>[
          MarkerPointer(
            value: densidadeGotas,
            enableDragging: true,
            markerWidth: 20,
            markerHeight: 20,
            markerOffset: -15,
            color: Colors.indigo,
          ),
        ],
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
            positionFactor: 0.5,
            verticalAlignment: GaugeAlignment.center,
            angle: 90,
            widget: Text(
              densidadeGotas.toStringAsFixed(2) + "\n\n\n\n\n INSETICIDAS",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ],
  );
}
