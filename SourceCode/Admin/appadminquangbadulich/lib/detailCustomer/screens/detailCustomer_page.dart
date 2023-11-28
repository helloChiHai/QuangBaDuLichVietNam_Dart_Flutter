import 'dart:convert';
import 'dart:typed_data';

import 'package:appadminquangbadulich/listFavoriteTouristAttraction/bloc/getTouristInFavoriteList_bloc.dart';
import 'package:appadminquangbadulich/listFavoriteTouristAttraction/bloc/getTouristInFavoriteList_event.dart';
import 'package:appadminquangbadulich/listFavoriteTouristAttraction/bloc/getTouristInFavoriteList_state.dart';
import 'package:appadminquangbadulich/model/CustomerModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCustomerPage extends StatefulWidget {
  const DetailCustomerPage({Key? key}) : super(key: key);

  @override
  State<DetailCustomerPage> createState() => _DetailCustomerPageState();
}

class _DetailCustomerPageState extends State<DetailCustomerPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late CustomerModel cus;
  double imageSize = 130;
  bool isProfileVisible = false;
  bool isSaveTourVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cus = arguments['aboutUserData'];

    context.read<GetTouristInFavoriteListBloc>().add(
          FetchTouristAttractionInFavoriteList(
            idCus: cus.idCus,
          ),
        );
  }

  Future<Widget> _buildImage(String? imgCus) async {
    if (imgCus != null && imgCus.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(imgCus);
        return Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.memory(
                Uint8List.fromList(imageBytes),
                fit: BoxFit.cover,
              ).image,
            ),
          ),
        );
      } catch (e) {
        return Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/img/$imgCus'),
            ),
          ),
        );
      }
    } else {
      return Container(
        width: imageSize,
        height: imageSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/img_12.png'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Hồ sơ người dùng',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 309,
                    color: Colors.blue,
                  ),
                  Positioned(
                    top: 190,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 125,
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                    child: Column(
                      children: [
                        Container(
                          width: 130,
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(65.0),
                              topLeft: Radius.circular(65.0),
                            ),
                          ),
                          child: FutureBuilder<Widget>(
                            future: _buildImage(cus.imgCus),
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
                        Text(
                          cus.name,
                          style: const TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isProfileVisible = true;
                            isSaveTourVisible = false;
                          });
                          print('isProfileVisible: $isProfileVisible');
                          print('isSaveTourVisible: $isSaveTourVisible');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Image(
                                  image: AssetImage(
                                    'assets/img/icon_profile.png',
                                  ),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Chi tiết hồ sơ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSaveTourVisible = true;
                            isProfileVisible = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Image(
                                  image: AssetImage(
                                    'assets/img/icon_box.png',
                                  ),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Đ.Điểm đã lưu',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: isProfileVisible,
                child: Container(
                  width: double.infinity,
                  height: 500,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Họ tên:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cus.name,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Email:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cus.email,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Địa chỉ:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cus.address!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Ngày sinh:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cus.birthday!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isSaveTourVisible,
                child: BlocBuilder<GetTouristInFavoriteListBloc,
                    GetTouristInFavoriteListState>(
                  builder: (context, state) {
                    // if (state is GetTouristInFavoriteListInitial) {
                    //   if (idCus != null) {
                    //     context.read<GetTouristInFavoriteListBloc>().add(
                    //           FetchTouristAttractionInFavoriteList(
                    //             idCus: idCus!,
                    //           ),
                    //         );
                    //   }
                    // }

                    if (state is GetTouristInFavoriteListLoaded) {
                      final touristList = state.touristAttractions;

                      return touristList.isNotEmpty
                          ? SizedBox(
                              width: double.infinity,
                              height: 500,
                              child: ListView.builder(
                                // Sử dụng key
                                key: _listKey,
                                scrollDirection: Axis.vertical,
                                itemCount: touristList.length,
                                itemBuilder: (context, index) {
                                  final touristAttraction = touristList[index];
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 10,
                                            ),
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 98, 98, 98),
                                                  width: 0.7,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 110,
                                                  height: 110,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image(
                                                      image: AssetImage(
                                                          'assets/img/${touristAttraction.imgTourist}'),
                                                      width: 110,
                                                      height: 110,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 240,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 5,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 98, 98, 98),
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        touristAttraction
                                                            .nameTourist,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Địa chỉ: ${touristAttraction.address}',
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 50,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      'assets/img/img_22.png',
                                    ),
                                    height: 150,
                                    width: 150,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Địa điểm thích yêu',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Chỉ cần nhấn vào biểu tượng trái tim ở trên cùng mỗi trang địa điểm du lịch, địa điểm du lịch bạn lưu sẽ xuất hiện tại đây.',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed('/home');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 25,
                                        vertical: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        'Lưu địa điểm',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    } else if (state is GetTouristInFavoriteListFailure) {
                      print(state.error);
                      return const Text('Lỗi');
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
