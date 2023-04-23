import 'package:ecommerceriverpod/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/alert_dialogs.dart';
import '../data/auth_provider.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _usernameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    Future<void> _submitRegister(
        String username, String email, String password) async {
      var formdata = _formKey.currentState;
      if (formdata!.validate()) {
        final controller =
            ref.read(emailPasswordSignInControllerProvider.notifier);

        // final controller = ref.read(authControllerProvider.notifier);
        FocusManager.instance.primaryFocus?.unfocus();
        final loginResult =
            await controller.submitRegister(username, email, password);
        if (loginResult == false) {
          await showExceptionAlertDialog(
            context: context,
            title: 'Register  failed',
            exception: 'Invalid Credentials',
          );
        }
        if (loginResult == true) {
          // final authStatus =
          // ref.watch(authNotifierProvider.notifier).changeAuthStatus(true);
          context.push("/login");
        }
      }
    }

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 100),
          Center(
              child: Image.asset(
            "assets/images/Logo.png",
          )),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,

                    // onSaved: (val){
                    //   _usernameController= val;
                    // },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter a username";
                      }
                      if (val.length > 100) {
                        return "Value can't be larger than 100 letter.";
                      }
                      if (val.length < 2) {
                        return "Value can't be less than 2 letter.";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Username",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        )),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    // onSaved: (val){
                    // },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter an Email";
                      }
                      if (val.length > 100) {
                        return "Email can't be larger than 100 letter.";
                      }
                      if (val.length < 2) {
                        return "Email can't be less than 2 letter.";
                      }
                      if (!val.contains("@")) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "email",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        )),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,

                    // onSaved: (val){
                    //   mypassword= val;
                    // },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter Password";
                      }
                      if (val.length > 100) {
                        return "Password can't be larger than 100 letter.";
                      }
                      if (val.length < 2) {
                        return "Password can't be less than 2 letter.";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text("Already have Account? "),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).pushNamed("login");
                            context.pushReplacement("/login");
                          },
                          child: Text(
                            "Click Here",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      child: const Text("Sign Up"),
                      onPressed: () async {
                        // var response = await signUp();
                        // context.push("/login");
                        onPressed:
                        _submitRegister(_emailController.text,
                            _passwordController.text, _usernameController.text);

                        // print("==========================");
                        // print("object");
                        // print(response.user);

                        // if(response!=null){
                        //   context.push("/login");
                        // }else{
                        //   print("Sign Up Faild");
                        // }
                        // print("==========================");
                      },
                      style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.red,
                          textStyle: const TextStyle(
                        fontSize: 20,
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
