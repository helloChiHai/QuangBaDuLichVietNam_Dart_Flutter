import 'package:equatable/equatable.dart';

abstract class UpdateImageEvent extends Equatable {
  const UpdateImageEvent();
  @override
  List<Object?> get props => [];
}

class UpdateImageButtonPressed extends UpdateImageEvent {
  final String idCus;
  final String newImage;
  UpdateImageButtonPressed({required this.idCus, required this.newImage});
  @override
  List<Object?> get props => [idCus, newImage];
}
