import 'package:appquangbadulich/history/bloc/history_bloc.dart';
import 'package:appquangbadulich/history/bloc/history_event.dart';
import 'package:appquangbadulich/history/bloc/history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
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
                    print(history.idHistoryStory);
                    Navigator.of(context).pushNamed(
                        '/detail_touriestAttraction_history',
                        arguments: {'HistoryData': history});
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
                          child: Text(
                            history.titleStoryStory,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
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
