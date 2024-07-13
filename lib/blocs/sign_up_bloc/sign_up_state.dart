// part of 'sign_up_bloc.dart';

// abstract class SignUpState extends Equatable {
//   const SignUpState();

//   @override
//   List<Object?> get props => [];
// }

// class SignUpInitial extends SignUpState {}

// class SignUpSuccess extends SignUpState {}

// class SignUpFailure extends SignUpState {}

// class SignUpProcess extends SignUpState {}

part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {}

class SignUpProcess extends SignUpState {}

class OTPSent extends SignUpState {
  final String verificationId;
  final MyUserModel user;
  final String password;

  const OTPSent(this.verificationId, this.user, this.password);

  @override
  List<Object?> get props => [verificationId, user, password];
}
