import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';
import 'package:userappquanbadulich/showAllFilterHistory/bloc/filterHistory_event.dart';
import 'package:userappquanbadulich/showAllFilterHistory/bloc/filterHistory_state.dart';

class FilterHistoryBloc extends Bloc<FilterHistoryEvent, FilterHistoryState> {
  final UserRepository userRepository;
  FilterHistoryBloc({required this.userRepository})
      : super(FilterHistoryInitial()) {
    on(
      <FilterHistory>(event, emit) async {
        try {
          emit(FilterHistoryLoading());
          final history =
              await userRepository.filterHistoryByIdRegionIdProvines(
                  event.idRegion, event.idProvines);
          emit(FilterHistoryLoaded(history: history));
        } catch (e) {
          emit(FilterHistoryFailure(error: e.toString()));
        }
      },
    );
  }
}
