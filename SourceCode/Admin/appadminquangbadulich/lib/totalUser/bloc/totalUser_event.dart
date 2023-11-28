import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class TotalUserEvent extends Equatable {
  const TotalUserEvent();
  @override
  List<Object?> get props => [];
}

class ToTalUser extends TotalUserEvent {}
