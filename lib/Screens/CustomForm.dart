import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:hive/hive.dart';

class CustomForm extends StatelessWidget {
  final _nameController = TextEditingController();
  final _detailController = TextEditingController();
  BuildContext _context;
  _addTodo() {
    String id = randomAlpha(10).toLowerCase();
    String name = this._nameController.text;
    String detail = this._detailController.text;
    Hive.box("todos").add({"id": id, "name": name, "detail": detail});
    Navigator.pop(_context);
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Form(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              controller: _nameController,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Details',
              ),
              controller: _detailController,
              maxLines: 5,
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text("Save"),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: _addTodo,
            )
          ],
        ),
      ),
    );
  }
}
