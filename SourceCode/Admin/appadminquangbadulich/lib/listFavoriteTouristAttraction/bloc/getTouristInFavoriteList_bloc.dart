import 'package:appadminquangbadulich/listFavoriteTouristAttraction/bloc/getTouristInFavoriteList_event.dart';
import 'package:appadminquangbadulich/listFavoriteTouristAttraction/bloc/getTouristInFavoriteList_state.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';

class GetTouristInFavoriteListBloc
    extends Bloc<GetTouristInFavoriteListEvent, GetTouristInFavoriteListState> {
  final AdminRepository adminRepository;
  GetTouristInFavoriteListBloc({required this.adminRepository})
      : super(GetTouristInFavoriteListInitial()) {
    on(<FetchTouristAttractionInFavoriteList>(event, emit) async {
      try {
        emit(GetTouristInFavoriteListLoading());
        final touristAttraction =
            await adminRepository.getTouristInFavoritelistByIdCus(event.idCus);
        emit(GetTouristInFavoriteListLoaded(
            touristAttractions: touristAttraction));
      } catch (e) {
        emit(GetTouristInFavoriteListFailure(error: e.toString()));
      }
    });
  }
}
