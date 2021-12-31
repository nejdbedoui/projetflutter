import 'package:flutter/material.dart';
import 'package:gstock/DB/components.dart';
import 'package:gstock/DB/order.dart';
import 'DB/userdatabase.dart';

class addorder extends StatefulWidget {
  int? id_user;
  int? id_prod;
  addorder(this.id_user, this.id_prod);
  State<addorder> createState() => _addorder();
}

class _addorder extends State<addorder> {
  DateTime _dateTime = DateTime.now();
  String quntity = "";
  int avquant = 0;
  late components oldcomp;
  final _formKey = GlobalKey<FormState>();

  Future<components> ar() {
    return userDatabase.instance.getcompbyid(widget.id_prod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.teal,
        title: Text("borrow"),
      ),
      body: Column(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: ar(),
                builder:
                    (BuildContext context, AsyncSnapshot<components> snapshot) {
                  if (snapshot.hasData) {
                    components ls = snapshot.data!;
                    oldcomp = ls;
                    avquant = int.parse(ls.quntity);
                    return Column(
                      children: [
                        Text("Product name : ${ls.name}"),
                        Text("av quant : ${ls.quntity}"),
                      ],
                    );
                  }
                  return Text("erro");
                },
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Quantity"),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "quntity is required";
                      } else if (int.parse(value) > avquant) {
                        return "out of stock";
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        quntity = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(_dateTime == null
                        ? 'Nothing has been picked yet'
                        : _dateTime.toString()),
                  ),
                  RaisedButton(
                    child: Text('Pick return date'),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: _dateTime == null
                                  ? DateTime.now()
                                  : _dateTime,
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2023))
                          .then((date) {
                        setState(() {
                          _dateTime = date!;
                        });
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        order or = new order(
                            idU: widget.id_user.toString(),
                            idC: widget.id_prod.toString(),
                            dateR: _dateTime.toString(),
                            quntity: quntity.toString());
                        await userDatabase.instance.addorder(or);
                        int a = avquant - int.parse(quntity);

                        components upcomp = components(
                            id: widget.id_prod,
                            id_com: oldcomp.id_com,
                            name: oldcomp.name,
                            date: oldcomp.date,
                            quntity: a.toString());
                        await userDatabase.instance.updatecomp(upcomp);
                      }
                    },
                    child: const Text('submit'),
                  ),
                ]),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
