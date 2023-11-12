import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_event.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_state.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_content.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_culture.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_history.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_specialtyDish.dart';
import 'package:userappquanbadulich/model/touristAttractionModel.dart';

import '../../../addTouristAttractionToFavoritesList/screens/addAndRemoveTourist_page.dart';
import '../../../imformationCustomer/bloc/imformationCus_bloc.dart';
import '../../../model/CustomerModel.dart';

class DetailTouristAttraction_About extends StatefulWidget {
  const DetailTouristAttraction_About({super.key});

  @override
  State<DetailTouristAttraction_About> createState() =>
      _DetailTouristAttraction_AboutState();
}

class _DetailTouristAttraction_AboutState
    extends State<DetailTouristAttraction_About> {
  late TouristAttractionModel touristAttraction;
  late int pageViewInit = 0;
  PageController pageController = PageController();
  bool isCheckFavourite = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      touristAttraction = arguments['aboutTouristData'];
      context
          .read<DetailTourist_AboutBloc>()
          .add(getTouristWithIdTourist(idTourist: touristAttraction.idTourist));
      pageController = PageController(initialPage: pageViewInit);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    pageController.dispose();
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 310,
                        color: Colors.red,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/img/${tourist?.imgTourist}',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 31),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/home');
                                      },
                                      icon: const Icon(Icons.arrow_back,
                                          size: 30),
                                    ),
                                  ),
                                  // BlocBuilder<CustomerBloc, CustomerModel?>(
                                  //     builder: (context, customer) {
                                  //   if (customer == null) {
                                  //     return const Text(
                                  //         'Chưa có thông tin khách hàng');
                                  //   } else {
                                  //     return AddAndRemoveTouristPage(
                                  //       isCheckFavourite: isCheckFavourite,
                                  //       idCus: customer.idCus,
                                  //       idTourist: tourist!.idTourist,
                                  //     );
                                  //   }
                                  // }),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isCheckFavourite = !isCheckFavourite;
                                        });
                                        print(isCheckFavourite);
                                      },
                                      icon: Icon(
                                        isCheckFavourite
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        size: 30,
                                        color: isCheckFavourite
                                            ? Colors.red
                                            : null,
                                      ),
                                    ),
                                  )
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
                        height: 1900,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tourist!.nameTourist,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.place_outlined,
                                            size: 25),
                                        Expanded(
                                          flex: 8,
                                          child: Text(
                                            tourist.address,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                            maxLines: 2,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                            Icons.monetization_on_outlined,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                            Icons.calendar_month_outlined,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      pageController.animateToPage(
                                        0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Text(
                                      'Giới thiệu',
                                      style: TextStyle(
                                        color: pageViewInit == 0
                                            ? Colors.black
                                            : const Color.fromARGB(
                                                255, 77, 76, 76),
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
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Text(
                                      'Văn hóa',
                                      style: TextStyle(
                                        color: pageViewInit == 1
                                            ? Colors.black
                                            : const Color.fromARGB(
                                                255, 77, 76, 76),
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
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Text(
                                      'Lịch sử',
                                      style: TextStyle(
                                        color: pageViewInit == 2
                                            ? Colors.black
                                            : const Color.fromARGB(
                                                255, 77, 76, 76),
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
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Text(
                                      'Đặc sản',
                                      style: TextStyle(
                                        color: pageViewInit == 3
                                            ? Colors.black
                                            : const Color.fromARGB(
                                                255, 77, 76, 76),
                                        fontSize: pageViewInit == 3 ? 25 : 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
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
                                    dataIntroTourist:
                                        tourist.touristIntroduction,
                                  ),
                                  DetailCulture(dataCulture: tourist.culture),
                                  DetailHistory(dataHistory: tourist.history),
                                  DetailSpecialtyDish(
                                      dataSpecialtyDish: tourist.specialtyDish),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
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
