import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_booster/core/constants/constant.dart';
import 'package:health_booster/core/extensions/build_context_extensions.dart';
import 'package:health_booster/core/theme/app_fonts.dart';
import 'package:health_booster/core/utils/app_utils.dart';
import 'package:health_booster/core/validations/validations.dart';
import 'package:health_booster/core/widgets/buttons/app_button_widget.dart';
import 'package:health_booster/core/widgets/buttons/focus_mode_manager_widget.dart';
import 'package:health_booster/core/widgets/text_field/text_field_widget.dart';
import 'package:health_booster/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:health_booster/injection.dart';
import 'package:nb_utils/nb_utils.dart';

@RoutePage()
class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _signIn = injection<SignInBloc>();

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    return FocusModeManagerWidget(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: BlocProvider.value(
                value: _signIn,
                child: BlocConsumer<SignInBloc, SignInState>(
                  builder: (context, state) {
                    bool isSignInLoading = state is SignInLoading;

                    return IgnorePointer(
                      ignoring: isSignInLoading,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 100),
                            Text(
                              'Welcome,\n$myAppName',
                              style: AppFonts.displayBold
                                  .copyWith(color: color.primary),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Please sign in to continue using the app.',
                              style:
                                  AppFonts.body.copyWith(color: color.primary),
                            ),
                            const SizedBox(height: 50),
                            TextFieldWidget(
                              labelText: "Email",
                              hintText: "Enter your email",
                              controller: _emailController,
                              validator: validateEmail,
                            ),
                            const SizedBox(height: 6),
                            TextFieldWidget(
                              labelText: "Password",
                              hintText: "Enter your password",
                              controller: _passwordController,
                              validator: validatePassword,
                              textFieldType: TextFieldType.PASSWORD,
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  "Forgot Password?",
                                  style: AppFonts.label
                                      .copyWith(color: color.primary),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            AppButtonWidget(
                              text: "Sign In",
                              isLoading: isSignInLoading,
                              onTap: _onSignInButtonPressed,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: AppFonts.caption,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Sign Up",
                                  style: AppFonts.label
                                      .copyWith(color: color.primary),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                  listener: (context, state) {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSignInButtonPressed() {
    if (!_formKey.currentState!.validate()) return;

    // Close the keyboard if it's open
    closeKeyboard;

    // Perform sign-in logic here
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    _signIn.add(SignInButtonPressed(email: email, password: password));
  }
}
