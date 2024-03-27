import 'package:task_manager/data/models/task_count_by_status_data.dart';

class CountByStatusWrapper {
  String? status;
  List<TaskCountByStatus>? listOfTaskByStatusData;

  CountByStatusWrapper({this.status, this.listOfTaskByStatusData});

  CountByStatusWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfTaskByStatusData = <TaskCountByStatus>[];
      json['data'].forEach((v) {
        listOfTaskByStatusData!.add(TaskCountByStatus.fromJson(v));
      });
    }
  }
}
