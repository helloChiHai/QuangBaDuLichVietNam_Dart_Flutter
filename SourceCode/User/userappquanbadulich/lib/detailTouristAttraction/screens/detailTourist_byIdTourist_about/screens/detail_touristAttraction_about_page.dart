import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_event.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_state.dart';
import 'package:userappquanbadulich/model/touristAttractionModel.dart';

import '../../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_bloc.dart';
import '../../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_event.dart';
import '../../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_state.dart';
import '../../../widgets/detail_touristAttraction_about_widget.dart';

class DetailTouristAttraction_AboutPage extends StatefulWidget {
  const DetailTouristAttraction_AboutPage({Key? key}) : super(key: key);

  @override
  State<DetailTouristAttraction_AboutPage> createState() =>
      _DetailTouristAttraction_AboutPageState();
}

class _DetailTouristAttraction_AboutPageState
    extends State<DetailTouristAttraction_AboutPage> {
  late TouristAttractionModel touristAttraction;
  String? idCus;
  bool isCheckVisibility = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      touristAttraction = arguments['aboutTouristData'];
      idCus = arguments['idCus'];
      context
          .read<DetailTourist_AboutBloc>()
          .add(getTouristWithIdTourist(idTourist: touristAttraction.idTourist));
    });
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
      body: BlocBuilder<DetailTourist_AboutBloc, DetailTourist_AboutState>(
        builder: (context, state) {
          if (state is DetailTourist_AboutLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTourist_AboutLoaded) {
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
                    print(state.result);
                    return DetailTouristAttractionWidget(
                      isCheckFavourite: isCheckFavourite,
                      tourist: touristData,
                      isCheckVisibility: isCheckVisibility,
                      idCustomer: idCus!,
                      pageViewInit: 0,
                    );
                  } else if (state is CheckTouristInListFailure) {
                    return Text(state.error);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            }
          } else if (state is DetailTourist_AboutFailure) {
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
