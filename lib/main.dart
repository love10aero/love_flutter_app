import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love_flutter_app/http_service.dart';
import 'package:love_flutter_app/post_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

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
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: PageView(
          children: [MyHomePage(title: 'title')],
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
  final HttpService httpService = HttpService();
  bool _languageButtonES = false;

  @override
  void initState() {
    S.load(Locale('en'));
    super.initState();
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
      // body: Center(
      //   child: PageView(
      //     children: [AddUser()],
      //   ),
      // ),
      body: Container(
        child: Center(
          child: Wrap(
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _languageButtonES = !_languageButtonES;
                      if (_languageButtonES) {
                        S.load(Locale('es'));
                      } else {
                        S.load(Locale('en'));
                      }
                      print(_languageButtonES);
                    });
                  },
                  child: _languageButtonES ? Text('ES') : Text('EN')),
              AddUser()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.youtube_searched_for), label: '1st'),
          BottomNavigationBarItem(icon: Icon(Icons.refresh), label: '2nd')
        ],
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class AddUser extends StatefulWidget {
  // const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final HttpService httpService = HttpService();
  final List<Map<String, String>> dataset = [];
  final _formKey = GlobalKey<FormState>();
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myname = TextEditingController();
  final mysurname = TextEditingController();
  final myemail = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myname.dispose();
    mysurname.dispose();
    myemail.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // var connection = PostgreSQLConnection("localhost", 5432, "ProjectY",
    //     username: "ERP_Team", password: "ERP_Tool_ProjectY");
    // dataset.addAll(widget.dataset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            child: Center(
                child: Wrap(
          spacing: 20, // to apply margin in the main axis of the wrap
          runSpacing: 20, // to apply margin in the cross axis of the wrap
          children: [
            TextFormField(
              controller: myname,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.emptyField;
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: S.of(context).nameUser,
              ),
            ),
            TextFormField(
              controller: mysurname,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.emptyField;
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: S.of(context).ageUser,
              ),
            ),
            TextFormField(
              controller: myemail,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: S.of(context).emailUser,
              ),
            ),
            Center(
              child: Container(
                width: 500,
                height: 50,
                child: ElevatedButton.icon(
                    onPressed: () {
                      var currentState = _formKey.currentState;
                      setState(() {
                        if (currentState!.validate()) {
                          dataset.add({
                            'name': myname.text,
                            'surname': mysurname.text,
                            'email': myemail.text
                          });
                          createPost(myname.text, mysurname.text);
                        }
                      });
                    },
                    label: Text(S.of(context).save),
                    icon: Icon(Icons.save)),
              ),
            ),
            FutureBuilder(
              future: httpService.getPosts(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                if (snapshot.hasData) {
                  List<Post>? posts = snapshot.data;
                  return Container(
                    child: Center(
                      child: Table(
                          border: TableBorder(
                              bottom: BorderSide(),
                              top: BorderSide(),
                              left: BorderSide(),
                              right: BorderSide()),
                          children: posts!
                              .map(
                                (element) => TableRow(children: [
                                  Center(child: Text(element.test_char)),
                                  Center(
                                      child: Text(element.test_num.toString())),
                                  Center(child: Text(element.id.toString())),
                                ]),
                              )
                              .toList()),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ))));
  }
}

class ShowUser extends StatefulWidget {
  List<Map<String, String>> dataset = [];
  ShowUser(this.dataset);
  // const ShowUser({Key? key, Map<String, String> dataset = {}})
  //     : super(key: key);

  @override
  _ShowUserState createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final List<Map<String, String>> dataset = [];

  @override
  void initState() {
    dataset.addAll(widget.dataset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Table(
            border: TableBorder(
                bottom: BorderSide(),
                top: BorderSide(),
                left: BorderSide(),
                right: BorderSide()),
            children: dataset
                .map(
                  (element) => TableRow(children: [
                    Center(child: Text(element.values.toList()[0])),
                    Center(child: Text(element.values.toList()[1])),
                    Center(child: Text(element.values.toList()[2])),
                  ]),
                )
                .toList()),
      ),
    );
  }
}
