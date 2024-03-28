import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProgressTaskController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  TaskListWrapper get progressTaskListWrapper => _progressTaskListWrapper;

  Future<bool> getAllProgressTaskList() async {
    bool isSuccessful = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.progressTaskListUrl);

    if (response.isSuccess) {
      isSuccessful = true;
      _progressTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
    } else {
      _errorMessage = response.errorMessage ?? "Something went wrong.";
    }

    _inProgress = false;
    update();
    return isSuccessful;
  }
}
