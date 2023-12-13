import 'package:aplicativo_final_v1/main.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _introShown = false;

  @override
  void initState() {
    super.initState();
    // Mostra a tela de introdução e inicia o temporizador apenas uma vez
    _showIntro();
  }

  // Função para mostrar a tela de introdução e iniciar o temporizador
  Future<void> _showIntro() async {
    await Future.delayed(Duration(seconds: 5)); // adequar conforme necessário
    if (mounted) {
      setState(() {
        _introShown = true;
      });
      // Navegar para a tela principal após a introdução
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/fundo_app_V3.png', // TO DO: IMAGEM MELHOR
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.center,
              child: _introShown
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 320),
                  Text(
                    'Versão Beta: 0.4 - limitada para testes',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 320),
                  Text(
                    'Versão Beta: 0.4 - limitada para testes',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}