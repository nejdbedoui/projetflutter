import 'package:flutter/material.dart';
import 'DB/userdatabase.dart';

class returnorder extends StatefulWidget {
  int? id_user;
  returnorder(this.id_user);
  @override
  State<returnorder> createState() => _returnorder();
}

class _returnorder extends State<returnorder> {
  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String phone = "";
  String password = "";
  int inser = 1;

  @override
  Widget build(BuildContext context) {
    Future<List> ar() {
      return userDatabase.instance.getOwnOrder(widget.id_user);
    }

    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          //backgroundColor: Colors.teal,
          title: Text("return components"),
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
                        return ListTile(
                          trailing: TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              int? a = ar[index]['_id'];

                              Navigator.pushNamed(
                                context,
                                '/loged',
                                arguments: userDatabase.instance.deleteOrder(a!),
                              );
                            },
                            child: Text('delete'),
                          ),
                          title: Text('name :  ${ar[index]['name']}'),
                        );

                      return Container();
                    });
              }
              return Text("erro");
            },
          ),
        ]),
        );
  }
}
