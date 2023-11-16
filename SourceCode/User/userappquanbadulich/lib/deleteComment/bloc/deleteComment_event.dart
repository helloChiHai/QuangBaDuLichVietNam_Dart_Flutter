import 'package:equatable/equatable.dart';

abstract class DeleteCommentEvent extends Equatable {
  const DeleteCommentEvent();
  @override
  List<Object?> get props => [];
}

class DeleteCommentButtonPress extends DeleteCommentEvent {
  final String touristId;
  final String idCus;
  final String idcmt;
  DeleteCommentButtonPress({
    required this.touristId,
    required this.idCus,
    required this.idcmt,
  });
  @override
  List<Object?> get props => [touristId, idCus, idcmt];
}
