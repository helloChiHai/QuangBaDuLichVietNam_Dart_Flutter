import 'package:equatable/equatable.dart';

abstract class AddCommentEvent extends Equatable {
  const AddCommentEvent();
  @override
  List<Object?> get props => [];
}

class AddCommentButtonPress extends AddCommentEvent {
  final String idTourist;
  final String idCus;
  final String commentData;
  AddCommentButtonPress({
    required this.idTourist,
    required this.idCus,
    required this.commentData,
  });
  @override
  List<Object?> get props => [idTourist, idCus, commentData];
}
