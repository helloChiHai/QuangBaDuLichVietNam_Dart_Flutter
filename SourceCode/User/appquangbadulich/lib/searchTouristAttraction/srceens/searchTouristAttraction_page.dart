import 'dart:ui';

import 'package:appquangbadulich/touristAttraction/bloc/touristAttraction_bloc.dart';
import 'package:appquangbadulich/touristAttraction/bloc/touristAttraction_event.dart';
import 'package:appquangbadulich/touristAttraction/bloc/touristAttraction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTouristAttractionPage extends StatefulWidget {
  const SearchTouristAttractionPage({super.key});

  @override
  State<SearchTouristAttractionPage> createState() =>
      _SearchTouristAttractionPageState();
}

class _SearchTouristAttractionPageState
    extends State<SearchTouristAttractionPage> {
  TextEditingController textSearchTouristAttraction = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TouristAttractionBloc>().add(FetchTouristAttraction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        Navigator.of(context).pushNamed('/home');
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
                                        });
                                      },
                                    )
                                  : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // gợi ý các địa điểm trong tháng
            BlocBuilder<TouristAttractionBloc, TouristAttractionState>(
              builder: (context, state) {
                if (state is TouristAttractionLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TouristAttractionLoaded) {
                  final touristAttractions = state.touristAttraction;
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
                        const Text(
                          "Đây là thời điểm thích hợp để đến:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 10.0, // Khoảng cách giữa các mục
                          runSpacing: 10.0, // Khoảng cách giữa các dòng
                          children: touristAttractions
                              .map(
                                (touristAttraction) => GestureDetector(
                                  onTap: () {
                                    print(touristAttraction.idTourist);
                                    Navigator.of(context).pushNamed(
                                        '/detail_touriestAttraction_about',
                                        arguments: {
                                          'aboutTouristData': touristAttraction,
                                        });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.grey[300]),
                                    child: Text(
                                      touristAttraction.nameTourist,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 48, 48, 48),
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
