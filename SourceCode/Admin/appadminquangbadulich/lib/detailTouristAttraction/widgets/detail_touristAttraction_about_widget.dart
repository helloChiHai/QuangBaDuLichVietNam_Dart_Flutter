import 'dart:convert';
import 'dart:typed_data';

import 'package:appadminquangbadulich/comment/screens/comment_page.dart';
import 'package:appadminquangbadulich/deleteTouristAttraction/bloc/deleteTouristAttraction_bloc.dart';
import 'package:appadminquangbadulich/deleteTouristAttraction/bloc/deleteTouristAttraction_event.dart';
import 'package:appadminquangbadulich/deleteTouristAttraction/bloc/deleteTouristAttraction_state.dart';
import 'package:appadminquangbadulich/model/touristAttractionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/detailTourist_content.dart';
import '../screens/detailTourist_culture.dart';
import '../screens/detailTourist_history.dart';
import '../screens/detailTourist_specialtyDish.dart';

class DetailTouristAttractionWidget extends StatefulWidget {
  final TouristAttractionModel tourist;
  final int pageViewInit;
  const DetailTouristAttractionWidget({
    Key? key,
    required this.tourist,
    required this.pageViewInit,
  }) : super(key: key);

  @override
  State<DetailTouristAttractionWidget> createState() =>
      _DetailTouristAttractionWidgetState();
}

class _DetailTouristAttractionWidgetState
    extends State<DetailTouristAttractionWidget> {
  late TouristAttractionModel tourist;
  PageController pageController = PageController();
  late int pageViewInit = 0;

  @override
  void initState() {
    super.initState();
    tourist = widget.tourist;
    pageViewInit = widget.pageViewInit;
    pageController = PageController(initialPage: pageViewInit);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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

  String selectedOption = 'capNhat';

  void _onItemSelected(String value) {
    setState(() {
      selectedOption = value;
      switch (selectedOption) {
        case 'capNhat':
          Navigator.of(context, rootNavigator: true).pushNamed(
            '/updateTouristAttractionPage',
            arguments: {'aboutTouristData': tourist},
          );
          break;
        case 'xoa':
          context.read<DeleteTouristAttractionBloc>().add(
                DeleteTouristAttractionButtonPress(
                  touristId: tourist.idTourist,
                ),
              );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 310,
                color: const Color.fromARGB(255, 173, 207, 235),
                child: Stack(
                  children: [
                    FutureBuilder<Widget>(
                      future: _buildImage(tourist.imgTourist),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return snapshot.data ?? Container();
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 31),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/homeAdmin');
                              },
                              icon: const Icon(Icons.arrow_back, size: 30),
                            ),
                          ),
                          BlocListener<DeleteTouristAttractionBloc,
                              DeleteTouristAttractionState>(
                            listener: (context, state) {
                              if (state is DeleteTouristAttractionSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Xóa địa điểm thành công',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.of(context).pushNamed('/homeAdmin');
                                });
                              } else if (state
                                  is DeleteTouristAttractionFailure) {
                                print(state.error);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Xóa địa điểm thất bại: ${state.error}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showMenu(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    position: RelativeRect.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.9,
                                        40,
                                        60,
                                        100),
                                    items: const [
                                      PopupMenuItem<String>(
                                        value: 'capNhat',
                                        child: Text(
                                          'Cập nhật',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'xoa',
                                        child: Text(
                                          'Xóa',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ).then((value) {
                                    if (value != null) {
                                      _onItemSelected(value);
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 290),
                padding: const EdgeInsets.symmetric(vertical: 25),
                width: double.infinity,
                height: 3000,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tourist.nameTourist,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.place_outlined, size: 25),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    tourist.address,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.monetization_on_outlined,
                                    size: 25),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    'Giá vé: ${tourist.ticket}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.calendar_month_outlined,
                                    size: 25),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    'Thời điểm thích hợp: ${tourist.rightTime.join(', ')}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      color: Colors.white,
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Giới thiệu',
                                  style: TextStyle(
                                    color: pageViewInit == 0
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 0 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Văn hóa',
                                  style: TextStyle(
                                    color: pageViewInit == 1
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 1 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Lịch sử',
                                  style: TextStyle(
                                    color: pageViewInit == 2
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 2 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    3,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Đặc sản',
                                  style: TextStyle(
                                    color: pageViewInit == 3
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 3 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    4,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Bình luận',
                                  style: TextStyle(
                                    color: pageViewInit == 4
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 4 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            pageViewInit = index;
                          });
                        },
                        children: [
                          DetailContent(
                            dataIntroTourist: tourist.touristIntroduction,
                          ),
                          DetailCulture(dataCulture: tourist.culture),
                          DetailHistory(dataHistory: tourist.history),
                          DetailSpecialtyDish(
                              dataSpecialtyDish: tourist.specialtyDish),
                          CommentPage(idTourist: tourist.idTourist),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // showMenu(
  //   context: context,
  //   position: menuPosition,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(10),
  //   ),
  //   items: [
  //     PopupMenuItem(
  //       child: const ListTile(
  //         leading: Icon(
  //           Icons.edit,
  //           size: 30,
  //         ),
  //         title: Text(
  //           'Cập nhật',
  //           style: TextStyle(
  //             fontSize: 20,
  //             color: Colors.black,
  //           ),
  //         ),
  //       ),
  //       onTap: () {
  //         print('onTap called');
  //         Navigator.of(context, rootNavigator: true).pushNamed(
  //           '/updateTouristAttractionPage',
  //           arguments: {'aboutTouristData': tourist},
  //         );
  //       },
  //     ),
  //     PopupMenuItem(
  //       child: BlocListener<DeleteTouristAttractionBloc,
  //           DeleteTouristAttractionState>(
  //         listener: (context, state) {
  //           if (state is DeleteTouristAttractionSuccess) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(
  //                 content: Text(
  //                   'Xóa địa điểm thành công',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //                 backgroundColor: Colors.green,
  //               ),
  //             );
  //             Future.delayed(const Duration(seconds: 1), () {
  //               Navigator.of(context).pushNamed('/homeAdmin');
  //             });
  //           } else if (state is DeleteTouristAttractionFailure) {
  //             print(state.error);
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text(
  //                   'Xóa địa điểm thất bại: ${state.error}',
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //                 backgroundColor: Colors.red,
  //               ),
  //             );
  //           }
  //         },
  //         child: GestureDetector(
  //           onTap: () {
  //             context.read<DeleteTouristAttractionBloc>().add(
  //                   DeleteTouristAttractionButtonPress(
  //                     touristId: tourist.idTourist,
  //                   ),
  //                 );
  //           },
  //           child: const ListTile(
  //             leading: Icon(
  //               Icons.delete,
  //               size: 30,
  //             ),
  //             title: Text(
  //               'Xóa',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   ],
  // );
}
