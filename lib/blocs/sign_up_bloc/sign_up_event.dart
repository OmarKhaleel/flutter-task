// part of 'sign_up_bloc.dart';

// @immutable
// abstract class SignUpEvent extends Equatable {
//   const SignUpEvent();

//   @override
//   List<Object?> get props => [];
// }

// class SignUpRequired extends SignUpEvent {
//   final MyUserModel user;
//   final String password;

//   const SignUpRequired(this.user, this.password);
// }

part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final MyUserModel user;
  final String password;

  const SignUpRequired(this.user, this.password);
}

class OTPVerified extends SignUpEvent {
  final MyUserModel user;
  final String password;
  final String verificationId;
  final String smsCode;

  const OTPVerified(
      this.user, this.password, this.verificationId, this.smsCode);
}
