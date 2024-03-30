import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/add_new_task_controller.dart';
import 'package:task_manager/presentation/controllers/auth/email_verification_controller.dart';
import 'package:task_manager/presentation/controllers/auth/pin_verification_controller.dart';
import 'package:task_manager/presentation/controllers/auth/set_password_controller.dart';
import 'package:task_manager/presentation/controllers/auth/sign_up_controller.dart';
import 'package:task_manager/presentation/controllers/cancelled_task_controller.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controllers/new_task_controller.dart';
import 'package:task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager/presentation/controllers/auth/sign_in_controller.dart';
import 'package:task_manager/presentation/controllers/update_profile_controller.dart';

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
    Get.lazyPut(() => UpdateProfileController());
    // Get.lazyPut(() => EmailVerificationController());
    Get.put(EmailVerificationController());
    Get.put(PinVerificationController());
    Get.put(SetPasswordController());
    Get.put(SignUpController());
  }
}
