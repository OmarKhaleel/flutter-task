// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:user_repository/user_repository.dart';

// part 'sign_up_event.dart';
// part 'sign_up_state.dart';

// class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
//   final UserRepository _userRepository;

//   SignUpBloc({required UserRepository userRepository})
//       : _userRepository = userRepository,
//         super(SignUpInitial()) {
//     on<SignUpRequired>((event, emit) async {
//       emit(SignUpProcess());
//       try {
//         MyUserModel user =
//             await _userRepository.signUp(event.user, event.password);
//         await _userRepository.setUserData(user);
//         emit(SignUpSuccess());
//       } catch (e) {
//         emit(SignUpFailure());
//       }
//     });
//   }
// }

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());

      final Completer<void> completer = Completer<void>();

      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: event.user.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            try {
              await FirebaseAuth.instance.signInWithCredential(credential);
              completer.complete();
              add(OTPVerified(event.user, event.password, '', ''));
            } catch (e) {
              if (!completer.isCompleted) {
                completer.completeError(e);
              }
            }
          },
          verificationFailed: (FirebaseAuthException e) async {
            if (!completer.isCompleted) {
              completer.completeError(e);
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            if (!completer.isCompleted) {
              completer.complete();
            }
            emit(OTPSent(verificationId, event.user, event.password));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );

        await completer.future;
      } catch (e) {
        emit(SignUpFailure());
      }
    });

    on<OTPVerified>((event, emit) async {
      emit(SignUpProcess());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.smsCode,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        MyUserModel user =
            await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(user);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
