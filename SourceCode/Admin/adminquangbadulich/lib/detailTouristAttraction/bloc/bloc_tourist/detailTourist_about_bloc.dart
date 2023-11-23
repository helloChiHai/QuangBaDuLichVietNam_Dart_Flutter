import 'package:adminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_event.dart';
import 'package:adminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_state.dart';
import 'package:adminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';
class DetailTourist_AboutBloc
    extends Bloc<DetailTourist_AboutEvent, DetailTourist_AboutState> {
  final AdminRepository adminRepository;
  DetailTourist_AboutBloc({required this.adminRepository})
      : super(DetailTourist_AboutInitial()) {
    on<getTouristWithIdTourist>(
      (event, emit) async {
        emit(DetailTourist_AboutLoading());
        try {
          final tourist = await adminRepository
              .getDetailTouristWithIdTourist(event.idTourist);
          if (tourist != null) {
            emit(DetailTourist_AboutLoaded(touristAttraction: tourist));
          } else {
            DetailTourist_AboutFailure(error: 'bị lỗi');
          }
        } catch (e) {
          emit(DetailTourist_AboutFailure(error: e.toString()));
        }
      },
    );
  }
}
