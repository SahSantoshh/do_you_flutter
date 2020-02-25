import 'package:flutter/material.dart';
import 'package:iremember/services/main-model.dart';
import 'package:scoped_model/scoped_model.dart';

//TODO List out items from Firestore with image using the state management solution you have integrated
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Home"),
              leading: Icon(Icons.home),
              backgroundColor: Colors.blueAccent,
            ),
            body: Container());
      },
    );
  }
}
