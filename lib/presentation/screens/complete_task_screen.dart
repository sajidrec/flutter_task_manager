import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/show_snack_bar_message.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();
  final CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<CompletedTaskController>(
            builder: (completedTaskController) {
          return Visibility(
            visible: !completedTaskController.inProgress,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                _getAllCompletedTaskList();
              },
              child: Visibility(
                visible:
                    _completedTaskListWrapper.taskList?.isNotEmpty ?? false,
                replacement: const EmptyListWidget(),
                child: ListView.builder(
                  itemCount: _completedTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskItem: _completedTaskListWrapper.taskList![index],
                      refreshList: () {
                        _getAllCompletedTaskList();
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async {

    bool result = await _completedTaskController.getAllCompletedTaskList();

    if (result) {
      _completedTaskListWrapper =
          _completedTaskController.completedTaskListWrapper;

    } else {
      if (mounted) {
        showSnackBarMessage(context, _completedTaskController.errorMessage);
      }
    }
  }
}
