import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/data/dropdown/ville_dropdown.dart';
import 'package:mada_jeune/features/authentication/controller/signup/signup_controller.dart';
import 'package:mada_jeune/features/authentication/screens/signup/widget/term_and_condition_checkbox.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/constants/text_strings.dart';
import 'package:mada_jeune/utils/validators/validation.dart';

class TSignupForm extends StatefulWidget {
  const TSignupForm({Key? key}) : super(key: key);

  @override
  _TSignupFormState createState() => _TSignupFormState();
}


class _TSignupFormState extends State<TSignupForm> {

  @override
  void initState() {
    super.initState();
  }
  String selectedVille = "";
  String selectedVilleName = "";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());
    return Form(
      key: _formKey,
      child: Column(
      children: [
         SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(child: DropDownVille(
                    onChanged: (String value) {
                      selectedVille = value;
                      },
                    onSelected: (String name) {
                      selectedVilleName = name;
                      },)),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _nomController,
                validator: (value) => TValidator.validateEmptyText('Nom', value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.lastname,
                    prefixIcon: Icon(Iconsax.user)
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller: _prenomController,
                validator: (value) => TValidator.validateEmptyText('Prenom', value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.firstname,
                    prefixIcon: Icon(Iconsax.user)
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        TextFormField(
          validator: (value) => TValidator.validateEmptyText('Adresse', value),
          controller: _adresseController,
          decoration: const InputDecoration(labelText: TTexts.adresse, prefixIcon: Icon(Iconsax.building)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        TextFormField(
          validator: (value) => TValidator.validateEmail(value),
          controller: _mailController,
          decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        TextFormField(
          validator: (value) => TValidator.validatePhoneNumber(value),
          controller: _contactController,
          decoration: const InputDecoration(labelText: TTexts.phoneNumber, prefixIcon: Icon(Iconsax.call)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Obx(
          () => TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: _passwordController,
              obscureText: signupController.hidePassword.value,
              decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => signupController.hidePassword.value = !signupController.hidePassword.value,
                      icon: Icon(signupController.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  )
              )
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),


        const TTermsAndConditionCheckbox(),
        const SizedBox(height: TSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String nom = _nomController.text.trim();
                String prenom = _prenomController.text.trim();
                String adresse = _adresseController.text.trim();
                String contact = _contactController.text.trim();
                String mail = _mailController.text.trim();
                String password = _passwordController.text.trim();
                String ville = selectedVille;
                if (kDebugMode) {
                  print('Nom: $nom, Prenom: $prenom, Adresse: $adresse, Contact: $contact, Mail: $mail, Password: $password, Ville: $ville');
                }
                if(ville == "") {
                  TLoaders.errorSnackBar(title: 'Information', message: 'Veuillez choisir une ville');
                  return;
                }
                SignupController signupController = Get.find();
                signupController.createUser(nom, prenom, ville, adresse, contact, mail, password); // Ajoutez un point-virgule à la fin de cette ligne
              }
            },
            child: const Text(TTexts.signupTitle),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Get.offNamed('/login'),
            child: const Text(TTexts.login),
          ),
        ),
      ],
    ),
    );
  }
}
