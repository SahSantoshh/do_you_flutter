import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String id, title, description, image;

  Car({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  factory Car.fromFireStore(DocumentSnapshot document) {
    Map data = document.data;
    return Car(
      id: document.documentID,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
    );
  }

  // just to add item in store
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;

    return data;
  }
}
