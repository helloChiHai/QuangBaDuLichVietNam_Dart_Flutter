import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';

class HistoryPage extends StatefulWidget {
  final String idCus;
  const HistoryPage({
    Key? key,
    required this.idCus,
  }) : super(key: key);

  @override
  State<HistoryPage> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  late String idCus;
  @override
  void initState() {
    super.initState();
    idCus = widget.idCus;
    context.read<HistoryBloc>().add(FetchHistory());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            final historyList = state.history;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final history = historyList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        '/detail_touriestAttraction_history',
                        arguments: {
                          'HistoryData': history,
                          'idCus': idCus,
                        });
                  },
                  child: Container(
                    width: 180,
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: history.avatarHistory != null &&
                                  history.avatarHistory!.isNotEmpty
                              ? Image.asset(
                                  'assets/img/${history.avatarHistory}',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/img/img_12.png',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.transparent,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              history.titleStoryStory,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
