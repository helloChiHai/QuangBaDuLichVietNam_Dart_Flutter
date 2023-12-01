import 'dart:convert';
import 'dart:typed_data';

import 'package:appadminquangbadulich/detailTouristAttraction/screens/detailTourist_byIdTourist_about/screens/detail_touristAttraction_about_page.dart';
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

  Future<Widget> _buildImageTourist(String? img) async {
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
            'assets/img/$img',
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
                    color: const Color.fromARGB(255, 172, 212, 245),
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
                    if (state is GetTouristInFavoriteListLoaded) {
                      final touristList = state.touristAttractions;

                      return touristList.isNotEmpty
                          ? Column(
                              children: [
                                ListView.builder(
                                  // Sử dụng key
                                  key: _listKey,
                                  scrollDirection: Axis.vertical,
                                  itemCount: touristList.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final touristAttraction =
                                        touristList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              DetailTouristAttraction_AboutPage(
                                            idTourist:
                                                touristAttraction.idTourist,
                                          ),
                                        ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                    child:
                                                        FutureBuilder<Widget>(
                                                      future:
                                                          _buildImageTourist(
                                                              touristAttraction
                                                                  .imgTourist),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<Widget>
                                                              snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          return snapshot
                                                                  .data ??
                                                              Container();
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      },
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
                                                          style:
                                                              const TextStyle(
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
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontStyle: FontStyle
                                                                .italic,
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
                                )
                              ],
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 50,
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'assets/img/img_22.png',
                                    ),
                                    height: 150,
                                    width: 150,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Không có địa điểm được lưu',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
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
