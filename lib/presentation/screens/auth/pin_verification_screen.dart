import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/presentation/controllers/auth/pin_verification_controller.dart';
import 'package:task_manager/presentation/screens/auth/set_password_screen.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/show_snack_bar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _pinVerificationController = Get.find<PinVerificationController>();

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
                    'Pin Verification',
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
                  PinCodeTextField(
                    controller: _pinTEController,
                    length: 6,
                    obscureText: false,
                    validator: (value) {
                      if (value?.length != 6) {
                        return 'Enter 6 digit code sent to your email address';
                      }
                      return null;
                    },
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        inactiveColor: AppColors.themeColor,
                        selectedFillColor: Colors.white),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    appContext: context,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<PinVerificationController>(
                        builder: (pinVerificationController) {
                      return Visibility(
                        visible: !pinVerificationController.inProgress,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await _pinVerificationController
                                  .pinVerification(
                                      widget.email, _pinTEController.text);

                              if (result) {
                                if (mounted) {
                                  Get.off(
                                    SetPasswordScreen(
                                      email: widget.email,
                                      otp: _pinTEController.text,
                                    ),
                                  );
                                }
                              } else {
                                showSnackBarMessage(
                                  context,
                                  _pinVerificationController.errorMessage,
                                  true,
                                );
                                if (mounted) {
                                  Get.offAll(const SignInScreen());
                                }
                              }
                            }
                          },
                          child: const Text('Verify'),
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
                          Get.offAll(const SignInScreen());
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

// @override
// void dispose() {
//   _pinTEController.dispose();
//   super.dispose();
// }
}
