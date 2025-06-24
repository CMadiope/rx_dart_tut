import 'package:flutter/foundation.dart' show immutable;
import 'package:rx_dart_tut/models/thing.dart';

enum AnimalType { dog, cat, rabbit, unknown }

@immutable
class Person extends Thing {
  final int age;

  const Person({required String name, required this.age}) : super(name: name);

  @override
  String toString() => "Person, name:$name, age:$age";

  Person.fromJson(Map<String, dynamic> json)
    : age = json['age'] as int,
      super(name: json['name'] as String);
}
