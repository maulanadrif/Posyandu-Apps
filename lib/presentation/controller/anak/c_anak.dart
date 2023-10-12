import 'package:get/get.dart';
import 'package:posyandu_apps/data/model/anak.dart';

class CAnak extends GetxController {
  final _data = Anak().obs;
  Anak get data => _data.value;
  setData(n) => _data.value = n;
}