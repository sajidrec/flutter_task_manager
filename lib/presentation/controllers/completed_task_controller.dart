import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CompletedTaskController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  TaskListWrapper get completedTaskListWrapper => _completedTaskListWrapper;

  Future<bool> getAllCompletedTaskList() async {
    bool isSuccessful = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.completedTaskList);

    if (response.isSuccess) {
      isSuccessful = true;
      _completedTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
    } else {
      _errorMessage = response.errorMessage ?? "Something went wrong.";
    }

    _inProgress = false;
    update();
    return isSuccessful;
  }
}
