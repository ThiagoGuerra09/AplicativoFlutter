import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/item.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();
  var items = <Item>[];

  void add() {
    setState(() {
      items.add(
        Item(
          title: newTaskCtrl.text,
          done: false,
        ),
      ); // adiciona novos itens
      newTaskCtrl.text = '';
      save();
    });
  }

  void remove(int index) {
    setState(() {
      items.removeAt(index);
      save();
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    Iterable decoded = jsonDecode(data);
    List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
    setState(() {
      items = result;
    });
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(items));
  }

  _HomePageState() {
    load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
              labelText: 'Digite o nome para sua lista',
              labelStyle: TextStyle(color: Colors.brown, fontSize: 18)),
        ),
        leading: Text('Versão beta'),
        actions: <Widget>[Icon(Icons.menu)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => add(),
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(79, 62, 13, 0.932),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = items[index];
          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title.toString()),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  // função do stf que muda o estado dos parametros passados, serve para quando vamos atualizar uma posição
                  item.done = value;
                  save();
                });
              },
            ),
            key: Key(item.title.toString()),
            background: Container(
              color: Colors.red.withOpacity(0.2),
              child: Text('Excluir'),
            ),
            onDismissed: (direction) {
              print(direction);
              remove(index);
            },
          );
        },
      ),
    );
  }
}
