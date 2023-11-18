import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/filterTypeTourist/bloc/filterTypeTourist_event.dart';
import 'package:userappquanbadulich/filterTypeTourist/bloc/filterTypeTourist_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class FilterTypeTouristBloc
    extends Bloc<FilterTypeTouristEvent, FilterTypeTouristState> {
  final UserRepository userRepository;
  FilterTypeTouristBloc({required this.userRepository})
      : super(FilterTypeTouristInitial()) {
    on(
      <FilterTypeTouristAttraction>(event, emit) async {
        try {
          emit(FilterTypeTouristLoading());
          final tourist = await userRepository
              .filterTypeTouristAttractionByIdTypeTourist(event.typeTourist);
          emit(FilterTypeTouristLoaded(tourist: tourist));
        } catch (e) {
          emit(FilterTypeTouristFailure(error: e.toString()));
        }
      },
    );
  }
}
