import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = -1;
  int rndBottom = 0;
  int rndLeft = 0;

  @override
  Widget build(BuildContext context) {
    int generateRandomNumber(int min, int max) {
      var random = Random();
      return min + random.nextInt(max - min + 1);
    }
    int getMaxHeight() {
      int screenHeight = 0;
      return screenHeight = (MediaQuery.of(context).size.height).toInt()-112;
    }
    int getMaxWidth() {
      int screenWidth = 0;
      return screenWidth = (MediaQuery.of(context).size.width).toInt()-56;
    }
    void jumpTheButton(){
      rndBottom = generateRandomNumber(0, getMaxHeight());
      rndLeft = generateRandomNumber(0, getMaxWidth());
    }
    void timerButtonJumpingWhatever() {
      Timer.periodic(Duration(milliseconds: 750), (timer) {
        if (_counter > 10){
          timer.cancel();
        }
        else{
          setState(() {
            jumpTheButton();
          });
        }
      });
    }
    void incrementCounter() {
      setState(() {
        _counter++;
        //jumpTheButton();
      });
    }
    if (_counter < 0) {
      _counter++;
      timerButtonJumpingWhatever();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                //const SizedBox(height: 20), // Kis távolság a szöveg és a gomb között
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: -50 + (_counter * 10),
            child: Text("Congratulations"),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            bottom: rndBottom * 1,
            left: rndLeft * 1,
            child: FloatingActionButton(
              onPressed: incrementCounter,
              tooltip: 'Increment',
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
