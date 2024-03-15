import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/presentation/screens/auth/pin_verification_screen.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../../data/utility/urls.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _emailCheckInProgress = false;

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
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'A 6 digits verification code will be sent to your email address',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: !_emailCheckInProgress,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _emailCheckInProgress = true;
                            setState(() {});
                            final response = await NetworkCaller.getRequest(
                              Urls.forgetPasswordEmailUrl(
                                _emailTEController.text.trim(),
                              ),
                            );
                            // print(response.responseBody);
                            if (response.responseBody["status"] == "success") {
                              if (mounted) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PinVerificationScreen(),
                                    ),
                                    (route) => false);
                              }
                            } else {
                              if (mounted) {
                                showSnackBarMessage(
                                    context,
                                    "Something went wrong. please check you're email and try again",
                                    true);
                              }
                            }
                            _emailCheckInProgress = false;
                            setState(() {});
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
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
                          Navigator.pop(context);
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
    _emailTEController.dispose();
    super.dispose();
  }
}
