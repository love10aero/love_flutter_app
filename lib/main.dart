// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Love Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: MyHomePage(
          title: 'Application users',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: PageView(
          children: [AddUser(), ShowUser()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Wrap(
      spacing: 20, // to apply margin in the main axis of the wrap
      runSpacing: 20, // to apply margin in the cross axis of the wrap
      children: [
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            labelText: 'Name *',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person_search),
            labelText: 'Surname *',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            labelText: 'Email *',
          ),
        ),
        Center(
          child: Container(
            width: 500,
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    AlertDialog(
                      actions: [Text('data')],
                    );
                  });
                },
                child: Icon(Icons.save)),
          ),
        ),
      ],
    )));
  }
}

class ShowUser extends StatelessWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Table(
          children: [
            TableRow(children: [Text('data'), Text('data2')]),
            TableRow(children: [Text('data3'), Text('data4')])
          ],
        ),
      ),
    );
  }
}
