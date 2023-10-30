import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CreateAccontEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateAccontButtonPressed extends CreateAccontEvent {
  final String email;
  final String password;
  final String name;
  final String? imgCus;
  final String address;
  final String birthday;
  final int role;

  CreateAccontButtonPressed({
    required this.email,
    required this.password,
    required this.name,
    required this.imgCus,
    required this.address,
    required this.birthday,
    required this.role,
  });

  @override
  List<Object?> get props =>
      [email, password, name, imgCus, address, birthday, role];
}
