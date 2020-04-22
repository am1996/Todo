import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'CustomForm.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  void _showModal(Widget custom) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [custom],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            this._showModal(CustomForm());
          },
          tooltip: 'Add Todo',
          child: Icon(Icons.add),
        ),
        body: this._listView());
  }

  Widget _listView() {
    return WatchBoxBuilder(
        box: Hive.box("todos"),
        builder: (BuildContext context, todoBox) {
          return ListView.builder(
              itemCount: todoBox.length,
              itemBuilder: (BuildContext context, int index) {
                var todo = todoBox.getAt(index);
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/detail",
                      arguments: <String, String>{
                        "name": todo["name"],
                        "detail": todo["detail"]
                      },
                    );
                  },
                  title: Text(todo["name"]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          todoBox.deleteAt(index);
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
