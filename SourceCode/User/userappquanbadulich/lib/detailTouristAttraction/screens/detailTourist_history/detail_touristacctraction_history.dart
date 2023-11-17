import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_event.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_state.dart';
import 'package:userappquanbadulich/model/historyModel.dart';

import '../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_bloc.dart';
import '../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_event.dart';
import '../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_state.dart';
import '../../../model/touristAttractionModel.dart';
import '../../widgets/detail_touristAttraction_about_widget.dart';

class DetailTouristAttraction_History extends StatefulWidget {
  const DetailTouristAttraction_History({super.key});

  @override
  State<DetailTouristAttraction_History> createState() =>
      _DetailTouristAttraction_HistoryState();
}

class _DetailTouristAttraction_HistoryState
    extends State<DetailTouristAttraction_History> {
  late HistoryModel history;
  String? idCus;
  bool isCheckVisibility = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      history = arguments['HistoryData'];
      idCus = arguments['idCus'];
      context
          .read<DetailTourist_HistoryBloc>()
          .add(getTouristWithHistory(idHistoryStory: history.idHistoryStory));
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
      body: BlocBuilder<DetailTourist_HistoryBloc, DetailTourist_HistoryState>(
        builder: (context, state) {
          if (state is DetailTourist_HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTourist_HistoryLoaded) {
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
                      pageViewInit: 2,
                    );
                  } else if (state is CheckTouristInListFailure) {
                    return Text(state.error);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            }
          } else if (state is DetailTourist_HistoryFailure) {
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
