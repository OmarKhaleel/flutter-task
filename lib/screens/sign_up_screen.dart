// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_task/blocs/authentication_bloc/authentication_bloc.dart';
// import 'package:flutter_task/blocs/sign_in_bloc/sign_in_bloc.dart';
// import 'package:flutter_task/blocs/sign_up_bloc/sign_up_bloc.dart';
// import 'package:flutter_task/components/age_textfield.dart';
// import 'package:flutter_task/components/gender_dropdown.dart';
// import 'package:flutter_task/components/phone_number_textfield.dart';
// import 'package:flutter_task/components/regex.dart';
// import 'package:flutter_task/components/textfield.dart';
// import 'package:flutter_task/screens/sign_in_screen.dart';
// import 'package:user_repository/user_repository.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final ageTextFieldController = TextEditingController();
//   final genderTextFieldController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   bool obscurePassword = true;
//   IconData iconPassword = CupertinoIcons.eye_fill;
//   final nameController = TextEditingController();
//   bool signUpRequired = false;
//   String? selectedCountryCode = '+962';

//   bool containsUpperCase = false;
//   bool containsLowerCase = false;
//   bool containsNumber = false;
//   bool containsSpecialChar = false;
//   bool contains8Length = false;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SignUpBloc, SignUpState>(
//       listener: (context, state) {
//         if (state is SignUpSuccess) {
//           setState(() {
//             signUpRequired = false;
//           });
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BlocProvider<SignInBloc>(
//                 create: (context) => SignInBloc(
//                     userRepository:
//                         context.read<AuthenticationBloc>().userRepository),
//                 child: const SignInScreen(),
//               ),
//             ),
//           );
//         } else if (state is SignUpProcess) {
//           setState(() {
//             signUpRequired = true;
//           });
//         } else if (state is SignUpFailure) {
//           return;
//         }
//       },
//       child: GestureDetector(
//         onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//         child: Scaffold(
//           body: Form(
//             key: _formKey,
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0, top: 32.0),
//                       child: Align(
//                         alignment: Alignment.topLeft,
//                         child: IconButton(
//                           icon: const Icon(Icons.arrow_back,
//                               color: Color(0xFF003366)),
//                           onPressed: () => Navigator.of(context).pop(),
//                         ),
//                       ),
//                     ),
//                     const Center(
//                       child: Text(
//                         "Registration",
//                         style: TextStyle(
//                             color: Color(0xFF003366),
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       child: MyTextField(
//                           controller: nameController,
//                           hintText: 'Name',
//                           obscureText: false,
//                           keyboardType: TextInputType.name,
//                           prefixIcon: const Icon(CupertinoIcons.person_fill,
//                               color: Color(0xFF003366)),
//                           validator: (val) {
//                             if (val!.isEmpty) {
//                               return 'Please fill in this field';
//                             } else if (val.length > 30) {
//                               return 'Name too long';
//                             }
//                             return null;
//                           }),
//                     ),
//                     const SizedBox(height: 5),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       child: PhoneNumberTextField(
//                         controller: phoneController,
//                         hintText: 'Phone Number',
//                         selectedCountryCode: selectedCountryCode,
//                         onCountryCodeChanged: (value) {
//                           setState(() {
//                             selectedCountryCode = value;
//                           });
//                         },
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return 'Please fill in this field';
//                           } else if (!phoneNumberRexExp.hasMatch(val)) {
//                             return 'Please enter a valid phone number';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       child: AgeTextField(
//                         controller: ageTextFieldController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter an age';
//                           } else if (int.tryParse(value) == null ||
//                               int.parse(value) <= 0) {
//                             return 'Please enter a valid age';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       child: GenderDropdown(
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please select a gender';
//                           } else {
//                             genderTextFieldController.text = value;
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       child: MyTextField(
//                           controller: emailController,
//                           hintText: 'Email',
//                           obscureText: false,
//                           keyboardType: TextInputType.emailAddress,
//                           prefixIcon: const Icon(
//                             CupertinoIcons.mail_solid,
//                             color: Color(0xFF003366),
//                           ),
//                           validator: (val) {
//                             if (val!.isEmpty) {
//                               return 'Please fill in this field';
//                             } else if (!emailRexExp.hasMatch(val)) {
//                               return 'Please enter a valid email';
//                             }
//                             return null;
//                           }),
//                     ),
//                     const SizedBox(height: 5),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       child: MyTextField(
//                           controller: passwordController,
//                           hintText: 'Password',
//                           obscureText: obscurePassword,
//                           keyboardType: TextInputType.visiblePassword,
//                           prefixIcon: const Icon(
//                             CupertinoIcons.lock_fill,
//                             color: Color(0xFF003366),
//                           ),
//                           onChanged: (val) {
//                             if (val!.contains(RegExp(r'[A-Z]'))) {
//                               setState(() {
//                                 containsUpperCase = true;
//                               });
//                             } else {
//                               setState(() {
//                                 containsUpperCase = false;
//                               });
//                             }
//                             if (val.contains(RegExp(r'[a-z]'))) {
//                               setState(() {
//                                 containsLowerCase = true;
//                               });
//                             } else {
//                               setState(() {
//                                 containsLowerCase = false;
//                               });
//                             }
//                             if (val.contains(RegExp(r'[0-9]'))) {
//                               setState(() {
//                                 containsNumber = true;
//                               });
//                             } else {
//                               setState(() {
//                                 containsNumber = false;
//                               });
//                             }
//                             if (val.contains(specialCharRexExp)) {
//                               setState(() {
//                                 containsSpecialChar = true;
//                               });
//                             } else {
//                               setState(() {
//                                 containsSpecialChar = false;
//                               });
//                             }
//                             if (val.length >= 8) {
//                               setState(() {
//                                 contains8Length = true;
//                               });
//                             } else {
//                               setState(() {
//                                 contains8Length = false;
//                               });
//                             }
//                             return null;
//                           },
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 obscurePassword = !obscurePassword;
//                                 if (obscurePassword) {
//                                   iconPassword = CupertinoIcons.eye_fill;
//                                 } else {
//                                   iconPassword = CupertinoIcons.eye_slash_fill;
//                                 }
//                               });
//                             },
//                             icon: Icon(iconPassword),
//                             color: const Color(0xFF003366),
//                           ),
//                           validator: (val) {
//                             if (val!.isEmpty) {
//                               return 'Please fill in this field';
//                             } else if (!passwordRexExp.hasMatch(val)) {
//                               return 'Please enter a valid password';
//                             }
//                             return null;
//                           }),
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "⚈  1 uppercase",
//                               style: TextStyle(
//                                   color: containsUpperCase
//                                       ? Colors.green
//                                       : Theme.of(context)
//                                           .colorScheme
//                                           .onSurface),
//                             ),
//                             Text(
//                               "⚈  1 lowercase",
//                               style: TextStyle(
//                                   color: containsLowerCase
//                                       ? Colors.green
//                                       : Theme.of(context)
//                                           .colorScheme
//                                           .onSurface),
//                             ),
//                             Text(
//                               "⚈  1 number",
//                               style: TextStyle(
//                                   color: containsNumber
//                                       ? Colors.green
//                                       : Theme.of(context)
//                                           .colorScheme
//                                           .onSurface),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "⚈  1 special character",
//                               style: TextStyle(
//                                   color: containsSpecialChar
//                                       ? Colors.green
//                                       : Theme.of(context)
//                                           .colorScheme
//                                           .onSurface),
//                             ),
//                             Text(
//                               "⚈  8 minimum character",
//                               style: TextStyle(
//                                   color: contains8Length
//                                       ? Colors.green
//                                       : Theme.of(context)
//                                           .colorScheme
//                                           .onSurface),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       child: MyTextField(
//                         controller: confirmPasswordController,
//                         hintText: 'Password',
//                         obscureText: obscurePassword,
//                         keyboardType: TextInputType.visiblePassword,
//                         prefixIcon: const Icon(
//                           CupertinoIcons.lock_fill,
//                           color: Color(0xFF003366),
//                         ),
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return 'Please fill in this field';
//                           } else if (!passwordRexExp.hasMatch(val)) {
//                             return 'Please enter a valid password';
//                           } else {
//                             return null;
//                           }
//                         },
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               obscurePassword = !obscurePassword;
//                               if (obscurePassword) {
//                                 iconPassword = CupertinoIcons.eye_fill;
//                               } else {
//                                 iconPassword = CupertinoIcons.eye_slash_fill;
//                               }
//                             });
//                           },
//                           icon: Icon(iconPassword),
//                           color: const Color(0xFF003366),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.5,
//                       child: TextButton(
//                         onPressed: () {
//                           if (confirmPasswordController.text.trim() !=
//                               passwordController.text.trim()) {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: const Text('Password Mismatch'),
//                                   content: const Text(
//                                       'The passwords you entered do not match. Please try again.'),
//                                   actions: <Widget>[
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: const Text('OK'),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           } else {
//                             if (_formKey.currentState!.validate()) {
//                               MyUserModel myUser = MyUserModel.empty;
//                               final String phoneNumberText =
//                                   "$selectedCountryCode${phoneController.text}";
//                               myUser = myUser.copyWith(
//                                 // email: emailController.text,
//                                 fullName: nameController.text,
//                                 age: ageTextFieldController.text,
//                                 gender: genderTextFieldController.text,
//                                 phoneNumber: phoneNumberText,
//                               );

//                               setState(() {
//                                 context.read<SignUpBloc>().add(SignUpRequired(
//                                     myUser, passwordController.text));
//                               });
//                             }
//                           }
//                         },
//                         style: TextButton.styleFrom(
//                             elevation: 3.0,
//                             backgroundColor: const Color(0xFF003366),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(60))),
//                         child: const Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//                           child: Text(
//                             'Sign Up',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_task/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_task/components/age_textfield.dart';
import 'package:flutter_task/components/gender_dropdown.dart';
import 'package:flutter_task/components/phone_number_textfield.dart';
import 'package:flutter_task/components/regex.dart';
import 'package:flutter_task/components/textfield.dart';
import 'package:flutter_task/screens/otp_screen.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final ageTextFieldController = TextEditingController();
  final genderTextFieldController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  bool signUpRequired = false;
  String? selectedCountryCode = '+962';

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is OTPSent) {
          setState(() {
            signUpRequired = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<SignUpBloc>(
                create: (context) => SignUpBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
                child: OTPScreen(
                  verificationId: state.verificationId,
                  user: state.user,
                  password: state.password,
                ),
              ),
            ),
          );
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign Up Failed')),
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 32.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Color(0xFF003366)),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Registration",
                        style: TextStyle(
                          color: Color(0xFF003366),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: nameController,
                        hintText: 'Name',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(CupertinoIcons.person_fill,
                            color: Color(0xFF003366)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (val.length > 30) {
                            return 'Name too long';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: PhoneNumberTextField(
                        controller: phoneController,
                        hintText: 'Phone Number',
                        selectedCountryCode: selectedCountryCode,
                        onCountryCodeChanged: (value) {
                          setState(() {
                            selectedCountryCode = value;
                          });
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (!phoneNumberRexExp.hasMatch(val)) {
                            return 'Please enter a valid phone number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: AgeTextField(
                        controller: ageTextFieldController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an age';
                          } else if (int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return 'Please enter a valid age';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: GenderDropdown(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a gender';
                          } else {
                            genderTextFieldController.text = value;
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock_fill,
                            color: Color(0xFF003366)),
                        onChanged: (val) {
                          if (val!.contains(RegExp(r'[A-Z]'))) {
                            setState(() {
                              containsUpperCase = true;
                            });
                          } else {
                            setState(() {
                              containsUpperCase = false;
                            });
                          }
                          if (val.contains(RegExp(r'[a-z]'))) {
                            setState(() {
                              containsLowerCase = true;
                            });
                          } else {
                            setState(() {
                              containsLowerCase = false;
                            });
                          }
                          if (val.contains(RegExp(r'[0-9]'))) {
                            setState(() {
                              containsNumber = true;
                            });
                          } else {
                            setState(() {
                              containsNumber = false;
                            });
                          }
                          if (val.contains(specialCharRexExp)) {
                            setState(() {
                              containsSpecialChar = true;
                            });
                          } else {
                            setState(() {
                              containsSpecialChar = false;
                            });
                          }
                          if (val.length >= 8) {
                            setState(() {
                              contains8Length = true;
                            });
                          } else {
                            setState(() {
                              contains8Length = false;
                            });
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                              if (obscurePassword) {
                                iconPassword = CupertinoIcons.eye_fill;
                              } else {
                                iconPassword = CupertinoIcons.eye_slash_fill;
                              }
                            });
                          },
                          icon: Icon(iconPassword),
                          color: const Color(0xFF003366),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (!passwordRexExp.hasMatch(val)) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "⚈  1 uppercase",
                              style: TextStyle(
                                  color: containsUpperCase
                                      ? Colors.green
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                            Text(
                              "⚈  1 lowercase",
                              style: TextStyle(
                                  color: containsLowerCase
                                      ? Colors.green
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                            Text(
                              "⚈  1 number",
                              style: TextStyle(
                                  color: containsNumber
                                      ? Colors.green
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "⚈  1 special character",
                              style: TextStyle(
                                  color: containsSpecialChar
                                      ? Colors.green
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                            Text(
                              "⚈  8 minimum character",
                              style: TextStyle(
                                  color: contains8Length
                                      ? Colors.green
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock_fill,
                            color: Color(0xFF003366)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (!passwordRexExp.hasMatch(val)) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                              if (obscurePassword) {
                                iconPassword = CupertinoIcons.eye_fill;
                              } else {
                                iconPassword = CupertinoIcons.eye_slash_fill;
                              }
                            });
                          },
                          icon: Icon(iconPassword),
                          color: const Color(0xFF003366),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextButton(
                        onPressed: () {
                          if (confirmPasswordController.text.trim() !=
                              passwordController.text.trim()) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Password Mismatch'),
                                  content: const Text(
                                      'The passwords you entered do not match. Please try again.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            if (_formKey.currentState!.validate()) {
                              MyUserModel myUser = MyUserModel.empty;
                              final String phoneNumberText =
                                  "$selectedCountryCode${phoneController.text}";
                              myUser = myUser.copyWith(
                                // email: "", // Remove the email field from here
                                fullName: nameController.text,
                                age: ageTextFieldController.text,
                                gender: genderTextFieldController.text,
                                phoneNumber: phoneNumberText,
                              );

                              setState(() {
                                context.read<SignUpBloc>().add(SignUpRequired(
                                    myUser, passwordController.text));
                              });
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: const Color(0xFF003366),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
