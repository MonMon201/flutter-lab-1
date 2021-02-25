import 'package:flutter/material.dart';

void main() => runApp(Lab());

class Name {
  String name;
  Name(String name) {
    this.name = name;
  }
  String getName() => name;
  String setName(String newName) => name = newName;
}

class Lab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String incorrectName = 'Bob';
    String correctName = 'Vasylynenko Daniil';

    Name name = new Name(incorrectName);

    return MaterialApp(
      title: 'Lab 1.',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World.'),
        ),
        body: Center(
          child: Text(
              'This lab isn\'t ${name.getName()}\'s, it\'s ${name.setName(correctName)}\'s.'),
        ),
      ),
    );
  }
}
