import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/checkCommentOwnership/bloc/checkCommentOwnership_event.dart';
import 'package:userappquanbadulich/checkCommentOwnership/bloc/checkCommentOwnership_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class CheckCommentOwnerShipBloc
    extends Bloc<CheckCommentOwnerShipEvent, CheckCommentOwnerShipState> {
  final UserRepository userRepository;
  CheckCommentOwnerShipBloc({required this.userRepository})
      : super(CheckCommentOwnerInitial()) {
    on(<CheckCommentOwner>(event, emit) async {
      try {
        final result = await userRepository.checkCommentOwnership(
            event.idTourist, event.idCus, event.idcmt);
        if (result == 1) {
          emit(CheckCommentOwnerSuccess(result: result));
        } else {
          emit(CheckCommentOwnerError(
              error: 'Lỗi xác định chủ sở hửu bình luận'));
        }
      } catch (e) {
        emit(CheckCommentOwnerError(error: e.toString()));
      }
    });
  }
}
