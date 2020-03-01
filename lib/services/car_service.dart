import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iremember/model/car.dart';

class CarService {
  final _db = Firestore.instance;
  final _storageRef = FirebaseStorage.instance.ref();

  Stream<List<Car>> streamCars() {
    var ref = _db.collection('cars');

    return ref.snapshots().map((allCars) =>
        allCars.documents.map((doc) => Car.fromFireStore(doc)).toList());
  }

  Future<dynamic> uploadFile(File imageFile) async {
    String fileName = imageFile?.path?.split("/")?.last;
    var fileref = _storageRef.child(fileName);
    StorageUploadTask uploadTask = fileref.putFile(imageFile);
    await uploadTask.onComplete;
    String url = await fileref.getDownloadURL();
    return url;
  }

  Future<bool> addCar(Car car) async {
    return uploadFile(File(car.image)).then((result) {
      car.image = result;
      _db.collection('cars').document().setData(car.toJson());
      return true;
    }).catchError((onError) {
      return false;
    });
  }
}
