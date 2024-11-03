import 'package:anka/product/navigation/app_router.dart';
import 'package:anka/product/widgets/appbar/appbar.dart';
import 'package:anka/product/widgets/button/button.dart';
import 'package:anka/product/widgets/button/google_signin_button.dart';
import 'package:anka/product/widgets/textField/textfiled.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        autoLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(
                'Kullanıcı Girişi',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            CustomTextField(
              label: 'E-Posta',
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CustomButton(
                  onPressed: () {
                    context.router.push(const HomeRoute());
                  },
                  text: 'Giriş Yap',
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.router.push(const SignupRoute());
              },
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(fontSize: 18),
                  children: [
                    TextSpan(
                      text: "Anka'da yeni misiniz? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    TextSpan(
                      text: "Şimdi Kayıt Olun!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'veya',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(child: GoogleSigninButton(onPressed: () {}))
          ],
        ),
      ),
    );
  }
}
