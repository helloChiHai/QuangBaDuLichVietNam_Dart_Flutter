import 'package:appquangbadulich/history/bloc/history_event.dart';
import 'package:appquangbadulich/history/bloc/history_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final UserRepository userRepository;

  HistoryBloc({required this.userRepository}) : super(HistoryInitial()) {
    on(<FetchHistorys>(event, emit) async {
      try {
        emit(HistoryLoading());
        final history = await userRepository.getHistory();
        emit(HistoryLoaded(history: history));
      } catch (e) {
        emit(HistoryFailure(error: e.toString()));
      }
    });
  }
}
