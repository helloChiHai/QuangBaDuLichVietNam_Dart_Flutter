import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_event.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class DetailTourist_CultureBloc
    extends Bloc<DetailTourist_CultureEvent, DetailTourist_CultureState> {
  final UserRepository userRepository;
  DetailTourist_CultureBloc({required this.userRepository})
      : super(DetailTourist_CultureInitial()) {
    on<getTouristWithCulture>(
      (event, emit) async {
        emit(DetailTourist_CultureLoading());
        try {
          final tourist =
              await userRepository.getTouristWithCulture(event.idCulture);
          if (tourist != null) {
            emit(DetailTourist_CultureLoaded(touristAttraction: tourist));
          } else {
            DetailTourist_CultureFailure(error: 'bị lỗi');
          }
        } catch (e) {
          emit(DetailTourist_CultureFailure(error: e.toString()));
        }
      },
    );
  }
}
