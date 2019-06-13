// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'dart:async';

import 'package:flutter_web/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Main()));
}

bool isSmall(BuildContext context) {
  return MediaQuery.of(context).size.width < 800;
}

bool isLarge(BuildContext context) {
  return MediaQuery.of(context).size.width > 1200;
}

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  // Frases
  var quotes = <String, String>{
    "A vida é feita de quatro dias e meio": "4dias",
    "Analisa bem as situações. Trabalha para tudo o que pode ocorrer":
        "primeira",
    "Todos os que estão para lá são inimigos e querem deixar-te mal": "segunda",
    "Tens de pensar, não observar. Assim nunca mais fazes nada por ti":
        "terceira",
    "Sucesso é a soma de pequenos fracassos": "quarta",
    "Às vezes as coisas não nos parecem importantes, mas a qualquer momento podem ser":
        "quinta",
    "A melhor forma de ultrapassar os problemas é andando": "sexta",
    "Os idiotas são aqueles que pensam": "setima",
    "A vida é uma aventura, logo, qual é o stress?": "oitava",
  };

  // Gera número aleatório
  int _randomNumber() {
    var random = new Random();
    return random.nextInt(quotes.length);
  }

  var rnd;

  @override
  Widget build(BuildContext context) {
    rnd = _randomNumber();

    // Gera número aleatório a cada 7 segundos
    const Sec = const Duration(seconds: 7);
    new Timer.periodic(
        Sec,
        (Timer t) => setState(() {
              rnd = _randomNumber();
            }));

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: new AssetImage(quotes.values.elementAt(rnd) + '.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () => _showAboutModal(context),
                  child: Text(
                    "Sobre",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: isLarge(context) ? 20 : 50),
                  ),
                ),
                FlatButton(
                  onPressed: () => _showCreditsModal(context),
                  child: Text(
                    "Créditos",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: isLarge(context) ? 20 : 50),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Já dizia o Jorge:",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: isLarge(context) ? 50 : 60,
                          fontWeight: FontWeight.w100),
                    ),
                    Text("\"" + quotes.keys.elementAt(rnd) + "\"",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: isLarge(context) ? 40 : 45,
                            fontWeight: FontWeight.bold)),
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showAboutModal(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Sobre",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isLarge(context) ? 20 : 40),
                ),
                Container(
                  height: 30,
                ),
                Text(
                    "Este website tem como objetivo prestar uma homenagem ao nosso professor de FAC e TP, Jorge Vieira. Todas as frases foram ditas pelo mesmo no decorrer de todo o ano letivo.\nEste website também serve como um agradecimento por tudo o que o nosso professor nos ensinou. Não só programação nem como funciona um sistema operativo, mas também em como ultrapassarmos todos os obstáculos que vamos enfrentar na vida. \nAs suas aulas não são apenas dar matéria, são uma terapia para a maioria dos alunos.\nAbraços académicos!",
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        );
      });
}

void _showCreditsModal(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Créditos",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isLarge(context) ? 20 : 40),
                ),
                Container(
                  height: 30,
                ),
                Text(
                    "Idealização: Miguel Ferreira e Vasco Martins\nDesign: Vasco Martins\nProgramação: Vasco Martins e Miguel Ferreira",
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        );
      });
}
