import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: SobreScreen(),
    ),
  );
}

class SobreScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Sobre'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Alan Mathias', textScaleFactor: 1.1),
                subtitle: Text('Desenvolvedor'),
              ),
              ListTile(
                title: Text('Contato:'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('alan.mathias@ufpr.br'),
                    Text('alanmathiasctt@gmail.com'),
                    Text('http://lattes.cnpq.br/0010138472533232'),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Rogério Ferreira', textScaleFactor: 1.1),
                subtitle: Text('Desenvolvedor - Orientador'),
              ),
              ListTile(
                title: Text('Contato:'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('rogerio.ferreira@ufpr.br'),
                    Text('http://lattes.cnpq.br/1569608737708135'),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Ralph Rabelo Andrade', textScaleFactor: 1.1),
                subtitle: Text('Fiscal de Defesa Agropecuária '),
              ),
              ListTile(
                title: Text('Contato:'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ralph@adapar.pr.gov.br'),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
