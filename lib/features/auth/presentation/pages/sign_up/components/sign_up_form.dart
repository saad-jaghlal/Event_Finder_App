import 'package:event_finder_app/core/common/widget/loader.dart';
import 'package:event_finder_app/core/utils/show_snackbar.dart';
import 'package:event_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_finder_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../components/custom_surfix_icon.dart';
// import '../../../components/form_error.dart';
import '../../../widget/form_error.dart';
import '../../../widget/constants.dart';
// import '../../complete_profile/complete_profile_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conform_password;
  bool remember = false;
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
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const MyLoader();
        }
        // else if(state is AuthSuccess){
        //     Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const SignInScreen(),
        //       ),
        //       (Route<dynamic> route) => false,
        //     );
        // }
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
                  )
                ),
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
                  password = value;
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
                  )
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                onSaved: (newValue) => conform_password = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kPassNullError);
                  } else if (value.isNotEmpty && password == conform_password) {
                    removeError(error: kMatchPassError);
                  }
                  conform_password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kPassNullError);
                    return "";
                  } else if ((password != value)) {
                    addError(error: kMatchPassError);
                    return "";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Re-enter your password",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Icon(Icons.lock),
                  )
                ),
              ),
              FormError(errors: errors),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // if all are valid then go to success screen
                    context.read<AuthBloc>().add(
                          AuthSignUp(
                            email: email!.trim(),
                            password: password!.trim(),
                          ),
                        );
                    Navigator.pushNamed(context, SignInScreen.routeName);
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
