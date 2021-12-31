import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'DB/components.dart';
import 'DB/userdatabase.dart';
import 'package:gstock/DB/components.dart';

class Addtype extends StatefulWidget {
  State<Addtype> createState() => _Addtype();
}

class _Addtype extends State<Addtype> {
  String type = "";
  String name = "";
  String date = "";
  String quntity = "";
  var inser = 1;
  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    Future<List> ar() {
      return userDatabase.instance.getTrashlist();
    }

    String formattedDate = formatter.format(now);

    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.teal,
          title: Text("Login"),
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

                return Container(
                  child: DropdownButton(
                    isExpanded: true,
                    value: inser,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: ar.map((items) {
                      return DropdownMenuItem(
                        value: items["_id"],
                        child: Text(items["type"]),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        print(newValue);
                        var newValue2 = newValue.toString();
                        inser = int.parse(newValue2);
                      });
                    },
                  ),
                );
              }
              return Text("erro");
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Product name"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Familly name is required";
              }
              return null;
            },
            onChanged: (String value) {
              setState(() {
                name = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "quant"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Familly name is required";
              }
              return null;
            },
            onChanged: (String value) {
              setState(() {
                quntity = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              components comp = new components(
                  id_com: inser, name: name, date: "date", quntity: quntity);
              userDatabase.instance.createComponents(comp);
              print(comp.toJsonc());
            },
            child: const Text('Submit'),
          ),
        ]));
  }
}
