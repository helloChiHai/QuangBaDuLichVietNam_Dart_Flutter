import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_history/detail_touristacctraction_history.dart';
import 'package:userappquanbadulich/history/bloc/history_bloc.dart';
import 'package:userappquanbadulich/history/bloc/history_event.dart';
import 'package:userappquanbadulich/model/filterRegionModel.dart';
import 'package:userappquanbadulich/model/provinceModel.dart';
import 'package:userappquanbadulich/province/bloc/province_bloc.dart';
import 'package:userappquanbadulich/province/bloc/province_event.dart';
import 'package:userappquanbadulich/province/bloc/province_state.dart';

import '../../history/bloc/history_state.dart';
import '../bloc/filterHistory_bloc.dart';
import '../bloc/filterHistory_event.dart';
import '../bloc/filterHistory_state.dart';

class ShowAllHistory extends StatefulWidget {
  final String idCus;

  const ShowAllHistory({
    Key? key,
    required this.idCus,
  }) : super(key: key);

  @override
  State<ShowAllHistory> createState() => _ShowAllTourisCulure();
}

class _ShowAllTourisCulure extends State<ShowAllHistory> {
  final List<FilterReionModel> listItemRegion = [
    FilterReionModel(idRegion: 'MB', nameRegion: 'Miền Bắc'),
    FilterReionModel(idRegion: 'MT', nameRegion: 'Miền Trung'),
    FilterReionModel(idRegion: 'MN', nameRegion: 'Miền Nam'),
  ];

  int checkSelectedRegion = 0;
  String checkSelectedIdRegion = '';
  String selectedNameRegion = '';

  String checkSelectedIdProvince = '';

  List<ProvinceModel> itemProvince = [];
  ProvinceModel? selectedDropDownProvinceItem;

  StreamSubscription? _subscription;

  bool isIconFilterVisibility = false;

  late String idCus;

  @override
  void initState() {
    super.initState();
    idCus = widget.idCus;

    final provinceBloc = context.read<ProvinceBloc>();
    provinceBloc.add(FetchProvinces());

    _subscription = provinceBloc.stream.listen((state) {
      if (mounted) {
        if (state is ProvinceLoaded) {
          setState(() {
            itemProvince.clear();
            itemProvince.addAll(state.provinces);
          });
        }
      }
    });

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Lịch sử Việt Nam: Nghìn năm',
          // 'Đắm chìm trong hương vị Việt',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/searchTouristAttraction');
            },
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  image:
                      AssetImage('assets/img/img_lichSuVietNamThanhGiong.PNG'),
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 15),
                Center(
                  child: Container(
                    width: 30,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2.0, // Độ dài của đường gạch ngang
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    'Lịch sử Việt Nam: Dòng máu anh hùng, truyền thống bất khuất, kiến tạo nên hồn quê hào hùng bên sông nước Việt',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Text(
                          'Lọc:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isIconFilterVisibility = !isIconFilterVisibility;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.filter_list_sharp,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 500.0,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<FilterHistoryBloc, FilterHistoryState>(
                    builder: (context, state) {
                      if (state is FilterHistoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FilterHistoryLoaded) {
                        final histories = state.history;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: histories.length,
                          itemBuilder: (context, index) {
                            final history = histories[index];
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
                                    builder: (context) =>
                                        DetailTouristAttraction_History(
                                            history: history, idCus: idCus),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                                        child: history
                                                .titleStoryStory.isNotEmpty
                                            ? Text(
                                                history.titleStoryStory,
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
                      } else if (state is FilterHistoryFailure) {
                        return Text(
                          'Lỗi rồi ${state.error}',
                          style: const TextStyle(fontSize: 80),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<HistoryBloc, HistoryState>(
                          builder: (context, state) {
                            if (state is HistoryLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is HistoryLoaded) {
                              final histories = state.history;
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemCount: histories.length,
                                itemBuilder: (context, index) {
                                  final history = histories[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).pushNamed(
                                      //     '/detail_touriestAttraction_history',
                                      //     arguments: {
                                      //       'HistoryData': history,
                                      //       'idCus': idCus,
                                      //     });

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            DetailTouristAttraction_History(
                                          history: history,
                                          idCus: idCus,
                                        ),
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          FutureBuilder<Widget>(
                                            future:
                                                _buildImage(history.imgHistory),
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
                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            right: 10,
                                            child: Container(
                                              height: 50,
                                              width: double.infinity,
                                              color: Colors.transparent,
                                              alignment: Alignment.bottomLeft,
                                              child: history.titleStoryStory
                                                      .isNotEmpty
                                                  ? Text(
                                                      history.titleStoryStory,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 200,
            child: Visibility(
              visible: isIconFilterVisibility,
              child: Container(
                height: 400,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 164, 209, 245),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Lọc',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isIconFilterVisibility = !isIconFilterVisibility;
                            });
                          },
                          child: const Image(
                            image: AssetImage(
                              'assets/img/img_13.png',
                            ),
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Miền',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listItemRegion.length,
                        itemBuilder: (context, index) {
                          final region = listItemRegion[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                checkSelectedRegion = index;
                                checkSelectedIdRegion = region.idRegion;
                                selectedNameRegion = region.nameRegion;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: checkSelectedRegion == index
                                    ? Colors.amber
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                region.nameRegion,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Text(
                      'Tỉnh/ thành phố',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: DropdownButton<ProvinceModel>(
                        isExpanded: true,
                        menuMaxHeight: 150,
                        value: selectedDropDownProvinceItem,
                        items: itemProvince.map((ProvinceModel item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.nameprovince,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (ProvinceModel? newValue) {
                          setState(() {
                            selectedDropDownProvinceItem = newValue!;
                            checkSelectedIdProvince =
                                selectedDropDownProvinceItem!.idprovince;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isIconFilterVisibility = !isIconFilterVisibility;
                          });
                          BlocProvider.of<FilterHistoryBloc>(context).add(
                            FilterHistory(
                              idRegion: checkSelectedIdRegion,
                              idProvines: checkSelectedIdProvince,
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.amber),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Lọc',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
