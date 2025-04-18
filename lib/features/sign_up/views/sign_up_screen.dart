import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_booster/core/constants/constant.dart';
import 'package:health_booster/core/extensions/build_context_extensions.dart';
import 'package:health_booster/core/theme/app_fonts.dart';
import 'package:health_booster/core/utils/app_utils.dart';
import 'package:health_booster/core/validations/validations.dart';
import 'package:health_booster/core/widgets/buttons/app_button_widget.dart';
import 'package:health_booster/core/widgets/buttons/focus_mode_manager_widget.dart'
    show FocusModeManagerWidget;
import 'package:health_booster/core/widgets/text_field/text_field_widget.dart';
import 'package:health_booster/features/sign_up/bloc/sign_up_bloc.dart';
import 'package:health_booster/injection.dart' show injection;
import 'package:nb_utils/nb_utils.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conformationPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _signUp = injection<SignUpBloc>();

  @override
  Widget build(BuildContext context) {
    return FocusModeManagerWidget(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BlocProvider.value(
                  value: _signUp,
                  child: BlocConsumer<SignUpBloc, SignUpState>(
                    listener: _stateListener,
                    builder: (context, state) {
                      bool isSignUpLoading = state is SignUpLoading;

                      return IgnorePointer(
                        ignoring: isSignUpLoading,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 100),
                            Text(
                              'Welcome,\n$myAppName',
                              style: AppFonts.displayBold
                                  .copyWith(color: context.colorScheme.primary),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Create an account to get started',
                              style: AppFonts.label,
                            ),
                            const SizedBox(height: 20),
                            TextFieldWidget(
                              labelText: "Full Name",
                              hintText: "Enter your full name",
                              controller: _fullNameController,
                              validator: (value) =>
                                  validateRequiredField("Full name", value),
                            ),
                            const SizedBox(height: 6),
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
                            TextFieldWidget(
                              labelText: "Confirm Password",
                              hintText: "Re-enter your password",
                              controller: _conformationPasswordController,
                              validator: (value) => validateConfirmPassword(
                                  value, _passwordController.text.trim()),
                              textFieldType: TextFieldType.PASSWORD,
                            ),
                            const SizedBox(height: 20),
                            AppButtonWidget(
                              text: "Sign Up",
                              onTap: _onSignUpButtonPressed,
                              isLoading: isSignUpLoading,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: AppFonts.caption,
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () =>
                                      _signUp.add(SignInSelectionEvent()),
                                  child: Text(
                                    "Sign In",
                                    style: AppFonts.label.copyWith(
                                      color: context.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _stateListener(BuildContext context, SignUpState state) {
    if (state is SignUpFailure) {
      showErrorMessage(state.error);
    } else if (state is SignUpSuccess) {
      showSuccessMessage("Email verification sent");
      context.maybePop();
    } else if (state is SignInSelection) {
      context.maybePop();
    }
  }

  void _onSignUpButtonPressed() {
    if (!_formKey.currentState!.validate()) return;

    closeKeyboard;

    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();
    final fullName = _fullNameController.text.trim();

    _signUp.add(
      SignUpButtonPressed(fullName: fullName, email: email, password: password),
    );
  }
}
