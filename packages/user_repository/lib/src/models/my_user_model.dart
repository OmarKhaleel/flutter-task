import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/my_user_entity.dart';

class MyUserModel extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String age;
  final String gender;
  final String phoneNumber;

  const MyUserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.phoneNumber,
  });

  static const empty = MyUserModel(
    id: '',
    email: '',
    fullName: '',
    age: '',
    gender: '',
    phoneNumber: '',
  );

  MyUserModel copyWith({
    final String? id,
    final String? email,
    final String? fullName,
    final String? age,
    final String? gender,
    final String? phoneNumber,
  }) {
    return MyUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  // Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUserModel.empty;

  // Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUserModel.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      fullName: fullName,
      age: age,
      gender: gender,
      phoneNumber: phoneNumber,
    );
  }

  static MyUserModel fromEntity(MyUserEntity entity) {
    return MyUserModel(
      id: entity.id,
      email: entity.email,
      fullName: entity.fullName,
      age: entity.age,
      gender: entity.gender,
      phoneNumber: entity.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [id, email, fullName, age, gender, phoneNumber];
}
