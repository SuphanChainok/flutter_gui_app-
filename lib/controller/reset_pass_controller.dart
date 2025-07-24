import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassController extends GetxController {
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Text editing controller
  final emailController = TextEditingController();

  // Observable variables
  var isLoading = false.obs;
  var isEmailValid = false.obs;
  var isEmailSent = false.obs;

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      isEmailValid.value = false;
      return 'Please enter your email address';
    }

    // Email regex pattern
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      isEmailValid.value = false;
      return 'Please enter a valid email address';
    }

    isEmailValid.value = true;
    return null;
  }

  // Check if form is valid
  bool get isFormValid => isEmailValid.value;

  // Send reset link function
  Future<void> sendResetLink() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        String email = emailController.text.trim();

        // Mock API call - replace with actual password reset API
        // Here you would typically call your password reset API

        // Simulate successful email send
        isEmailSent.value = true;

        Get.snackbar(
          'Success',
          'Password reset link has been sent to $email',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
          icon: const Icon(Icons.check_circle, color: Colors.white),
        );

        // Show success dialog
        _showSuccessDialog(email);
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to send reset link. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.error, color: Colors.white),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Show success dialog
  void _showSuccessDialog(String email) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            const Text('Email Sent!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('A password reset link has been sent to:'),
            const SizedBox(height: 8),
            Text(
              email,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Please check your email and follow the instructions to reset your password.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              clearForm(); // Clear the form
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // Resend reset link
  Future<void> resendResetLink() async {
    if (emailController.text.isNotEmpty && isEmailValid.value) {
      await sendResetLink();
    } else {
      Get.snackbar(
        'Warning',
        'Please enter a valid email address first',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Clear form
  void clearForm() {
    emailController.clear();
    isEmailValid.value = false;
    isEmailSent.value = false;
  }

  // Reset state
  void resetState() {
    isEmailSent.value = false;
    isLoading.value = false;
  }

  @override
  void onClose() {
    // Dispose controller when not needed
    emailController.dispose();
    super.onClose();
  }
}
