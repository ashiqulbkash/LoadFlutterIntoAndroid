import 'package:flutter/foundation.dart';
import 'pigeon_model_flutter_api.dart';

// To update flutter view when receive data from android/ios side
ValueNotifier<Employee?> notifier = ValueNotifier(null);

// Implementing flutter api
class PigeonModelFlutter implements PigeonFlutterApi {
  PigeonModelFlutter() {
    PigeonFlutterApi.setup(this);
  }

  // receiving employee data from native side
  @override
  void setEmployee(Employee emp) {
    notifier.value = emp;
  }
}