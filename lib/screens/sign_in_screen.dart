// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_task/blocs/authentication_bloc/authentication_bloc.dart';

// import 'package:flutter_task/blocs/sign_in_bloc/sign_in_bloc.dart';
// import 'package:flutter_task/blocs/sign_up_bloc/sign_up_bloc.dart';
// import 'package:flutter_task/components/phone_number_textfield.dart';
// import 'package:flutter_task/components/regex.dart';
// import 'package:flutter_task/components/textfield.dart';
// import 'package:flutter_task/screens/home_screen.dart';
// import 'package:flutter_task/screens/sign_up_screen.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
//   String? _errorMsg;
//   bool obscurePassword = true;
//   IconData iconPassword = CupertinoIcons.eye_fill;
//   bool signInRequired = false;
//   String? selectedCountryCode = '+962';

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SignInBloc, SignInState>(
//       listener: (context, state) {
//         if (state is SignInSuccess) {
//           setState(() {
//             signInRequired = false;
//           });
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const HomeScreen()),
//           );
//         } else if (state is SignInProcess) {
//           setState(() {
//             signInRequired = true;
//           });
//         } else if (state is UserNotRegistered) {
//           setState(() {
//             signInRequired = false;
//           });
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 title: const Text('User Not Registered'),
//                 content: const Text('The phone number is not registered.'),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text('Cancel'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BlocProvider<SignUpBloc>(
//                             create: (context) => SignUpBloc(
//                                 userRepository: context
//                                     .read<AuthenticationBloc>()
//                                     .userRepository),
//                             child: const SignUpScreen(),
//                           ),
//                         ),
//                       );
//                     },
//                     child: const Text('Register'),
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       },
//       child: GestureDetector(
//         onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//         child: Scaffold(
//           body: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/progress_soft_logo.png',
//                   width: 250,
//                   height: 150,
//                 ),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         child: PhoneNumberTextField(
//                           controller: phoneController,
//                           hintText: 'Phone Number',
//                           errorMsg: _errorMsg,
//                           selectedCountryCode: selectedCountryCode,
//                           onCountryCodeChanged: (value) {
//                             setState(() {
//                               selectedCountryCode = value;
//                             });
//                           },
//                           validator: (val) {
//                             if (val!.isEmpty) {
//                               return 'Please fill in this field';
//                             } else if (!phoneNumberRexExp.hasMatch(val)) {
//                               return 'Please enter a valid phone number';
//                             } else {
//                               _errorMsg = "";
//                               return null;
//                             }
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         child: MyTextField(
//                             controller: emailController,
//                             hintText: 'Email',
//                             obscureText: false,
//                             keyboardType: TextInputType.emailAddress,
//                             prefixIcon: const Icon(
//                               CupertinoIcons.mail_solid,
//                               color: Color(0xFF003366),
//                             ),
//                             errorMsg: _errorMsg,
//                             validator: (val) {
//                               if (val!.isEmpty) {
//                                 return 'Please fill in this field';
//                               } else if (!emailRexExp.hasMatch(val)) {
//                                 return 'Please enter a valid email';
//                               }
//                               return null;
//                             }),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         child: MyTextField(
//                           controller: passwordController,
//                           hintText: 'Password',
//                           obscureText: obscurePassword,
//                           keyboardType: TextInputType.visiblePassword,
//                           prefixIcon: const Icon(
//                             CupertinoIcons.lock_fill,
//                             color: Color(0xFF003366),
//                           ),
//                           errorMsg: _errorMsg,
//                           validator: (val) {
//                             if (val!.isEmpty) {
//                               return 'Please fill in this field';
//                             } else if (!passwordRexExp.hasMatch(val)) {
//                               return 'Please enter a valid password';
//                             } else {
//                               _errorMsg = "";
//                               return null;
//                             }
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
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       !signInRequired
//                           ? SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.9,
//                               height: 50,
//                               child: TextButton(
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     context.read<SignInBloc>().add(
//                                         SignInRequired(emailController.text,
//                                             passwordController.text));
//                                   }
//                                 },
//                                 style: TextButton.styleFrom(
//                                     elevation: 3.0,
//                                     backgroundColor: const Color(0xFF003366),
//                                     foregroundColor: Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(60))),
//                                 child: const Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 25, vertical: 5),
//                                   child: Text(
//                                     'Log In',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : const CircularProgressIndicator(),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Don\'t have an account?',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.grey.shade700,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(
//                               width:
//                                   MediaQuery.of(context).size.height * 0.005),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       BlocProvider<SignUpBloc>(
//                                     create: (context) => SignUpBloc(
//                                         userRepository: context
//                                             .read<AuthenticationBloc>()
//                                             .userRepository),
//                                     child: const SignUpScreen(),
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               'Register',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Color(0xFF003366),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   decoration: TextDecoration.underline),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
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

import 'package:flutter_task/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_task/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_task/components/phone_number_textfield.dart';
import 'package:flutter_task/components/regex.dart';
import 'package:flutter_task/components/textfield.dart';
import 'package:flutter_task/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool signInRequired = false;
  String? selectedCountryCode = '+962';

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          setState(() {
            signInRequired = false;
          });
        } else if (state is SignInProcess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('User Not Registered'),
                content:
                    const Text('The details you entered are not registered.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider<SignUpBloc>(
                            create: (context) => SignUpBloc(
                                userRepository: context
                                    .read<AuthenticationBloc>()
                                    .userRepository),
                            child: const SignUpScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Register'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/progress_soft_logo.png',
                  width: 250,
                  height: 150,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: PhoneNumberTextField(
                          controller: phoneController,
                          hintText: 'Phone Number',
                          errorMsg: _errorMsg,
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
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: obscurePassword,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: const Icon(
                            CupertinoIcons.lock_fill,
                            color: Color(0xFF003366),
                          ),
                          errorMsg: _errorMsg,
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
                      !signInRequired
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final String phoneNumberText =
                                        "$selectedCountryCode${phoneController.text}";
                                    String formattedEmail =
                                        "$phoneNumberText@phone.com";
                                    context.read<SignInBloc>().add(
                                          SignInRequired(
                                            formattedEmail,
                                            passwordController.text.trim(),
                                          ),
                                        );
                                  }
                                },
                                style: TextButton.styleFrom(
                                    elevation: 3.0,
                                    backgroundColor: const Color(0xFF003366),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60))),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 5),
                                  child: Text(
                                    'Log In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                              width:
                                  MediaQuery.of(context).size.height * 0.005),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BlocProvider<SignUpBloc>(
                                    create: (context) => SignUpBloc(
                                        userRepository: context
                                            .read<AuthenticationBloc>()
                                            .userRepository),
                                    child: const SignUpScreen(),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Register',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF003366),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
