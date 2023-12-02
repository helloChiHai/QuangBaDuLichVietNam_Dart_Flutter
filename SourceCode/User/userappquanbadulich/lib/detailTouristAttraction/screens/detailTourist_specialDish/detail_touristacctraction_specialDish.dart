import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_event.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_state.dart';
import 'package:userappquanbadulich/model/specialtyDishModel.dart';

import '../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_bloc.dart';
import '../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_event.dart';
import '../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_state.dart';
import '../../../model/touristAttractionModel.dart';
import '../../widgets/detail_touristAttraction_about_widget.dart';

class DetailTouristAttraction_SpecialDish extends StatefulWidget {
  final SpecialtyDishModel specialDish;
  final String idCus;
  const DetailTouristAttraction_SpecialDish(
      {Key? key, required this.specialDish, required this.idCus})
      : super(key: key);

  @override
  State<DetailTouristAttraction_SpecialDish> createState() =>
      _DetailTouristAttraction_SpecialDishState();
}

class _DetailTouristAttraction_SpecialDishState
    extends State<DetailTouristAttraction_SpecialDish> {
  late SpecialtyDishModel specialDish;
  String? idCus;
  bool isCheckVisibility = false;

  @override
  void initState() {
    super.initState();
    specialDish = widget.specialDish;
    idCus = widget.idCus;
    context
        .read<DetailTourist_SpecialDishBloc>()
        .add(getTouristWithSpecialDish(idDish: specialDish.idDish));
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final Map<String, dynamic> arguments =
    //       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //   specialDish = arguments['specialDishData'];
    //   idCus = arguments['idCus'];
    //   context
    //       .read<DetailTourist_SpecialDishBloc>()
    //       .add(getTouristWithSpecialDish(idDish: specialDish.idDish));
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTourist_SpecialDishBloc,
          DetailTourist_SpecialDishState>(
        builder: (context, state) {
          if (state is DetailTourist_SpecialDishLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTourist_SpecialDishLoaded) {
            final tourist = state.touristAttraction;
            if (tourist != null && idCus != null) {
              return BlocBuilder<AddAndRemoveTouristListBloc,
                  AddAndRemoveTouristListState>(
                builder: (context, state) {
                  context.read<AddAndRemoveTouristListBloc>().add(
                      CheckTouristInList(
                          idCus: idCus!, idTourist: tourist.idTourist));
                  if (state is CheckTouristInListSuccess) {
                    bool isCheckFavourite = state.result;
                    TouristAttractionModel touristData = tourist;
                    return DetailTouristAttractionWidget(
                      isCheckFavourite: isCheckFavourite,
                      tourist: touristData,
                      isCheckVisibility: isCheckVisibility,
                      idCustomer: idCus!,
                      pageViewInit: 3,
                    );
                  } else if (state is CheckTouristInListFailure) {
                    return Text(state.error);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            }
          } else if (state is DetailTourist_SpecialDishFailure) {
            return Center(
              child: Text('Đã xảy ra lỗi: ${state.error}'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
