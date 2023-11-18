import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/model/filterRegionModel.dart';
import 'package:userappquanbadulich/model/provinceModel.dart';
import 'package:userappquanbadulich/province/bloc/province_bloc.dart';
import 'package:userappquanbadulich/province/bloc/province_event.dart';
import 'package:userappquanbadulich/province/bloc/province_state.dart';
import 'package:userappquanbadulich/specialDish/bloc/specialDish_bloc.dart';
import 'package:userappquanbadulich/specialDish/bloc/specialDish_event.dart';

import '../../specialDish/bloc/specialDish_state.dart';
import '../bloc/filterSpecialDish_bloc.dart';
import '../bloc/filterSpecialDish_state.dart';
import '../bloc/filterTourist_event.dart';

class ShowAllSpecialDish extends StatefulWidget {
  final String idCus;

  const ShowAllSpecialDish({
    Key? key,
    required this.idCus,
  }) : super(key: key);

  @override
  State<ShowAllSpecialDish> createState() => _ShowAllTourisCulure();
}

class _ShowAllTourisCulure extends State<ShowAllSpecialDish> {
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

    context.read<SpecialDishBloc>().add(FetchSpecialDish());
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
          'Đắm chìm trong hương vị Việt',
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
                  child: BlocBuilder<FilterSpecialDishBloc,
                      FilterSpecialDishState>(
                    builder: (context, state) {
                      if (state is FilterSpecialDishLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FilterSpecialDishLoaded) {
                        final specialDishs = state.specialDish;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: specialDishs.length,
                          itemBuilder: (context, index) {
                            final specialDish = specialDishs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    '/detail_touriestAttraction_specialDish',
                                    arguments: {
                                      'specialDishData': specialDish,
                                      'idCus': idCus,
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: specialDish.imgDish != null &&
                                              specialDish.imgDish!.isNotEmpty
                                          ? Image.asset(
                                              'assets/img/${specialDish.imgDish!}',
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/img/img_12.png',
                                              width: double.infinity,
                                              height: 180,
                                              fit: BoxFit.cover,
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
                                        child: specialDish.nameDish.isNotEmpty
                                            ? Text(
                                                specialDish.nameDish,
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
                      } else if (state is FilterSpecialDishFailure) {
                        return Text(
                          'Lỗi rồi ${state.error}',
                          style: const TextStyle(fontSize: 80),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<SpecialDishBloc, SpecialDishState>(
                          builder: (context, state) {
                            if (state is SpecialDishLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is SpecialDishLoaded) {
                              final specialDishs = state.specialDishs;
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemCount: specialDishs.length,
                                itemBuilder: (context, index) {
                                  final specialDish = specialDishs[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          '/detail_touriestAttraction_specialDish',
                                          arguments: {
                                            'specialDishData': specialDish,
                                            'idCus': idCus,
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
                                            child:
                                                specialDish.imgDish != null &&
                                                        specialDish
                                                            .imgDish!.isNotEmpty
                                                    ? Image.asset(
                                                        'assets/img/${specialDish.imgDish!}',
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        'assets/img/img_12.png',
                                                        width: double.infinity,
                                                        height: 180,
                                                        fit: BoxFit.cover,
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
                                              child: specialDish
                                                      .nameDish.isNotEmpty
                                                  ? Text(
                                                      specialDish.nameDish,
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
                          BlocProvider.of<FilterSpecialDishBloc>(context).add(
                            FilterSpecialDish(
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