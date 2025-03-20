import 'package:flutter/material.dart';


class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Második oldal",
        debugShowCheckedModeBanner: false,
        home: const MySecondPage(title: 'Második oldal'),
    );
  }
}

class MySecondPage extends StatefulWidget {
  const MySecondPage({super.key, required this.title});
  final String title;

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}
class _MySecondPageState extends State<MySecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
