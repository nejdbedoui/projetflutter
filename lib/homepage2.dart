import 'package:flutter/material.dart';
import 'package:gstock/simple_dialog.dart';
import 'DB/userdatabase.dart';

class homepage2 extends StatefulWidget {
  static const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');
  int? id;
  homepage2(this.id);
  @override
  State<homepage2> createState() => _Homepage2();
}

class _Homepage2 extends State<homepage2> {
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
          // automaticallyImplyLeading: false,
          //backgroundColor: Colors.teal,
          title: Text("components list"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                Navigator.pushReplacementNamed(context, '/');
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
                         return
                      ListTile(
                          trailing: TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              int? a = ar[index]['_id'];

                              Navigator.pushNamed(
                                context,
                                '/order',
                                arguments: orderinfo(widget.id, a),
                              );
                            },
                            child: Text('Get'),
                          ),
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
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('what to add'),
                      children: [
                        SimpleDialogItem(
                          icon: Icons.add,
                          color: Colors.orange,
                          text: 'componentsType',
                          onPressed: () {
                            Navigator.pushNamed(context, '/componentsType');
                          },
                        ),
                        SimpleDialogItem(
                          icon: Icons.add,
                          color: Colors.green,
                          text: 'components ',
                          onPressed: () {
                            Navigator.pushNamed(context, '/components');
                          },
                        )
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
    );
  }
}
