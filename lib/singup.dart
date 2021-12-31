import 'package:flutter/material.dart';
import 'DB/user.dart';
import 'DB/userdatabase.dart';

class singup extends StatefulWidget {
  @override
  State<singup> createState() => _singup();
}

class _singup extends State<singup> {
  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String phone = "";
  String phone2 = "";
  String password = "";
  String firstName = "";
  String lastName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sing Up"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      _username = value.toString();
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      password = value.toString();
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Phone"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "phone is required";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      phone = value.toString();
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Phone2"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Phone2 is required";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      phone2 = value.toString();
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "First name"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      firstName = value.toString();
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Last Name"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Familly name is required";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      lastName = value.toString();
                    });
                  },
                ),
                Center(
                    child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          User a = new User(
                              username: _username,
                              password: password,
                              phone: phone,
                              phone2: phone2,
                              firstName: firstName,
                              lastName: lastName);
                          userDatabase.instance.create(a);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Sumbimited")),
                          );
                        }
                      },
                      child: const Text('Sing-up'),
                    ),
                    Text("Got a Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/homepage');
                        },
                        child: Text('Login'))
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
