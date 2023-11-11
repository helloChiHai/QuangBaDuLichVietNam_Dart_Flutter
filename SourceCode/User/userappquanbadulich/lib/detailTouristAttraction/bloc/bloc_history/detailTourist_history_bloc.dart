import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_event.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class DetailTourist_HistoryBloc
    extends Bloc<DetailTourist_HistoryEvent, DetailTourist_HistoryState> {
  final UserRepository userRepository;
  DetailTourist_HistoryBloc({required this.userRepository})
      : super(DetailTourist_HistoryInitial()) {
    on<getTouristWithHistory>(
      (event, emit) async {
        emit(DetailTourist_HistoryLoading());
        try {
          final tourist =
              await userRepository.getTouristWithHistory(event.idHistoryStory);
          if (tourist != null) {
            emit(DetailTourist_HistoryLoaded(touristAttraction: tourist));
          } else {
            DetailTourist_HistoryFailure(error: 'bị lỗi');
          }
        } catch (e) {
          emit(DetailTourist_HistoryFailure(error: e.toString()));
        }
      },
    );
  }
}
