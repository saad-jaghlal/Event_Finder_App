import 'package:event_finder_app/features/auth/presentation/pages/login_page.dart';
import 'package:event_finder_app/features/auth/presentation/widget/auth_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  bool _isVisibility = false;
  bool _ispasswordstatus = false;
  bool _hasPasswordOneNumber = false;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  creat() {
    var formstae = formstate.currentState;
    if (formstae!.validate()) {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => Categorei()));
    }
  }

  onpasswordchange(String password) {
    final numberredexp = RegExp(r'[0-9]');
    setState(() {
      _ispasswordstatus = false;
      if (password.length >= 8) {
        _ispasswordstatus = true;
      }

      _hasPasswordOneNumber = false;
      if (numberredexp.hasMatch(password)) {
        _hasPasswordOneNumber = true;
      }
    });
  }

  // static ThemeData onClick() {
  //   return AppTheme.darkThemeMode;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
        // title: const Text(
        //   "Create Your Account ",
        //   style: TextStyle(color: Colors.black, fontSize: 25),
        // ),
        // actions: [
        //   ElevatedButton(
        //     onPressed: () {

        //     },
        //     style: ElevatedButton.styleFrom(
        //       // Set text color
        //       shape: RoundedRectangleBorder(
        //         borderRadius:
        //             BorderRadius.circular(10.0), // Customize button shape
        //       ),
        //     ),
        //     child: const Text('Your Button Text'),
        //   ),
        // ],
      ),
      body: Stack(children: [
        ListView(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: const Text(
                    "SignUp",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Form(
                key: formstate,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    //  this is a custom TextFormField
                     AuthField(
                      hintText: "FirstName",
                      prefixIcon:const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      validator: (val) {
                        if (val!.length > 30) {
                          return "FirstName il ne peut pas dépasser 30 caractères";
                        }
                        if (val.length < 15) {
                          return "FirstName il ne peut pas avoir moins de 15 caractères ";
                        }
                        return "";
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthField(
                      hintText: "LastName",
                      prefixIcon:const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      validator: (val) {
                        if (val!.length > 15) {
                          return "LastName il ne peut pas dépasser 15 caractères";
                        }
                        if (val.length < 3) {
                          return "LastName il ne peut pas avoir moins de 3 caractères ";
                        }
                        return "";
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.length > 15) {
                          return "Email il ne peut pas dépasser 15 caractères";
                        }
                        if (val.length < 3) {
                          return "Email il ne peut pas avoir moins de 3 caractères ";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.length > 30) {
                          return "Password il ne peut pas dépasser 30 caractères";
                        }
                        if (val.length < 8) {
                          return "Password il ne peut pas avoir moins de 8 caractères ";
                        }
                        return null;
                      },
                      onChanged: (password) {
                        return onpasswordchange(password);
                      },
                      obscureText: !_isVisibility,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          hintText: "Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisibility = !_isVisibility;
                                });
                              },
                              icon: _isVisibility
                                  ? const Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: _ispasswordstatus
                                  ? const Color.fromARGB(255, 33, 150, 243)
                                  : null,
                              border: _ispasswordstatus
                                  ? Border.all(color: Colors.blue)
                                  : Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Contain at least 8 charaeters"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: _hasPasswordOneNumber
                                  ? const Color.fromARGB(255, 33, 150, 243)
                                  : null,
                              border: _hasPasswordOneNumber
                                  ? Border.all(color: Colors.blue)
                                  : Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Contain at least 1 Number"),
                      ],
                    ),
                  ]),
                )),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: MaterialButton(
                  onPressed: () {
                    creat();
                  },
                  height: 50,
                  minWidth: double.infinity,
                  color: const Color.fromARGB(255, 66, 125, 252),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "Create Accont",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 155,
                    child: const Divider(
                      thickness: 2.2,
                      color: Colors.black,
                      indent: 20,
                      height: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Or Login with",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 150,
                  child: const Divider(
                    thickness: 2.2,
                    color: Colors.black,
                    indent: 15,
                    height: 40,
                    endIndent: 30,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already signed up?",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  LoginPage()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ))
              ],
            )
          ],
        )
      ]),
    );
  }
}
