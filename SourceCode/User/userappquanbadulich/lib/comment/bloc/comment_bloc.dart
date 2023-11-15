import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/comment/bloc/comment_event.dart';
import 'package:userappquanbadulich/comment/bloc/comment_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final UserRepository userRepository;
  CommentBloc({required this.userRepository}) : super(CommentInitial()) {
    on(<LoadComment>(event, emit) async {
      try {
        emit(CommentLoading());
        final comments =
            await userRepository.getAllCommentByIdTourist(event.idTourist);
        emit(CommentLoaded(comments: comments));
      } catch (e) {
        emit(CommentFailure(error: e.toString()));
      }
    });
  }
}
