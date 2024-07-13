import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_task/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_task/blocs/user_bloc/user_event.dart';
import 'package:flutter_task/blocs/user_bloc/user_state.dart';
import 'package:user_repository/user_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user!.uid;

    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(
        RepositoryProvider.of<FirebaseUserRepository>(context),
      )..add(LoadUser(userId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              return const Center(child: Text('Please wait...'));
            } else if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.user;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Your Information:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003366),
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        color: const Color(0xFF003366),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(
                            color: Color(0xFF003366),
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full Name: ${user.fullName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Age: ${user.age}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Gender: ${user.gender}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Phone Number: ${user.phoneNumber}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextButton(
                          onPressed: () {
                            context
                                .read<SignInBloc>()
                                .add(const SignOutRequired());
                          },
                          style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor: const Color(0xFF003366),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Text(
                              'Log Out',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is UserError) {
              return Center(
                  child: Text('Failed to load user data: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
