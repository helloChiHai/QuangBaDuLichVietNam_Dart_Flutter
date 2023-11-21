import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_event.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_state.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';

class DetailTourist_CultureBloc
    extends Bloc<DetailTourist_CultureEvent, DetailTourist_CultureState> {
  final AdminRepository adminRepository;
  DetailTourist_CultureBloc({required this.adminRepository})
      : super(DetailTourist_CultureInitial()) {
    on<getTouristWithCulture>(
      (event, emit) async {
        emit(DetailTourist_CultureLoading());
        try {
          final tourist =
              await adminRepository.getTouristWithCulture(event.idCulture);
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
