import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/add_new_task_controller.dart';
import 'package:task_manager/presentation/controllers/cancelled_task_controller.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controllers/new_task_controller.dart';
import 'package:task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager/presentation/controllers/sign_in_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => CountTaskByStatusController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => AddNewTaskController());
    Get.lazyPut(() => CancelledTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => ProgressTaskController());
  }
}
