import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_task/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_task/blocs/post_bloc/post_bloc.dart';
import 'package:flutter_task/blocs/post_bloc/post_event.dart';
import 'package:flutter_task/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_task/repositories/post_repository.dart';
import 'package:flutter_task/screens/landing_page.dart';
import 'package:flutter_task/screens/sign_in_screen.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task',
      theme: ThemeData(
        primaryColor: const Color(0xFF003366),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: const Color(0xFF003366),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          toolbarTextStyle: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ).bodyMedium,
          titleTextStyle: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ).titleLarge,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFF003366),
            fontSize: 16.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          titleLarge: TextStyle(
            color: Color(0xFF003366),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF003366),
          textTheme: ButtonTextTheme.primary,
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF003366),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF4DA1FF)),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository),
                ),
                BlocProvider(
                  create: (context) => MyUserBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository)
                    ..add(GetMyUser(
                        myUserId: context
                            .read<AuthenticationBloc>()
                            .state
                            .user!
                            .uid)),
                ),
                BlocProvider<PostBloc>(
                  create: (context) => PostBloc(
                    RepositoryProvider.of<PostRepository>(context),
                  )..add(FetchPosts()),
                ),
              ],
              child: const LandingPage(),
            );
          } else {
            return BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
              child: const SignInScreen(),
            );
          }
        },
      ),
    );
  }
}
