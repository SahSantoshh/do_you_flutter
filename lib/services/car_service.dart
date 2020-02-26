import 'package:iremember/model/car.dart';
import 'package:scoped_model/scoped_model.dart';

mixin CarService on Model {
  List<Car> _carsList = [];
  List<Car> get carsList => _carsList;

  bool _isLoadingCars = false;

  bool get isLoadingCars => _isLoadingCars;
}
