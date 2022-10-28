import 'package:flutter/material.dart';

import 'models/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
      home: HomePage(),
    );
  }
}

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
      newTaskCtrl.text = "";
    });
  }

  void remove(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  load() async {}
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
              labelText: "Digite o nome para sua lista",
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
                });
              },
            ),
            key: Key(item.title.toString()),
            background: Container(
              color: Colors.red.withOpacity(0.2),
              child: Text("Excluir"),
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
