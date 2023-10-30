import 'package:appquangbadulich/culture/bloc/culture_event.dart';
import 'package:appquangbadulich/culture/bloc/culture_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

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
