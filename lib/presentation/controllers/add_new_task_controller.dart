import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage ?? "Add failed please try again.";

  Future<bool> addNewTask(String title, String description) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "title": title,
      "description": description.trim(),
      "status": "New"
    };

    final response =
        await NetworkCaller.postRequest(Urls.createTask, inputParams);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
