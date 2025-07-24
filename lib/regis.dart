import 'package:flutter/material.dart';
import 'package:form_validate/login.dart';
import './controller/regis_controller.dart';
import 'package:get/get.dart';

class RegisScreen extends StatelessWidget {
  const RegisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistrationController controller = Get.put(RegistrationController());

    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Your Account',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please fill in the details to create your account',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: controller.firstNameController,
                    validator: controller.validateFirstName,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      isDense: true,
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.lastNameController,
                    validator: controller.validateLastName,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      isDense: true,
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Enter email',
                      isDense: true,
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      validator: controller.validatePassword,
                      obscureText: controller.obscurePassword.value,
                      decoration: InputDecoration(
                        labelText: 'Enter password',
                        isDense: true,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => TextFormField(
                      controller: controller.confirmPasswordController,
                      validator: controller.validateConfirmPassword,
                      obscureText: controller.obscureConfirmPassword.value,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        isDense: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscureConfirmPassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.createAccount,
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
                            : const Text('Create Account'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.delete<RegistrationController>();
                          Get.to(() => const LoginScreen());
                        },
                        child: Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
