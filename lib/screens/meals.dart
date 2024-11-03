import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class Meals extends StatelessWidget {
  const Meals({super.key,required this.text,required this.meals});

final String text;
final List<Meal>meals;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: ,
      );
    
  }
}
