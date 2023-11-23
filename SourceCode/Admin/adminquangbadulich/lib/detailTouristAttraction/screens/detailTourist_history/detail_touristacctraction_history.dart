import 'package:adminquangbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_bloc.dart';
import 'package:adminquangbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_event.dart';
import 'package:adminquangbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_state.dart';
import 'package:adminquangbadulich/model/historyModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool isCheckVisibility = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      history = arguments['HistoryData'];
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
            if (tourist != null) {
              return DetailTouristAttractionWidget(
                tourist: tourist,
                pageViewInit: 2,
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
