import 'package:flutter/material.dart';
import 'package:mada_jeune/commons/styles/spacing_styles.dart';
import 'package:mada_jeune/features/authentication/screens/login/widget/form_divider.dart';
import 'package:mada_jeune/features/authentication/screens/login/widget/login_form.dart';
import 'package:mada_jeune/features/authentication/screens/login/widget/login_header.dart';
import 'package:mada_jeune/features/authentication/screens/login/widget/social_button.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/constants/text_strings.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              TLoginHeader(),
              TLoginForm(),

              TFormDivider(dividerText: TTexts.orSignInWith),
              SizedBox(height: TSizes.spaceBtwSections),
              TSocialButton()
            ],
          ),
        ),
      ),
    );
  }
}