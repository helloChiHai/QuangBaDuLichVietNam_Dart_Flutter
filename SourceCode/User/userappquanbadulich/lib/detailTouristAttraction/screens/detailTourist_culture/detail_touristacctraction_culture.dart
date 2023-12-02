import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_event.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_state.dart';

import '../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_bloc.dart';
import '../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_event.dart';
import '../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_state.dart';
import '../../../model/cultureModel.dart';
import '../../../model/touristAttractionModel.dart';
import '../../widgets/detail_touristAttraction_about_widget.dart';

class DetailTouristAttraction_Culture extends StatefulWidget {
  final CultureModel culture;
  final String idCus;
  const DetailTouristAttraction_Culture({
    Key? key,
    required this.culture,
    required this.idCus,
  });

  @override
  State<DetailTouristAttraction_Culture> createState() =>
      _DetailTouristAttraction_CultureState();
}

class _DetailTouristAttraction_CultureState
    extends State<DetailTouristAttraction_Culture> {
  late CultureModel culture;
  String? idCus;
  bool isCheckVisibility = false;

  @override
  void initState() {
    super.initState();
    culture = widget.culture;
    idCus = widget.idCus;
    context
        .read<DetailTourist_CultureBloc>()
        .add(getTouristWithCulture(idCulture: culture.idCulture));
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final Map<String, dynamic> arguments =
    //       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //   culture = arguments['cultureData'];
    //   idCus = arguments['idCus'];
    //   context
    //       .read<DetailTourist_CultureBloc>()
    //       .add(getTouristWithCulture(idCulture: culture.idCulture));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTourist_CultureBloc, DetailTourist_CultureState>(
        builder: (context, state) {
          if (state is DetailTourist_CultureLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTourist_CultureLoaded) {
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
                      pageViewInit: 1,
                    );
                  } else if (state is CheckTouristInListFailure) {
                    return Text(state.error);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            }
          } else if (state is DetailTourist_CultureFailure) {
            return Center(
              child: Text('Đã xảy ra lỗi: ${state.error}'),
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
