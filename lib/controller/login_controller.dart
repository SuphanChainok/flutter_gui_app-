import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  var isObscurePassword = true.obs;
  var isLoading = false.obs;
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      isEmailValid.value = false;
      return 'Please enter your email';
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

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      isPasswordValid.value = false;
      return 'Please enter your password';
    }

    if (value.length < 6) {
      isPasswordValid.value = false;
      return 'Password must be at least 6 characters long';
    }

    isPasswordValid.value = true;
    return null;
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  // Check if form is valid
  bool get isFormValid => isEmailValid.value && isPasswordValid.value;

  // Login function
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        // Here you would typically call your authentication API
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        // Mock login logic - replace with actual authentication
        if (email == "test@example.com" && password == "123456") {
          Get.snackbar(
            'Success',
            'Login successful!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );

          // Navigate to home screen or dashboard
          // Get.offAllNamed('/home');
        } else {
          Get.snackbar(
            'Error',
            'Invalid email or password',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Something went wrong. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Clear form
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    isEmailValid.value = false;
    isPasswordValid.value = false;
  }

  @override
  void onClose() {
    // Dispose controllers when not needed
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
