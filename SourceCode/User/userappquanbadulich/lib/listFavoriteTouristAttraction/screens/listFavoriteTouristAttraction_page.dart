import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_byIdTourist_about/screens/detail_touristAttraction_about_page.dart';

import '../../addTouristAttractionToFavoritesList/bloc/addTouristToList_bloc.dart';
import '../../addTouristAttractionToFavoritesList/bloc/addTouristToList_event.dart';
import '../../addTouristAttractionToFavoritesList/bloc/addTouristToList_state.dart';
import '../bloc/getTouristInFavoriteList_bloc.dart';
import '../bloc/getTouristInFavoriteList_event.dart';
import '../bloc/getTouristInFavoriteList_state.dart';

class ListFavoriteTouristAttractionPage extends StatefulWidget {
  ListFavoriteTouristAttractionPage({Key? key}) : super(key: key);

  @override
  State<ListFavoriteTouristAttractionPage> createState() =>
      _ListFavoriteTouristAttractionPageState();
}

class _ListFavoriteTouristAttractionPageState
    extends State<ListFavoriteTouristAttractionPage> {
  // Tạo key cho ListView
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  String? idCus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      idCus = arguments['idCus'];
      if (idCus != null) {
        context.read<GetTouristInFavoriteListBloc>().add(
              FetchTouristAttractionInFavoriteList(
                idCus: idCus!,
              ),
            );
      }
    });
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
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Danh sách địa điểm yêu thích',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<GetTouristInFavoriteListBloc,
          GetTouristInFavoriteListState>(
        builder: (context, state) {
          if (state is GetTouristInFavoriteListLoaded) {
            final touristList = state.touristAttractions;
            return touristList.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          key: _listKey,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: touristList.length,
                          itemBuilder: (context, index) {
                            final touristAttraction = touristList[index];
                            return GestureDetector(
                              onTap: () {
                                // Navigator.of(context).pushNamed(
                                //     '/detail_touriestAttraction_about',
                                //     arguments: {
                                //       'aboutTouristData': touristAttraction,
                                //       'idCus': idCus,
                                //     });

                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailTouristAttraction_AboutPage(
                                          touristAttraction: touristAttraction,
                                          idCus: idCus!),
                                ));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                            color:
                                                Color.fromARGB(255, 98, 98, 98),
                                            width: 0.7,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 110,
                                            height: 110,
                                            child: FutureBuilder<Widget>(
                                              future: _buildImage(
                                                  touristAttraction.imgTourist),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Widget>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return snapshot.data ??
                                                      Container();
                                                } else {
                                                  return const CircularProgressIndicator();
                                                }
                                              },
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 110,
                                          //   height: 110,
                                          //   child: ClipRRect(
                                          //     borderRadius:
                                          //         BorderRadius.circular(10),
                                          //     child: Image(
                                          //       image: AssetImage(
                                          //           'assets/img/${touristAttraction.imgTourist}'),
                                          //       width: 110,
                                          //       height: 110,
                                          //       fit: BoxFit.fill,
                                          //     ),
                                          //   ),
                                          // ),
                                          Container(
                                            width: 240,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            decoration: const BoxDecoration(
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  touristAttraction.nameTourist,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Địa chỉ: ${touristAttraction.address}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            BlocBuilder<
                                                AddAndRemoveTouristListBloc,
                                                AddAndRemoveTouristListState>(
                                              builder: (context, state) {
                                                if (state
                                                    is RemoveTouristFromListSuccess) {
                                                  print('Xóa thành công');
                                                  if (idCus != null) {
                                                    context
                                                        .read<
                                                            GetTouristInFavoriteListBloc>()
                                                        .add(
                                                          FetchTouristAttractionInFavoriteList(
                                                            idCus: idCus!,
                                                          ),
                                                        );
                                                  }

                                                  _listKey.currentState
                                                      ?.removeItem(
                                                    index,
                                                    (context, animation) =>
                                                        Container(),
                                                    duration: const Duration(
                                                        seconds: 1),
                                                  );
                                                } else if (state
                                                    is RemoveTouristFromListFailure) {
                                                  print(
                                                      'Xóa thất bại: ${state.error}');
                                                }

                                                return IconButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                AddAndRemoveTouristListBloc>(
                                                            context)
                                                        .add(
                                                      RemoveTouristFromListButtonPressed(
                                                        idCus: idCus!,
                                                        idTourist:
                                                            touristAttraction
                                                                .idTourist,
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.favorite,
                                                    size: 30,
                                                    color: Colors.red,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
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
            print(idCus);
            return const Text('Lỗi');
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
