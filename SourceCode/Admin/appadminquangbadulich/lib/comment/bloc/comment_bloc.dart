import 'package:appadminquangbadulich/comment/bloc/comment_event.dart';
import 'package:appadminquangbadulich/comment/bloc/comment_state.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AdminRepository adminRepository;
  CommentBloc({required this.adminRepository}) : super(CommentInitial()) {
    on(<LoadComment>(event, emit) async {
      try {
        emit(CommentLoading());
        final comments =
            await adminRepository.getAllCommentByIdTourist(event.idTourist);
        emit(CommentLoaded(comments: comments));
      } catch (e) {
        emit(CommentFailure(error: e.toString()));
      }
    });
  }
}
