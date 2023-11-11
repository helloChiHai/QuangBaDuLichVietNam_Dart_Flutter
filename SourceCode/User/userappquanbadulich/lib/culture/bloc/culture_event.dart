import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CultureEvent extends Equatable {
  const CultureEvent();
  @override
  List<Object?> get props => [];
}

class FetchCultures extends CultureEvent {}
