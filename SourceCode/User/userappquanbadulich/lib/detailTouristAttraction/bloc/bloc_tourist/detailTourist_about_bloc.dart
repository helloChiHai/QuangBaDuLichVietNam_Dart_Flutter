import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_event.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class DetailTourist_AboutBloc
    extends Bloc<DetailTourist_AboutEvent, DetailTourist_AboutState> {
  final UserRepository userRepository;
  DetailTourist_AboutBloc({required this.userRepository})
      : super(DetailTourist_AboutInitial()) {
    on<getTouristWithIdTourist>(
      (event, emit) async {
        emit(DetailTourist_AboutLoading());
        try {
          final tourist = await userRepository
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
