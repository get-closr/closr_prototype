import 'package:flutter/material.dart';
import 'package:closr_prototype/resources/app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.of(context).appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "You are running ${AppConfig.of(context).buildFlavor} flavor."),
            loading ? CircularProgressIndicator() : Container(),
            TextField(
              controller: _controller,
            ),
            RaisedButton(
              child: Text("Add to Firestore"),
              onPressed: _addToFirestore,
            )
          ],
        ),
      ),
    );
  }

  void _addToFirestore() async {
    if(_controller.text.isEmpty) return;
    setState((){
      loading = true;
    });
    await Firestore.instance.collection('mycoll').add({"string":_controller.text});
    _controller.text = "";
    setState(() {
      loading = false;
    });
  }
}
