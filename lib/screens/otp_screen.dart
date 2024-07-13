import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_task/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_task/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_task/screens/sign_in_screen.dart';
import 'package:user_repository/user_repository.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  final MyUserModel user;
  final String password;

  const OTPScreen({
    super.key,
    required this.verificationId,
    required this.user,
    required this.password,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<SignUpBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('OTP Verification'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'Enter OTP',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final otpCode = _otpController.text.trim();
                  if (otpCode.isNotEmpty) {
                    context.read<SignUpBloc>().add(
                          OTPVerified(
                            widget.user,
                            widget.password,
                            widget.verificationId,
                            otpCode,
                          ),
                        );
                  }
                },
                child: const Text('Verify OTP'),
              ),
              BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(
                              userRepository: context
                                  .read<AuthenticationBloc>()
                                  .userRepository),
                          child: const SignInScreen(),
                        ),
                      ),
                    );
                  } else if (state is SignUpFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('OTP Verification Failed')),
                    );
                  }
                },
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
