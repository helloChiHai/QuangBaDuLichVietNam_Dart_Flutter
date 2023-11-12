import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/addTouristAttractionToFavoritesList/bloc/addTouristToList_event.dart';
import 'package:userappquanbadulich/addTouristAttractionToFavoritesList/bloc/addTouristToList_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class AddAndRemoveTouristListBloc
    extends Bloc<AddAndRemoveTouristListEvent, AddAndRemoveTouristListState> {
  final UserRepository userRepository;

  AddAndRemoveTouristListBloc({required this.userRepository})
      : super(AddTouristToListInitial()) {
    on<CheckTouristInList>((event, emit) async {
      try {
        final result =
            await userRepository.checkTouristAttractionInFavouriteList(
                event.idCus, event.idTourist);
        if (result) {
          emit(CheckTouristInListSuccess(result: true));
        } else {
          emit(CheckTouristInListSuccess(result: false));
        }
      } catch (e) {
        emit(AddTouristToListFailure(error: e.toString()));
      }
    });
    on<AddTouristToListButtonPressed>((event, emit) async {
      try {
        final result = await userRepository.addTouristAttractionToFavouriteList(
            event.idCus, event.idTourist);
        // ignore: unnecessary_null_comparison
        if (result != null) {
          emit(AddTouristToListSuccess(customer: result));
        } else {
          emit(AddTouristToListFailure(error: 'Thêm thành công'));
        }
      } catch (e) {
        emit(AddTouristToListFailure(error: e.toString()));
      }
    });
    on<RemoveTouristFromListButtonPressed>((event, emit) async {
      try {
        final result =
            await userRepository.removeTouristAttractionFromFavouriteList(
                event.idCus, event.idTourist);
        // ignore: unnecessary_null_comparison
        if (result != null) {
          emit(AddTouristToListSuccess(customer: result));
        } else {
          emit(AddTouristToListFailure(error: 'Xóa thành công'));
        }
      } catch (e) {
        emit(AddTouristToListFailure(error: e.toString()));
      }
    });
  }
}
