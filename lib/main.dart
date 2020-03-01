import 'package:flutter/material.dart';
import 'package:iremember/model/car.dart';
import 'package:iremember/services/car_service.dart';
import 'package:provider/provider.dart';
import './ui/pages/home.dart';
import 'ui/pages/add.dart';

/* 
Please complete the tasks listed in TODOs in different files
  
  In this app user should be able to Save a list of items
  with image (should be able to take a picture or select existing one from gallery), 
  title and description in firestore database, with image being uploaded to firebase storage.

  (optional) -> Theme and style as you prefer to show quality work

  Checkout home.dart and add.dart for TODOs.

 */

void main() => runApp(IRememberApp());

class IRememberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Car>>.value(value: CarService().streamCars()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IRemember',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          appBarTheme: AppBarTheme(
            color: Colors.deepOrange,
          ),
          primaryColor: Colors.deepOrange,
        ),
        home: HomePage(),
        routes: {
          "/home": (_) => HomePage(),
          "/add": (_) => AddItemPage(),
        },
      ),
    );
  }
}
