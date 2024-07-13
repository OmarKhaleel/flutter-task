import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/app_view.dart';
import 'package:flutter_task/blocs/splash_screen_bloc/splash_screen_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MyAppView(),
              ),
            );
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset('assets/progress_soft_logo.png'),
                    ),
                    const SizedBox(height: 50),
                    const CircularProgressIndicator(
                      color: Color(0xFF003366),
                    ),
                  ],
                ),
                const Positioned(
                  bottom: 16.0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      '© 2024 ProgressSoft Corporation. All rights reserved.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
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
