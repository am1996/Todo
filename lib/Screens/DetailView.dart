import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final String _name;
  final String _detail;
  DetailView(this._name, this._detail);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._name),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            this._detail,
            style: TextStyle(
              fontSize: 20,
            ),
          )),
    );
  }
}
