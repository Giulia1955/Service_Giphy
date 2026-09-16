import 'package:flutter/material.dart';

class GiphyPage extends StatelessWidget {
  final Map _gifData;
  GiphyPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.network(
          "https://developers.giphy.com/branch/master/"
            "static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif",
            fit: BoxFit.contain,
            height: 40,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          _gifData['images']['fixed_height']['url'],
        ),
      ),
    );    
  }
}   
        