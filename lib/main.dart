import 'package:aplicativo_final_v1/iafLinearGauge.dart';
import 'package:aplicativo_final_v1/intro_screen.dart';
import 'package:aplicativo_final_v1/defaultLinearGauge.dart';
import 'package:aplicativo_final_v1/screen_configuracao.dart';
import 'package:aplicativo_final_v1/tela_sobre.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'second_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double taxaAplicacao = 100;
  double diametroGotas = 300;
  double indiceAreaFoliar = 1;
  double densidadeGotas = 0.0;
  double cobertura = 0.0;

  //variaveis do linear gauge
  double firstPointerValue = 30;
  double secondPointerValue = 70;

  double indiceAreaFoliarMin = 0.0;
  double indiceAreaFoliarMax = 10.0;
  double indiceAreaFoliarInterval = 0.5;

  TextEditingController taxaAplicacaoController = TextEditingController();
  TextEditingController indiceAreaFoliarController = TextEditingController();
  TextEditingController diametroGotasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taxaAplicacaoController.text = taxaAplicacao.toString();
    indiceAreaFoliarController.text = indiceAreaFoliar.toString();
    diametroGotasController.text = diametroGotas.toString();
    calcularResultados();
  }

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;

    print('Largura da tela: $larguraTela');
    print('Altura da tela: $alturaTela');

    return Scaffold(
      resizeToAvoidBottomInset: false, //não permite que a tela seja esticada quando o teclado está aberto
      appBar: AppBar(
        title: Text('Calculadora de Densidade de Gotas e Cobertura'),
        toolbarHeight: 45,
        backgroundColor: Colors.blue[900],
        leading: PopupMenuButton<String>(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'sobre',
              child: Text('Sobre'),
            ),
            PopupMenuItem(
              value: 'configuracoes',
              child: Text('Configurações'),
            ),
          ],
          onSelected: (value) {
            if (value == 'sobre') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SobreScreen()),
              );
            } else if (value == 'configuracoes') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ConfigScreen()),
              );
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            construtorLinha("Taxa de Aplicação: ", taxaAplicacao, taxaAplicacaoController, (newValue) {
                              setState(() {
                                taxaAplicacao = double.parse(newValue);
                                calcularResultados();
                              });
                            }),
                            SizedBox(
                              width: 100.0, // Largura do TextFormField
                            ),
                          ],
                        ),
                        DefaultLinearGauge(
                          value: taxaAplicacao,
                          onChanged: (value) => atualizarValor(value, () {
                            taxaAplicacao = value.roundToDouble();
                          }),
                          onChangedTextField: (newValue) {
                            taxaAplicacaoController.text = newValue;
                          },
                          gaugeColor: Colors.deepPurple,
                        ),

                        SizedBox(height: 17.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            construtorLinha("Indice de Area Foliar (IAF): ", indiceAreaFoliar, indiceAreaFoliarController, (newValue) {
                              setState(() {
                                indiceAreaFoliar = double.parse(newValue);
                                calcularResultados();
                              });
                            }),

                            SizedBox(width: 8.0), // Espaçamento entre os elementos
                            SizedBox(
                              width: 0, // Largura do TextFormField
                            ),
                          ],
                        ),
                        iafLinearGauge(
                          value: indiceAreaFoliar,
                          onChanged: (value) => atualizarValor(value, () {
                            indiceAreaFoliar = value;
                          }),
                          onChangedTextField: (newValue) {
                            indiceAreaFoliarController.text = newValue;
                          },
                          min: indiceAreaFoliarMin,
                          max: indiceAreaFoliarMax,
                          interval: indiceAreaFoliarInterval, gaugeColor: Colors.deepPurple,
                        ),
                        SizedBox(height: 17.5),
                        _buildDiametroLinearGauge("Diâmetro das Gotas: ", diametroGotas, 0, 1000, 80),
                        SizedBox(width: 8.0), // Espaçamento entre os elementos
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: OdometroGotasCm(),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: OdometroCobertura(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(densidadeGotas: densidadeGotas),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Substitua "Colors.blue" pela cor desejada
              ),
              child: Text('Indicadores de Referência'),
            ),
          ],
        ),
      ),
    );
  }

  Widget construtorLinha(String label, double value, TextEditingController controller, Function onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          textScaleFactor: 1.3,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 100.0,
          child: TextFormField(
            controller: controller,
            onChanged: (newValue) {
              onChanged(newValue);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              border: OutlineInputBorder( // Adiciona borda ao redor do campo
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder( // Define a aparência da borda quando o campo está em foco
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold, //  negrito
            ),

            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d+\.?\d{0,2}$'),)
            ], // Aceitar apenas dígitos
            //decoration: InputDecoration(labelText: label),
          ),
        ),
      ],
    );
  }


  Widget OdometroGotasCm(){
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: true,
          majorTickStyle: MajorTickStyle(length: 10),
          radiusFactor: 0.9, // Ajuste o valor conforme necessário
          //DEIXA A BARRA MAIS GROSSA \/
          //axisLineStyle: AxisLineStyle(thickness: 20),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 10,
              color: Colors.blue[100],
            ),
            GaugeRange(
              startValue: 10,
              endValue: 20,
              color: Colors.blue[200],
            ),
            GaugeRange(
              startValue: 20,
              endValue: 30,
              color: Colors.blue[300],
            ),
            GaugeRange(
              startValue: 30,
              endValue: 40,
              color: Colors.blue[400],
            ),
            GaugeRange(
              startValue: 40,
              endValue: 50,
              color: Colors.blue[500],
            ),
            GaugeRange(
              startValue: 50,
              endValue: 60,
              color: Colors.blue[600],
            ),
            GaugeRange(
              startValue: 60,
              endValue: 70,
              color: Colors.blue[700],
            ),
            GaugeRange(
              startValue: 70,
              endValue: 80,
              color: Colors.blue[800],
            ),
            GaugeRange(
              startValue: 80,
              endValue: 90,
              color: Colors.blue[900],
            ),
            GaugeRange(
              startValue: 90,
              endValue: 100,
              color: Colors.red,
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
              angle: 90,
              widget: Text(
                densidadeGotas.toStringAsFixed(2) + "\n\n\n" + "Gotas",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget OdometroCobertura(){
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 20,
          showLabels: true,
          majorTickStyle: MajorTickStyle(length: 10),
          radiusFactor: 0.9, // Ajuste o valor conforme necessário
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 2,
              color: Colors.cyan[100], // Defina a cor inicial para valores baixos
            ),
            GaugeRange(
              startValue: 2,
              endValue: 4,
              color: Colors.cyan[200], // Defina a cor inicial para valores baixos
            ),
            GaugeRange(
              startValue: 4,
              endValue: 6,
              color: Colors.cyan[300], // Defina a cor inicial para valores baixos
            ),
            GaugeRange(
              startValue: 6,
              endValue: 8,
              color: Colors.cyan[400], // Defina a cor inicial para valores baixos
            ),
            GaugeRange(
              startValue: 8,
              endValue: 10,
              color: Colors.cyan[500], // Defina a cor inicial para valores baixos
            ),
            GaugeRange(
              startValue: 10,
              endValue: 12,
              color: Colors.cyan[600], // Defina a cor inicial para valores baixos
            ),
            GaugeRange(
              startValue: 12,
              endValue: 14,
              color: Colors.cyan[700], // Defina a cor inicial para valores baixos
            ),
            GaugeRange(
              startValue: 14,
              endValue: 16,
              color: Colors.cyan[800], // Defina a cor inicial para valores baixos
            ),
            GaugeRange(
              startValue: 16,
              endValue: 18,
              color: Colors.cyan[900], // Defina a cor inicial para valores baixos
            ),
            GaugeRange(
              startValue: 18,
              endValue: 20,
              color: Colors.red, // Defina a cor inicial para valores baixos
            ),
          ],
          pointers: <GaugePointer>[
            MarkerPointer(
              value: cobertura,
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
                cobertura.toStringAsFixed(2) + "%" + "\n\n\n" + "Cobertura",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDiametroLinearGauge(String label, double value, double min, double max, double interval) {
    List<LinearGaugeRange> gaugeRanges = [
      LinearGaugeRange(
        startValue: 0,
        endValue: 140,
        color: Colors.red,
      ),
      LinearGaugeRange(
        startValue: 140,
        endValue: 253,
        color: Colors.orange,
      ),
      LinearGaugeRange(
        startValue: 253,
        endValue: 369,
        color: Colors.yellow,
      ),
      LinearGaugeRange(
        startValue: 369,
        endValue: 426,
        color: Colors.blue,
      ),
      LinearGaugeRange(
        startValue: 426,
        endValue: 515,
        color: Colors.green,
      ),
      LinearGaugeRange(
        startValue: 515,
        endValue: 686,
        color: Colors.white54,
      ),
      LinearGaugeRange(
        startValue: 686,
        endValue: 1000,
        color: Colors.black,
      ),
    ];

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 0.0), // Espaço entre o TextFormField e o LinearGauge
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                textScaleFactor: 1.3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                width: 100.0,
                child: TextFormField(
                  controller: diametroGotasController,
                  onChanged: (newValue) {
                    setState(() {
                      diametroGotas = double.parse(newValue);
                      calcularResultados();
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    border: OutlineInputBorder( // Adiciona borda ao redor do campo
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder( // Define a aparência da borda quando o campo está em foco
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold, //  negrito
                    ),
                  //maxLines: 1,  numero de linhas teclado
                  inputFormatters: [FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}$'),)],
                ),
              ),
            ],
          ),
        ),
        Text(
          getGaugeDescription(value),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SfLinearGauge(
          minimum: min,
          maximum: max,
          interval: interval,
          ranges: gaugeRanges,
          markerPointers: [
            LinearWidgetPointer(
              value: value,
              dragBehavior: LinearMarkerDragBehavior.constrained,
              onChanged: (value) {
                setState(() {
                  diametroGotas = value;
                  calcularResultados();
                  diametroGotasController.text = value.round().toString();


                });
              },
              position: LinearElementPosition.outside,
              child: Icon(Icons.arrow_drop_down_circle_outlined,
                  color: Colors.deepPurple, size: 30),
            ),
          ],
        ),
      ],
    );
  }

  String getGaugeDescription(double value) {
    if (value >= 0 && value < 140) {
      return "Muito Fina";
    } else if (value >= 140 && value < 253) {
      return "Fina";
    } else if (value >= 253 && value < 369) {
      return "Média";
    } else if (value >= 369 && value < 426) {
      return "Grossa";
    } else if (value >= 426 && value < 515) {
      return "Muito Grossa";
    } else if (value >= 515 && value < 686) {
      return "Extremamente Grossa";
    } else {
      return "Ultra Grossa";
    }
  }

  void calcularResultados() {
    final pi = 3.14159265359; // talvez um import direto de alguma biblioteca que tenha o PI
    densidadeGotas = (6 * pow(10, 7) * taxaAplicacao) /
        ((indiceAreaFoliar * pi) * pow(diametroGotas, 3));
    cobertura = (0.15 * taxaAplicacao) / (diametroGotas * indiceAreaFoliar) * 100;
  }

  void atualizarValor(double value, Function callback) {
    setState(() {
      callback();
      calcularResultados();
    });
  }

}
