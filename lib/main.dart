import 'package:flutter/material.dart';
import 'package:todo/Screens/DetailView.dart';
import 'package:todo/Screens/HomeScreen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  //ensuring binding happens before initializing path graping service
  WidgetsFlutterBinding.ensureInitialized();
  final path = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(path.path);
  runApp(MyApp());
  Hive.box("todos").clear();
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: "/",
      onGenerateRoute: _routes(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, String> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case "/":
          screen = FutureBuilder(
              future: Hive.openBox("todos"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError)
                    return Text(snapshot.error.toString());
                  else
                    return HomeScreen(title: 'Todo');
                } else {
                  return Scaffold();
                }
              });
          break;
        case "/detail":
          screen = DetailView(arguments["name"], arguments["detail"]);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (context) => screen);
    };
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
