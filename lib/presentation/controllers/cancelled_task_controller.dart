import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CancelledTaskController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";
  TaskListWrapper _cancelledTaskListWrapper = TaskListWrapper();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  TaskListWrapper get cancelledTaskListWrapper => _cancelledTaskListWrapper;

  Future<bool> getAllCancelledTaskList() async {
    bool isSuccessful = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.cancelledTaskListUrl);

    if (response.isSuccess) {
      isSuccessful = true;
      _cancelledTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
    } else {
      _errorMessage = response.errorMessage ?? "Something went wrong.";
    }

    _inProgress = false;
    update();
    return isSuccessful;
  }
}
