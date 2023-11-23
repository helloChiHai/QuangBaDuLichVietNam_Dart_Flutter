
import 'package:adminquangbadulich/addTouristAttraction/bloc/addTouristAttraction_event.dart';
import 'package:adminquangbadulich/addTouristAttraction/bloc/addTouristAttraction_state.dart';
import 'package:adminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';

class AddTouristAttractionBloc
    extends Bloc<AddTouristAttractionEvent, AddTouristAttractionState> {
  final AdminRepository adminRepository;
  AddTouristAttractionBloc({required this.adminRepository})
      : super(AddTouristAttractionInitial()) {
    on<AddTouristAttractionButtonPressed>((event, emit) async {
      emit(AddTouristAttractionLoading());
      try {
        final result = await adminRepository.addTouristAttraction(
          event.idRegion,
          event.idProvines,
          event.nameTourist,
          event.typeTourist,
          event.address,
          event.ticket,
          event.imgTourist,
          event.touristIntroduction,
          event.rightTime,
          event.titleStoryStory,
          event.contentStoryStory,
          event.avatarHistory,
          event.imgHistory,
          event.videoHistory,
          event.titleCulture,
          event.contentCulture,
          event.imgCulture,
          event.videoCulture,
          event.nameDish,
          event.addressDish,
          event.imgDish,
          event.dishIntroduction,
          event.comment,
        );
        if (result == 1) {
          emit(AddTouristAttractionSuccess());
        } else {
          emit(
            AddTouristAttractionFailure(
                error: 'Thêm địa điểm du lịch thất bại'),
          );
        }
      } catch (e) {
        emit(AddTouristAttractionFailure(error: e.toString()));
      }
    });
  }
}
