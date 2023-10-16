import 'package:appquangbadulich/hotel/bloc/hotel_event.dart';
import 'package:appquangbadulich/hotel/bloc/hotel_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final UserRepository hotelRepository;

  HotelBloc(this.hotelRepository) : super(HotelLoadingState()) {
    on<LoadHotelEvent>((event, emit) async {
      emit(HotelLoadingState());
      try {
        // final hotels = await hotelRepository.getHotels();
        // emit(HotelLoadedState(hotels));
      } catch (e) {
        emit(HotelErrorState(e.toString()));
      }
    });
  }
}
