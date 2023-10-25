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
  final String address;
  final String birthday;

  CreateAccontButtonPressed({
    required this.email,
    required this.password,
    required this.name,
    required this.address,
    required this.birthday,
  });

  @override
  List<Object?> get props => [email, password, name, address, birthday];
}
