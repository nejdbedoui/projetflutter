import 'package:flutter/material.dart';
import 'package:gstock/DB/componentsType.dart';
import 'DB/userdatabase.dart';

class Addcom extends StatefulWidget {
  State<Addcom> createState() => _Addcom();
}

  String type = "";
  class _Addcom extends State<Addcom> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.teal,
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "type"),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "type is required";
                  }
                  return null;
                },
                onChanged: (String? value) {
                  setState(() {
                    type = value.toString();
                  });
                },
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            componentsType ct = new componentsType(type: type) ;
                            userDatabase.instance.createComponentsType(ct);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Sumbimited")),
                            );
                            Navigator.pushNamed(context, '/logged');
                          },
                          child: const Text('submit'),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
