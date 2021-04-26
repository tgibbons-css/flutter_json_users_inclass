import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'users.dart';

void main() {
  runApp(MyApp());
  //runApp(Text("Hello World"));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<User> myList = [];
  String _myText = "Hello";

  Future<List<User>> _getListItems() async {
      Uri url = Uri.parse('https://jsonplaceholder.typicode.com/users');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<User> newUsers = userFromJson(response.body);
        return newUsers;
      } else {
        print("HTTP Error with code ${response.statusCode}");
        return myList;
      }
  }

  @override
  initState() {
    super.initState();
    _getListItems().then((newUserList) {
      setState(() {
        myList = newUserList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              child: ListTile(
                leading: Icon(Icons.backup_rounded),
                title: Text(myList[position].name),
                subtitle: Text(myList[position].email),
                onTap: () {
                  print("You tapped on items $position");
                },
              )
          );
        },
      ),
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}