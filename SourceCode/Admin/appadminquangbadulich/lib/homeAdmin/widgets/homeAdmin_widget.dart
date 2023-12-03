import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:appadminquangbadulich/totalTouristAttraction/bloc/totalTouristAttraction_bloc.dart';
import 'package:appadminquangbadulich/totalTouristAttraction/bloc/totalTouristAttraction_event.dart';
import 'package:appadminquangbadulich/totalTouristAttraction/bloc/totalTouristAttraction_state.dart';
import 'package:appadminquangbadulich/touristAttraction/bloc/touristAttraction_bloc.dart';
import 'package:appadminquangbadulich/touristAttraction/bloc/touristAttraction_event.dart';
import 'package:appadminquangbadulich/touristAttraction/bloc/touristAttraction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../detailTouristAttraction/screens/detailTourist_byIdTourist_about/screens/detail_touristAttraction_about_page.dart';

class HomeAdminWidget extends StatefulWidget {
  const HomeAdminWidget({super.key});

  @override
  State<HomeAdminWidget> createState() => _HomeAdminWidgetState();
}

class _HomeAdminWidgetState extends State<HomeAdminWidget> {
  @override
  void initState() {
    super.initState();

    context.read<TouristAttractionBloc>().add(FetchTouristAttraction());
    context.read<TotalTouristAttractionBloc>().add(ToTalTouristAttraction());
    print("hello");
  }

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return Image.memory(
          Uint8List.fromList(imageBytes),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      } catch (e) {
        return Image.asset(
          'assets/img/${img}',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      }
    } else {
      return Image.asset(
        'assets/img/img_12.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Địa điểm du lịch',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                BlocBuilder<TotalTouristAttractionBloc,
                    TotalTouristAttractionState>(
                  builder: (context, state) {
                    if (state is TotalTouristAttractionLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TotalTouristAttractionLoaded) {
                      final touristAttractions = state.totaltouristAttraction;
                      return Text(
                        'Tổng số địa điểm: $touristAttractions',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      );
                    } else if (state is TotalTouristAttractionFailure) {
                      return Text(
                        'Tổng số địa điểm: ${state.error}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/showAllTouristAttraction');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Danh sách các địa điểm',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        size: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<TouristAttractionBloc,
                      TouristAttractionState>(
                    builder: (context, state) {
                      if (state is TouristAttractionLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TouristAttractionLoaded) {
                        final touristAttractions = state.touristAttraction;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: min(4, touristAttractions.length),
                          itemBuilder: (context, index) {
                            final touristAttraction = touristAttractions[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailTouristAttraction_AboutPage(
                                            idTourist:
                                                touristAttraction.idTourist),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FutureBuilder<Widget>(
                                        future: _buildImage(
                                            touristAttraction.imgTourist),
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
                                        child: touristAttraction
                                                .nameTourist.isNotEmpty
                                            ? Text(
                                                touristAttraction.nameTourist,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                              )
                                            : Container(),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
