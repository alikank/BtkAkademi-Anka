import 'package:anka/product/navigation/app_router.dart';
import 'package:anka/product/widgets/appbar/appbar.dart';
import 'package:anka/product/widgets/button/button.dart';
import 'package:anka/product/widgets/textField/textfiled.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        autoLeading: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(
              'Yeni Kullanıcı',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          CustomTextField(
            label: 'E-posta',
            controller: emailController,
            obscure: false,
            passwordTextfield: false,
          ),
          CustomTextField(
            label: 'Parola',
            controller: passwordController,
            obscure: true,
            passwordTextfield: true,
          ),
          CustomTextField(
            label: 'Tekrar Parola',
            controller: rePasswordController,
            obscure: true,
            passwordTextfield: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: CustomButton(
                onPressed: () {
                  context.router.push(const HomeRoute());
                },
                text: 'Kayıt Ol',
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
