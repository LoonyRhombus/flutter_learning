import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MySecondPage(title: 'Második oldal');
  }
}

class MySecondPage extends StatefulWidget {
  const MySecondPage({super.key, required this.title});
  final String title;

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}
class _MySecondPageState extends State<MySecondPage> {
  Timer? _timer;
  final FocusNode _focusNode = FocusNode();
  int goBottom = 0;
  int goLeft = 0;
  int heading = 90;

  @override
  void initState() {
    super.initState();
    // Automatikusan fókuszál a widget betöltésekor
    _focusNode.requestFocus();
    snakeMove();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void snakeMove() {
  _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
    setState(() {
      final screenSize = MediaQuery.of(context).size;
      final objectSize = 50; // A piros kocka mérete

      switch (heading) {
        case 0: // Felfelé
          goBottom += 10;
          if (goBottom >= screenSize.height-56) {
            goBottom = -objectSize; // Átugrás a másik oldalra
          }
          break;
        case 180: // Lefelé
          goBottom -= 10;
          if (goBottom < -objectSize) {
            goBottom = screenSize.height.toInt()-56; // Átugrás felülre
          }
          break;
        case 90: // Jobbra
          goLeft += 10;
          if (goLeft >= screenSize.width) {
            goLeft = -objectSize; // Átugrás a bal oldalra
          }
          break;
        case 270: // Balra
          goLeft -= 10;
          if (goLeft < -objectSize) {
            goLeft = screenSize.width.toInt(); // Átugrás jobb oldalra
          }
          break;
      }
    });
  });
}

   KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      setState(() {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          heading = 0;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          heading = 180;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          heading = 90;
        }
        else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          heading = 270;
        }
      });
    }
    // KeyEventResult.handled: Megakadályozza, hogy a key event tovább menjen
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Focus(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,  // Az új onKeyEvent használata
        child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: <Widget>[
          Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[ 
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed:() {
                        Navigator.popUntil(
                        context,
                        (Route<dynamic> route) => route.isFirst,
                      );
                      heading = -1;
                    },
                child: Text('<-'),
              ),
            ],
          ),
          ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            bottom: goBottom * 1,
            left: goLeft * 1,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.red,
            ),
          ),
        ],
      ),
    ),
    );
  }
}
