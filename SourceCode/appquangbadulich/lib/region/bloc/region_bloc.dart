import 'package:appquangbadulich/region/bloc/region_event.dart';
import 'package:appquangbadulich/region/bloc/region_state.dart';
import 'package:bloc/bloc.dart';

import '../../repositories/repositories.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  final UserRepository userRepository;

  RegionBloc({required this.userRepository}) : super(RegionInitial()) {
    on<FetchRegions>((event, emit) async {
      try {
        emit(RegionLoading());
        final regions = await userRepository.getRegions();
        emit(RegionLoaded(regions: regions));
      } catch (e) {
        emit(RegionLoadFailure(error: e.toString()));
      }
    });
  }
}
