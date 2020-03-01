import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iremember/model/car.dart';
import 'package:iremember/services/car_service.dart';

class AddItemPage extends StatefulWidget {
  AddItemPage();
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  File _imageFile;
  bool autoValidateForm = false;

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Add Car"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Form(
              key: formKey,
              autovalidate: autoValidateForm,
              child: Column(
                children: <Widget>[
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
              ))
        ],
      ),
    );
  }

  TextFormField _buildTitleField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: (val) =>
          (val.isEmpty || val == null) ? 'Title is required' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "title",
        prefixIcon: Icon(Icons.title),
      ),
      onSaved: (val) => _title = val,
    );
  }

  TextFormField _buildDescriptionField() {
    return TextFormField(
      maxLines: 4,
      keyboardType: TextInputType.text,
      validator: (val) =>
          (val.isEmpty || val == null) ? 'Description is required' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Description",
      ),
      onSaved: (val) => _description = val,
    );
  }

  Widget _buildImgSelectButton() {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton.icon(
            icon: Icon(
              Icons.camera,
              color: Colors.white,
            ),
            label: Text("Add Image",
                style: TextStyle(
                  color: Colors.white,
                )),
            color: Colors.deepOrange,
            onPressed: () => getImageFromGallery(),
          ),
          SizedBox(height: 10),
          Container(
            child: (_imageFile == null)
                ? Center(child: Text('No image selected'))
                : Image.file(
                    _imageFile,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: RaisedButton.icon(
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        color: Colors.deepOrange,
        onPressed: () {
          submitForm(context);
        },
      ),
    );
  }

  submitForm(BuildContext context) async {
    setState(() {
      autoValidateForm = true;
    });
    final form = formKey.currentState;
    if (_imageFile == null) {
      showToast("Please select image", context);
    } else if (form.validate()) {
      form.save();
      progressDialog(context);
      await CarService().addCar(Car(
          image: _imageFile.path, title: _title, description: _description));

      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      showToast('Please fill form', context);
    }
  }

  showToast(String message, BuildContext context) {
    final snackbar = SnackBar(content: Text(message));
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Future progressDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Adding car"),
              SizedBox(
                height: 20.0,
              ),
              CircularProgressIndicator(
                // backgroundColor: Constant.ascent,
                value: null,
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
              ),
            ],
          ),
        );
      },
    );
  }
}
