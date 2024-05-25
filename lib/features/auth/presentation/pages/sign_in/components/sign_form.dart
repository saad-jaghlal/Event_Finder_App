import 'package:event_finder_app/core/common/widget/loader.dart';
import 'package:event_finder_app/core/utils/show_snackbar.dart';
import 'package:event_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_finder_app/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../components/custom_surfix_icon.dart';
// import '../../../components/form_error.dart';
import '../../../widget/form_error.dart';
import '../../../widget/constants.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../helper/keyboard.dart';
// import '../../forgot_password/forgot_password_screen.dart';
// import '../../login_success/login_success_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        } else if (state is AuthInvalidPassword) {
          showSnackBar(context, 'Invalid password. Please try again.');
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const MyLoader();
        } else if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => email = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kEmailNullError);
                  } else if (emailValidatorRegExp.hasMatch(value)) {
                    removeError(error: kInvalidEmailError);
                  }
                  return;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kEmailNullError);
                    return "";
                  } else if (!emailValidatorRegExp.hasMatch(value)) {
                    addError(error: kInvalidEmailError);
                    return "";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(Icons.mail),
                    )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                onSaved: (newValue) => password = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kPassNullError);
                  } else if (value.length >= 8) {
                    removeError(error: kShortPassError);
                  }
                  return;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kPassNullError);
                    return "";
                  } else if (value.length < 8) {
                    addError(error: kShortPassError);
                    return "";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(Icons.lock),
                    )),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: remember,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        remember = value;
                      });
                    },
                  ),
                  const Text("Remember me"),
                  const Spacer(),
                  GestureDetector(
                    // onTap: () => Navigator.pushNamed(
                    //     context, ForgotPasswordScreen.routeName),
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              FormError(errors: errors),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<AuthBloc>().add(
                          AuthLogin(
                            email: email!.trim(),
                            password: password!.trim(),
                          ),
                        );
                    // if all are valid then go to success screen
                    // KeyboardUtil.hideKeyboard(context);
                    // Navigator.pushNamed(context, PlatformView());
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const MyHomePage(),
                    //   ),
                    // );
                  }
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        );
      },
    );
  }
}
