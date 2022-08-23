import 'package:flutter/material.dart';
import 'package:flutter_project/enums/auth_enums.dart';
import 'package:flutter_project/features/authentication/authentication_viewmodel.dart';
import 'package:flutter_project/features/dashboard/dashboard_view.dart';
import 'package:flutter_project/widgets/custom_textfield.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_project/utilities/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);
  static const routeName = '/authentication-view';

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  final TextEditingController _emailController =
      TextEditingController(text: 'kminchelle');
  final TextEditingController _passwordController =
      TextEditingController(text: '0lelplR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text(
            'Riverpod\nMvvm\n App'.toUpperCase(),
            fontweight: FontWeight.bold,
            size: Theme.of(context).textTheme.headline4?.fontSize,
            color: Colors.blue,
            maxLine: 3,
            isCentered: true,
          ),
          (context.height * 0.1).verticalSpacer,
          InputField(
            controller: _emailController,
            hintText: 'theusername',
            labelText: 'Username',
          ),
          InputField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: '*' * 8,
            obscureText: true,
          ),
          18.verticalSpacer,
          Consumer(builder: (context, ref, _) {
            final state = ref.watch(authViewmodelProvider);

            ref.listen(
              authViewmodelProvider.select((value) => value.auth),
              (Auth? previous, Auth next) {
                if (previous != next) {
                  if (next == Auth.loginError) {
                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: text(state.errorMessage!),
                        ),
                      );
                    }
                  } else if (next == Auth.loginSuccess) {
                    Navigator.pushReplacementNamed(
                      context,
                      DashboardView.routeName,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: text('Login Successful'),
                      ),
                    );
                  }
                }
              },
            );
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
              height: 54,
              width: context.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  ref.watch(authViewmodelProvider.notifier).loginUser(
                        username: _emailController.text,
                        password: _passwordController.text,
                      );
                },
                child: text(
                  'Login',
                  size: context.textTheme.headlineSmall?.fontSize,
                  fontweight: FontWeight.w500,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
