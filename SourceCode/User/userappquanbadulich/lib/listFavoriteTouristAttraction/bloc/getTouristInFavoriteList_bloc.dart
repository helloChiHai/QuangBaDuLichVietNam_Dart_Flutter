import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/listFavoriteTouristAttraction/bloc/getTouristInFavoriteList_event.dart';
import 'package:userappquanbadulich/listFavoriteTouristAttraction/bloc/getTouristInFavoriteList_state.dart';

import '../../repositories/repositories.dart';

class GetTouristInFavoriteListBloc extends Bloc<GetTouristInFavoriteListEvent, GetTouristInFavoriteListState> {
  final UserRepository userRepository;
  GetTouristInFavoriteListBloc({required this.userRepository})
      : super(GetTouristInFavoriteListInitial()) {
    on(<FetchTouristAttractionInFavoriteList>(event, emit) async {
      try {
        emit(GetTouristInFavoriteListLoading());
        final touristAttraction = await userRepository.getTouristInFavoritelistByIdCus(event.idCus);
        emit(GetTouristInFavoriteListLoaded(touristAttractions: touristAttraction));
      } catch (e) {
        emit(GetTouristInFavoriteListFailure(error: e.toString()));
      }
    });
  }
}
