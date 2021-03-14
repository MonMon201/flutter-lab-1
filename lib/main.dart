import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Get/Set

class Name {
  String name;
  Name(String name) {
    this.name = name;
  }
  String getName() => name;
  String setName(String newName) => name = newName;
}

// ?? + def param + collections: list, map, set

class Collections {
  List<int> l;
  Set<int> s = {1, 2, 3};
  Map<String, String> m = {'name': 'Not Dania'};
  Collections({this.l = const [3, 4, 10, null]});
  List<int> getList() => this.l;
  List<int> getFilteredList() => this.l.map((el) => el ?? 6).toList();
  Set<int> getSet() => this.s;
  Map<String, String> getMap() => this.m;
  setName(String value) => this.m['name'] = value;
  addToSet(Set<int> n) => this.s.addAll(n);
}

// Initial/Factory constructor

abstract class Animal {
  factory Animal(bool dog) => dog ? Dog() : Cat();
  void voice();
}

class Dog implements Animal {
  @override
  void voice() {
    print("Dog says: woof!");
  }
}

class Cat implements Animal {
  @override
  void voice() {
    print("Cat says: meow!");
  }
}

class Point {
  int x;
  int y;
  String name;
  Random random;

  Point(int x, int y, String name) {
    this.x = x;
    this.y = y;
    this.name = name;
  }

  Point.initDefaultPoint()
      : x = 0,
        y = 0,
        name = 'default';

  Point.initRandomPoint() : name = 'default' {
    this.x = this.random.nextInt(100) + 1;
    this.y = this.random.nextInt(100) + 1;
  }

  String getPoint() {
    return '\n$name point coors:\n x: ${this.x}, y: ${this.y}\n';
  }

  void move(int step) {
    this.x += step;
    this.y += step;
  }
}

// Closure

Function getListOfPoints(int step) {
  List<String> innerFunction(int amount) {
    List<Point> points = [];
    for (int i = 0; i < amount; i++) {
      var p = new Point.initDefaultPoint();
      p.move(step * i);
      points.add(p);
    }
    var coors = points.map((e) => e.getPoint()).toList();
    return coors;
  }

  return innerFunction;
}

List<String> getListOfRandomPoints(int amount) {
  List<Point> points = [];
  for (int i = 0; i < amount; i++) {
    points.add(new Point.initRandomPoint());
  }
  var coors = points.map((e) => e.getPoint()).toList();
  return coors;
}

class Part {
  int weight;
  Part(int weight) {
    this.weight = weight;
  }
}

mixin Breakable {
  bool broken = false;
  void breakWith(String reason) {
    broken = !broken;
    print('Broke because of $reason');
  }
}

class Carriage extends Part {
  String color;
  Carriage(int weight, String color) : super(weight) {
    this.color = color;
  }
}

class Engine extends Part with Breakable {
  int power;
  Engine(int weight, int power) : super(weight) {
    this.power = power;
  }
  @override
  void breakWith(String reason) {
    print('Engine breakdown!');
    super.breakWith(reason);
  }
}

class Vehicle {
  String name;
  Engine engine;
  Carriage carriage;

  Vehicle(String name, Engine engine, Carriage carriage) {
    this.name = name;
    this.engine = engine;
    this.carriage = carriage;
  }

  void enigneBreakdown(String reason) {
    print('${this.name} is in trouble:');
    this.engine.breakWith(reason);
  }
}

// assert

bool filter(int number) => number > 5 ? true : false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String incorrectName = 'Bob';
    String correctName = 'Vasylynenko Daniil';

    Name name = new Name(incorrectName);

    // ??, def param, collections
    Collections collections = new Collections();
    print('List as default param: ${collections.getList()}');
    print('List mapped with filter: ${collections.getFilteredList()}');
    print('Set: ${collections.getSet()}');
    collections.addToSet({2, 3});
    print('Trying add to set existing value ${collections.getSet()}');
    collections.addToSet({4, 5});
    print('Trying add to set non-existing value ${collections.getSet()}');
    print('Getting map ${collections.getMap()['name']}');
    collections.setName('Dania');
    print('Setting map');
    print('Getting map ${collections.getMap()['name']}');
    Vehicle car =
        new Vehicle('Car', new Engine(50, 10), new Carriage(150, 'red'));
    // mixin
    print('Show how mixin works:');
    car.enigneBreakdown('Unknown reason');
    // closure + initial constructor
    print('Show how closures work:');
    var step5 = getListOfPoints(5);
    var step10 = getListOfPoints(10);
    var point5 = step5(3);
    var point10 = step10(3);
    print(point5);
    print(point10);
    // assert
    print('Show how assert work:');
    assert(filter(4));
    // factory
    var cat = new Animal(false);
    cat.voice();
    var dog = new Animal(true);
    dog.voice();

    return MaterialApp(
        title: 'Lab 1.',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Hello World.'),
          ),
          body: Center(
            child: Text(
                'This lab isn\'t ${name.getName()}\'s, it\'s ${name.setName(correctName)}\'s. \n'),
          ),
        ));
  }
}
