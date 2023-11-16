import 'package:equatable/equatable.dart';

abstract class UpdateCommentEvent extends Equatable {
  const UpdateCommentEvent();
  @override
  List<Object?> get props => [];
}

class UpdateCommentButtonPress extends UpdateCommentEvent {
  final String touristId;
  final String idCus;
  final String idcmt;
  final String newCommentData;
  UpdateCommentButtonPress({
    required this.touristId,
    required this.idCus,
    required this.idcmt,
    required this.newCommentData,
  });
  @override
  List<Object?> get props => [touristId, idCus, idcmt, newCommentData];
}
