import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String age;
  final String gender;
  final String phoneNumber;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.phoneNumber,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'phoneNumber': phoneNumber,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
        id: doc['id'] as String,
        email: doc['email'] as String,
        fullName: doc['fullName'] as String,
        age: doc['age'] as String,
        gender: doc['gender'] as String,
        phoneNumber: doc['phoneNumber'] as String);
  }

  @override
  List<Object?> get props => [id, email, fullName, age, gender, phoneNumber];

  @override
  String toString() {
    return '''UserEntity: {
      id: $id
      email: $email
      fullName: $fullName
      age: $age
      gender: $gender
      phoneNumber: $phoneNumber
    }''';
  }
}
