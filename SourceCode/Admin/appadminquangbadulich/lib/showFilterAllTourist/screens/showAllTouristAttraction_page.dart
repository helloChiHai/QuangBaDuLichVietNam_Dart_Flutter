import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:appadminquangbadulich/model/filterRegionModel.dart';
import 'package:appadminquangbadulich/model/provinceModel.dart';
import 'package:appadminquangbadulich/province/bloc/province_bloc.dart';
import 'package:appadminquangbadulich/province/bloc/province_event.dart';
import 'package:appadminquangbadulich/province/bloc/province_state.dart';
import 'package:appadminquangbadulich/showFilterAllTourist/bloc/filterTourist_bloc.dart';
import 'package:appadminquangbadulich/showFilterAllTourist/bloc/filterTourist_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../touristAttraction/bloc/touristAttraction_bloc.dart';
import '../../touristAttraction/bloc/touristAttraction_event.dart';
import '../../touristAttraction/bloc/touristAttraction_state.dart';
import '../bloc/filterTourist_state.dart';

class ShowAllTouristAttraction extends StatefulWidget {
  const ShowAllTouristAttraction({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowAllTouristAttraction> createState() =>
      _ShowAllTouristAttractionState();
}

class _ShowAllTouristAttractionState extends State<ShowAllTouristAttraction> {
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

  @override
  void initState() {
    super.initState();

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

    context.read<TouristAttractionBloc>().add(FetchTouristAttraction());
  }

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return Image.memory(
          Uint8List.fromList(imageBytes),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        );
      } catch (e) {
        return Image.asset(
          'assets/img/${img}',
          width: 200,
          height: 200,
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
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Khám phá Việt Nam cùng bạn',
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
                  image: AssetImage('assets/img/img_8.jpg'),
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
                    'Việt Nam, đất nước phía Đông Nam Á, nổi tiếng với cảnh quan thiên nhiên tuyệt đẹp, văn hóa đa dạng, lịch sử hào hùng và đặc sản ẩm thực hấp dẫn.',
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
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/addTouristAttraction');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 152, 203, 244),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'Thêm địa điểm',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
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
                  child: BlocBuilder<FilterTouristBloc, FilterTouristState>(
                    builder: (context, state) {
                      if (state is FilterTouristLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FilterTouristLoaded) {
                        final touristAttractions = state.tourist;
                        return touristAttractions.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemCount: touristAttractions.length,
                                itemBuilder: (context, index) {
                                  final touristAttraction =
                                      touristAttractions[index];
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
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: FutureBuilder<Widget>(
                                              future: _buildImage(
                                                  "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…"),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Widget>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return snapshot.data ??
                                                      Container();
                                                } else {
                                                  return CircularProgressIndicator();
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
                                                      touristAttraction
                                                          .nameTourist,
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
                              )
                            : const Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'assets/img/img_knowhow.png',
                                    ),
                                    width: 170,
                                    height: 170,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'Không có địa điểm du lịch ở đây',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              );
                      } else if (state is FilterTouristFailure) {
                        return Text(
                          'Lỗi rồi ${state.error}',
                          style: const TextStyle(fontSize: 80),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<TouristAttractionBloc,
                            TouristAttractionState>(
                          builder: (context, state) {
                            if (state is TouristAttractionLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is TouristAttractionLoaded) {
                              final touristAttractions =
                                  state.touristAttraction;
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemCount: touristAttractions.length,
                                itemBuilder: (context, index) {
                                  final touristAttraction =
                                      touristAttractions[index];
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
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                  return CircularProgressIndicator();
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
                                                      touristAttraction
                                                          .nameTourist,
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
                          BlocProvider.of<FilterTouristBloc>(context).add(
                            FilterTouristAttraction(
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
}
