import 'package:get/get.dart';

class CallLogController extends GetxController {
  var callLogs = <String>[].obs;

  void addCall(String number) {
    callLogs.insert(0, number);
  }
}