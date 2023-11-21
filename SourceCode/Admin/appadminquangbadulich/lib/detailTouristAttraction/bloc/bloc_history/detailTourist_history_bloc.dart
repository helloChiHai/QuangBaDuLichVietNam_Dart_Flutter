import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_event.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_state.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';

class DetailTourist_HistoryBloc
    extends Bloc<DetailTourist_HistoryEvent, DetailTourist_HistoryState> {
  final AdminRepository adminRepository;
  DetailTourist_HistoryBloc({required this.adminRepository})
      : super(DetailTourist_HistoryInitial()) {
    on<getTouristWithHistory>(
      (event, emit) async {
        emit(DetailTourist_HistoryLoading());
        try {
          final tourist =
              await adminRepository.getTouristWithHistory(event.idHistoryStory);
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
