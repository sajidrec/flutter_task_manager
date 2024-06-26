import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';

import '../../data/models/count_by_status_wrapper.dart';
import '../../data/utility/urls.dart';

class CountTaskByStatusController extends GetxController {
  bool _inProgress = false;
  bool _doNotUpdate = false;
  String? _errorMessage;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();

  void doNotUpdate() {
    _doNotUpdate = true;
  }

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? "Fetch count by status failed.";

  CountByStatusWrapper get countByStatusWrapper => _countByStatusWrapper;

  Future<bool> getCountByTaskStatus() async {
    if (_doNotUpdate) {
      _doNotUpdate = false;
      return true;
    }
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    _inProgress = false;

    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
