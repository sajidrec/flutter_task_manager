import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

import '../../data/models/task_list_wrapper.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/show_snack_bar_message.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

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
        child: GetBuilder<ProgressTaskController>(
            builder: (progressTaskController) {
          return Visibility(
            visible: !progressTaskController.inProgress,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                _getAllCompletedTaskList();
              },
              child: Visibility(
                visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
                replacement: const EmptyListWidget(),
                child: ListView.builder(
                  itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskItem: _progressTaskListWrapper.taskList![index],
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
    bool result = await _progressTaskController.getAllProgressTaskList();

    if (result) {
      _progressTaskListWrapper =
          _progressTaskController.progressTaskListWrapper;
    } else {
      if (mounted) {
        showSnackBarMessage(context, _progressTaskController.errorMessage);
      }
    }
  }
}
