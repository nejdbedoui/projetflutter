import 'package:flutter/material.dart';
import 'DB/userdatabase.dart';

class Homepage extends StatefulWidget {
  static const IconData login = IconData(0xe3b2, fontFamily: 'MaterialIcons');
  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String phone = "";
  String password = "";
  int inser = 1;

  @override
  Widget build(BuildContext context) {
    Future<List> ar() {
      return userDatabase.instance.getAllComponents();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("components list"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.login,
              color: Colors.white,
            ),
            onPressed: () async {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
          )
        ],
      ),
      body: Column(children: [
        FutureBuilder(
          future: ar(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              List ls = snapshot.data!;
              List ar = [];
              ls.forEach((element) {
                ar.add(element);
              });
              return ListView.builder(
                  itemCount: ar.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (int.parse(ar[index]["quntity"]) > 0) {
                      return ListTile(
                        title: Text('${ar[index]['name']}'),
                      );
                    }
                    return Container();
                  });
            }
            return Text("404");
          },
        ),
      ]),
    );
  }
}
