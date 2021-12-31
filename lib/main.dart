import 'package:flutter/material.dart';
import 'package:gstock/login.dart';
import 'package:gstock/routing.dart';
import 'addcom.dart';
import 'singup.dart';
import 'homepage2.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}
