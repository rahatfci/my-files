import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          Text(
            'Simple file explorer made with Flutter by Abdur Rahman Rahat :)',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blueGrey),
          )
        ],
      ),
    );
  }
}
