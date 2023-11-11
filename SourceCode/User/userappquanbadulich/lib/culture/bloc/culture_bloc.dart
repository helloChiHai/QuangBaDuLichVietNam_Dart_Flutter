import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/culture/bloc/culture_event.dart';
import 'package:userappquanbadulich/culture/bloc/culture_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class CultureBloc extends Bloc<CultureEvent, CultureState> {
  final UserRepository userRepository;

  CultureBloc({required this.userRepository}) : super(CultureInitial()) {
    on(<FetchCultures>(event, emit) async {
      try {
        emit(CultureLoading());
        final cultures = await userRepository.getCultures();
        emit(CultureLoaded(cultures: cultures));
      } catch (e) {
        emit(CultureFailure(error: e.toString()));
      }
    });
  }
}
