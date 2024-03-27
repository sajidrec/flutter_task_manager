class TaskCountByStatus {
  String? sId;
  int? sum;

  TaskCountByStatus({this.sId, this.sum});

  TaskCountByStatus.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }
}
