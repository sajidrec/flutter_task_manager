import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:task_manager/data/models/user_data.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  String? _photo;

  set setPhoto(String photo) {
    _photo = photo;
  }

  Future<bool> upDateProfile(String email, String firstName, String lastName,
      String mobile, String password) async {
    bool isSuccessful = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password.isNotEmpty) {
      inputParams['password'] = password;
    }

    if (_photo == null) {
      List<int> bytes =
          File(AuthController.userData!.getPhoto).readAsBytesSync();
      _photo = base64Encode(bytes);
    }

    inputParams['photo'] = _photo;

    final response =
        await NetworkCaller.postRequest(Urls.updateProfile, inputParams);

    if (response.isSuccess) {
      UserData userData = UserData(
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        photo: _photo ?? "",
      );

      await AuthController.saveUserData(userData);

      isSuccessful = true;
    } else {
      _errorMessage = "Update profile failed! Try again.";
    }

    _inProgress = false;
    update();
    return isSuccessful;
  }
}
