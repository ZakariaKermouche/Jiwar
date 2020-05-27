import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;
  final IconData icon;

  Category({this.name, this.color, this.icon});
}


final Category environmentCategory = Category(
  color: Colors.blue,
  name: "Care",
  icon: Icons.home,
);

final Category spirituelCategory = Category(
  color: Colors.green,
  name: "Spirituel",
  icon: Icons.brightness_4,
); 
final Category randCategory = Category(
  color: Colors.red,
  name: "Random",
  icon: Icons.calendar_today,
); 

final Category testCategory = Category(
  color: Colors.purple,
  name: "test",
  icon: Icons.call_merge,
); 


 List<Category> categories = [
  environmentCategory,
  spirituelCategory,
  environmentCategory,
  spirituelCategory,
  randCategory,
  testCategory,
];
