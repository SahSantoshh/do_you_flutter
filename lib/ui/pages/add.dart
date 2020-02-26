import 'package:flutter/material.dart';
import 'package:iremember/services/main-model.dart';
import 'package:scoped_model/scoped_model.dart';

//TODO allow user to pick image and display the preview in UI
//TODO save new data to firestore (upload image to storage)
class AddItemPage extends StatefulWidget {
  final MainModel model;

  AddItemPage(this.model);
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add item"),
            backgroundColor: Colors.blueAccent,
          ),
          body: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              _buildTitleField(),
              SizedBox(
                height: 20,
              ),
              _buildDescriptionField(),
              SizedBox(
                height: 20,
              ),
              _buildImgSelectButton(),
              SizedBox(
                height: 20,
              ),
              _buildSaveButton(context)
            ],
          ),
        );
      },
    );
  }

  TextField _buildTitleField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          title = value;
        });
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "title",
          prefixIcon: Icon(Icons.title)),
    );
  }

  TextField _buildDescriptionField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          description = value;
        });
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description",
      ),
    );
  }

  SizedBox _buildImgSelectButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton.icon(
        icon: Icon(Icons.camera),
        label: Text("Add Image"),
        color: Colors.blue,
        onPressed: () {},
      ),
    );
  }

  SizedBox _buildSaveButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 20.0,
      child: RaisedButton.icon(
        icon: Icon(Icons.save),
        label: Text("Save"),
        color: Colors.blue,
        onPressed: () async {},
      ),
    );
  }
}
