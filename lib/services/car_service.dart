import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iremember/model/car.dart';

class CarService {
  final _db = Firestore.instance;

  Stream<List<Car>> streamCars() {
    var ref = _db.collection('cars');

    return ref.snapshots().map((allCars) =>
        allCars.documents.map((doc) => Car.fromFireStore(doc)).toList());
  }
}
