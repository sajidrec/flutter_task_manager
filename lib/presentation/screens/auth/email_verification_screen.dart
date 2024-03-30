import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/auth/email_verification_controller.dart';
import 'package:task_manager/presentation/screens/auth/pin_verification_screen.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/show_snack_bar_message.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final EmailVerificationController _emailVerificationController =
      Get.find<EmailVerificationController>();

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
                    child: GetBuilder<EmailVerificationController>(
                        builder: (emailVerificationController) {
                      return Visibility(
                        visible: !emailVerificationController.inProgress,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final bool response =
                                  await _emailVerificationController
                                      .emailVerification(
                                          _emailTEController.text.trim());

                              if (response) {
                                if (mounted) {
                                  Get.off(PinVerificationScreen(
                                      email: _emailTEController.text.trim()));
                                }
                              } else {
                                if (mounted) {
                                  showSnackBarMessage(
                                      context,
                                      _emailVerificationController.errorMessage,
                                      true);
                                }
                              }
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }),
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
                          Get.back();
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
