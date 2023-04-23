import 'package:ecommerceriverpod/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:ecommerceriverpod/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart.dart';
import 'package:ecommerceriverpod/src/localization/string_hardcoded.dart';
import 'package:ecommerceriverpod/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as devtools show log;

import '../../../../common_widgets/alert_dialogs.dart';
import '../../data/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    Future<void> _submit(String email, String password) async {
      var formdata = _formKey.currentState;
      if (formdata!.validate()) {
        final controller =
            ref.read(emailPasswordSignInControllerProvider.notifier);

        // final controller = ref.read(authControllerProvider.notifier);
        FocusManager.instance.primaryFocus?.unfocus();
        final loginResult = await controller.submit(email, password);
        if (loginResult == false) {
          // ignore: use_build_context_synchronously
          await showExceptionAlertDialog(
            context: context,
            title: 'Sign-in failed',
            exception: 'Invalid email or password',
          );
        }
        if (loginResult == true) {
          ref.watch(authNotifierProvider.notifier).changeAuthStatus(true);
          // ignore: use_build_context_synchronously
          context.push("/");
        }
      }
    }

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    ref.watch(emailPasswordSignInControllerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Center(
                  child: Image.asset(
                "assets/images/Logo.png",
              )),
              TextFormField(
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter an Email";
                  }

                  return null;
                },
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email'.hardcoded,
                  hintText: 'test@test.com'.hardcoded,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  prefixIcon: const Icon(Icons.person),

                  // enabled: !state.isLoading,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter Password";
                  }

                  return null;
                },
                controller: _passwordController,
                // obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    )),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Text("Don't have an Account? "),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context)
                        //     .pushReplacementNamed("signup");
                        context.push("/register");
                      },
                      child: const Text(
                        "Click Here",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _submit(_emailController.text, _passwordController.text);
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}

/// Generic function to show a platform-aware Material or Cupertino error dialog
Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
      defaultActionText: 'OK'.hardcoded,
    );
