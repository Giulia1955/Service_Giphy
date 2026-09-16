import 'package:flutter/material.dart';
import 'package:api_gif/view/home_page.dart';
import 'package:api_gif/view/giphy_page.dart';
import 'package:api_gif/service/giphy_service.dart';
void main(){
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      hintColor: Colors.white,
    ),
    debugShowCheckedModeBanner: false,
  ));
}