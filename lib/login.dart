import 'package:flutter/material.dart';
import 'package:form_validate/forget_pass.dart';
import 'package:form_validate/regis.dart';
import 'controller/login_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 250),
                const SizedBox(height: 20),

                // Email TextFormField
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter email',
                    isDense: true,
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: controller.validateEmail,
                  onChanged: (value) {
                    // Real-time validation
                    controller.validateEmail(value);
                  },
                ),

                const SizedBox(height: 20),

                // Password TextFormField
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isObscurePassword.value,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Enter password',
                      isDense: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    validator: controller.validatePassword,
                    onChanged: (value) {
                      // Real-time validation
                      controller.validatePassword(value);
                    },
                    onFieldSubmitted: (_) {
                      // Login when user presses done on keyboard
                      controller.login();
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button with loading state
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    // height: 48,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.login,
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Sign In'),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Navigation buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.delete<LoginController>();
                        Get.to(() => const RegisScreen());
                      },
                      child: Text(
                        'Create an account',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.delete<LoginController>();
                        Get.to(() => const ForgetPassScreen());
                      },
                      child: Text(
                        'Forgot Password',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Clear form button (for development/testing)
                TextButton(
                  onPressed: controller.clearForm,
                  child: Text(
                    'Clear Form',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
