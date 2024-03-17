import 'package:flutter/material.dart';
import 'package:task_manager/data/models/set_password_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/show_snack_bar_message.dart';

import '../../../data/utility/urls.dart';
import '../../widgets/password_validation_checker.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.email, required this.otp});

  final String email, otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Minimum 8 characters with letters and numbers combination',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (passwordIsValid(value)) {
                        return null;
                      } else {
                        return "Minimum 8 in size with letter and number combine";
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (passwordIsValid(value)) {
                        return null;
                      } else {
                        return "Minimum 8 in size with letter and number combine";
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_passwordTEController.text !=
                              _confirmPasswordTEController.text) {
                            showSnackBarMessage(
                                context, "Password didn't matched", true);
                          } else {
                            SetPasswordObject setPasswordObject =
                                SetPasswordObject(
                              email: widget.email,
                              otp: widget.otp,
                              password: _passwordTEController.text,
                            );
                            final response = await NetworkCaller.postRequest(
                              Urls.setPasswordUrl,
                              setPasswordObject.toJson(),
                            );

                            if (response.responseBody["status"] == "success") {
                              showSnackBarMessage(
                                  context, "Password Changed", false);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                  (route) => false);
                            } else {
                              showSnackBarMessage(
                                  context, "Password not changed", true);
                            }
                          }
                        }
                      },
                      child: const Text('Confirm'),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have account?',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()),
                              (route) => false);
                        },
                        child: const Text(
                          'Sign in',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
