import 'dart:convert';
import 'dart:typed_data';

import 'package:appadminquangbadulich/model/touristAttractionModel.dart';
import 'package:appadminquangbadulich/touristAttraction/bloc/touristAttraction_bloc.dart';
import 'package:appadminquangbadulich/touristAttraction/bloc/touristAttraction_event.dart';
import 'package:appadminquangbadulich/touristAttraction/bloc/touristAttraction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTouristAttractionPage extends StatefulWidget {
  const SearchTouristAttractionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchTouristAttractionPage> createState() =>
      _SearchTouristAttractionPageState();
}

class _SearchTouristAttractionPageState
    extends State<SearchTouristAttractionPage> {
  TextEditingController textSearchTouristAttraction = TextEditingController();
  List<TouristAttractionModel> filteredTouristAttractions = [];

  @override
  void initState() {
    super.initState();
    context.read<TouristAttractionBloc>().add(FetchTouristAttraction());
  }

  void searchTouristAttractions(String nameTourist) {
    final touristAttractionState = context.read<TouristAttractionBloc>().state;

    if (touristAttractionState is TouristAttractionLoaded) {
      final allTouristAttractions = touristAttractionState.touristAttraction;

      setState(() {
        filteredTouristAttractions = allTouristAttractions
            .where((touristAttraction) => touristAttraction.nameTourist
                .toLowerCase()
                .contains(nameTourist.toLowerCase()))
            .toList();
      });
    }
  }

  List<int> extractNumberRightTime(List<String?> rightTime) {
    // ignore: non_constant_identifier_names
    List<int> ListRightTime = [];
    for (var item in rightTime) {
      if (item != null) {
        // Sử dụng biểu thức chính quy để tìm các số trong chuỗi
        RegExp regExp = RegExp(r'\d+');
        Iterable<Match> matches = regExp.allMatches(item);

        // Lặp qua các kết quả tìm thấy và chuyển chúng thành số nguyên
        for (var match in matches) {
          int number =
              int.parse(match.group(0)!); // Sử dụng ! để bỏ qua kiểm tra null
          ListRightTime.add(number);
        }
      }
    }
    return ListRightTime;
  }

  String getCurrentSeason() {
    final now = DateTime.now();
    final month = now.month;

    if (month >= 3 && month <= 5) {
      return 'Đông';
    } else if (month >= 6 && month <= 8) {
      return 'Hè';
    } else if (month >= 9 && month <= 11) {
      return 'Thu';
    } else {
      return 'Đông';
    }
  }

  List<TouristAttractionModel> filterTouristAttractionsBySeason(
      List<TouristAttractionModel> attractions, String currentSeason) {
    return attractions.where((attraction) {
      return extractNumberRightTime(attraction.rightTime).any((number) {
        if (currentSeason == 'Đông' && (number >= 12 || number <= 2)) {
          return true;
        } else if (currentSeason == 'Xuân' && (number >= 3 && number <= 5)) {
          return true;
        } else if (currentSeason == 'Hè' && (number >= 6 && number <= 8)) {
          return true;
        } else if (currentSeason == 'Thu' && (number >= 9 && number <= 11)) {
          return true;
        } else {
          return false;
        }
      });
    }).toList();
  }

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.memory(
            Uint8List.fromList(imageBytes),
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
        );
      } catch (e) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/img/${img}',
            width: 90,
            height: 90,
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
    return Scaffold(
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            // nhập tìm kiếm
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    width: 0.3,
                    color: Colors.black,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/homeAdmin');
                      },
                      icon: const Icon(Icons.arrow_back, size: 30),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.white,
                      child: TextFormField(
                        controller: textSearchTouristAttraction,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Vui lòng nhập',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          suffixIcon:
                              textSearchTouristAttraction.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          textSearchTouristAttraction.clear();
                                          filteredTouristAttractions.clear();
                                        });
                                      },
                                    )
                                  : null,
                        ),
                        onChanged: (nameTourist) {
                          searchTouristAttractions(nameTourist);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            textSearchTouristAttraction.text.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: filteredTouristAttractions.length,
                      itemBuilder: (context, index) {
                        final touristAttraction =
                            filteredTouristAttractions[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                '/detail_touriestAttraction_about',
                                arguments: {
                                  'aboutTouristData': touristAttraction,
                                });
                          },
                          child: Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
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
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 7,
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          touristAttraction.nameTourist,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          touristAttraction.address,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                :
                // gợi ý các địa điểm trong tháng
                BlocBuilder<TouristAttractionBloc, TouristAttractionState>(
                    builder: (context, state) {
                      if (state is TouristAttractionLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TouristAttractionLoaded) {
                        final touristAttractions = state.touristAttraction;
                        final currentSeason = getCurrentSeason();
                        final filteredAttractions =
                            filterTouristAttractionsBySeason(
                                touristAttractions, currentSeason);

                        return Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mùa $currentSeason ời, đi đây chơi đi:",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                children: filteredAttractions
                                    .map((touristAttraction) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          '/detail_touriestAttraction_about',
                                          arguments: {
                                            'aboutTouristData':
                                                touristAttraction,
                                          });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey[300],
                                      ),
                                      child: Text(
                                        touristAttraction.nameTourist,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 48, 48, 48),
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
