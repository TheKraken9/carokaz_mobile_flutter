import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/features/authentication/controller/login/login_controller.dart';
import 'package:mada_jeune/features/authentication/screens/signup/signup.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/constants/text_strings.dart';
import 'package:mada_jeune/utils/validators/validation.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({
    super.key,
  });

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {

  @override
  void initState() {
    final LoginController loginController = Get.put(LoginController());
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hidePassword = true.obs;
    final LoginController loginController = Get.put(LoginController());
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                controller: _passwordController,
                validator: (value) => TValidator.validateEmptyText('Mot de passe', value),
                obscureText: hidePassword.value,
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => hidePassword.value = !hidePassword.value,
                      icon: Icon(hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            TextButton(
              onPressed: () {},
              child: const Text(TTexts.forgotPassword),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    if (kDebugMode) {
                      print('Email: $email, Password: $password');
                    }
                    LoginController loginController = Get.find();
                    loginController.login(email, password);
                  }
                },
                child: const Text(TTexts.login),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.offNamed('/signup'),
                child: const Text(TTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}