import 'package:equatable/equatable.dart';

abstract class CheckCommentOwnerShipEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckCommentOwner extends CheckCommentOwnerShipEvent {
  final String idTourist;
  final String idCus;
  final String idcmt;
  CheckCommentOwner(
      {required this.idTourist, required this.idCus, required this.idcmt});
  @override
  List<Object?> get props => [idTourist, idCus, idcmt];
}
