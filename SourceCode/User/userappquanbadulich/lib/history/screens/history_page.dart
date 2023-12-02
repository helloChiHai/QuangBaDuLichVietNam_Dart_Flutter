import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_history/detail_touristacctraction_history.dart';

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

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            Uint8List.fromList(imageBytes),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      } catch (e) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/img/${img}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      }
    } else {
      return const SizedBox();
    }
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
              itemCount: min(3, historyList.length),
              itemBuilder: (context, index) {
                final history = historyList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushNamed(
                    //     '/detail_touriestAttraction_history',
                    //     arguments: {
                    //       'HistoryData': history,
                    //       'idCus': idCus,
                    //     });

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailTouristAttraction_History(
                            history: history, idCus: idCus),
                      ),
                    );
                  },
                  child: Container(
                    width: 180,
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        FutureBuilder<Widget>(
                          future: _buildImage(history.imgHistory),
                          builder: (BuildContext context,
                              AsyncSnapshot<Widget> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return snapshot.data ?? Container();
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
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

  @override
  void dispose() {
    super.dispose();
  }
}
