import 'package:appquangbadulich/model/dropdownRegionModel.dart';
import 'package:appquangbadulich/model/filterRegionModel.dart';
import 'package:appquangbadulich/showFilterAllTouristCultureHistoryFood/bloc/filterTourist_bloc.dart';
import 'package:appquangbadulich/showFilterAllTouristCultureHistoryFood/bloc/filterTourist_event.dart';
import 'package:appquangbadulich/showFilterAllTouristCultureHistoryFood/bloc/filterTourist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAllTouristAttraction extends StatefulWidget {
  const ShowAllTouristAttraction({super.key});

  @override
  State<ShowAllTouristAttraction> createState() =>
      _ShowAllTouristAttractionState();
}

class _ShowAllTouristAttractionState extends State<ShowAllTouristAttraction> {
  final List<DropDownRegionModel> itemRegions = [
    DropDownRegionModel(idRegion: 'HCM', nameRegion: 'Ho Chi Minh'),
    DropDownRegionModel(idRegion: 'HN', nameRegion: 'Ha Noi'),
    DropDownRegionModel(idRegion: 'CT', nameRegion: 'Can Tho'),
  ];

  final List<FilterReionModel> listItemRegion = [
    FilterReionModel(idRegion: 'PB', nameRegion: 'Miền Bắc'),
    FilterReionModel(idRegion: 'PT', nameRegion: 'Miền Trung'),
    FilterReionModel(idRegion: 'PN', nameRegion: 'Miền Nam'),
  ];

  late DropDownRegionModel selectedDropDownRegionItem;
  int checkSelectedRegion = 1;
  String checkSelectedIdRegion = '';
  String selectedNameRegion = '';

  @override
  void initState() {
    super.initState();
    selectedDropDownRegionItem = itemRegions[0];
    context
        .read<FilterTouristBloc>()
        .add(FilterTouristAttraction(idRegion: '', idProvines: ''));
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
      body: SingleChildScrollView(
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
                        print(selectedDropDownRegionItem.idRegion);
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Container(
                                    height: 400,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 20,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                Navigator.pop(context);
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
                                        Container(
                                          height: 45,
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: listItemRegion.length,
                                            itemBuilder: (context, index) {
                                              final region =
                                                  listItemRegion[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    checkSelectedRegion = index;
                                                    checkSelectedIdRegion =
                                                        region.idRegion;
                                                    selectedNameRegion =
                                                        region.nameRegion;
                                                  });
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                    right: 10,
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        checkSelectedRegion ==
                                                                index
                                                            ? Colors.amber
                                                            : Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                          width: 130,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: DropdownButton<
                                              DropDownRegionModel>(
                                            isExpanded: true,
                                            menuMaxHeight: 150,
                                            value: selectedDropDownRegionItem,
                                            items: itemRegions.map(
                                                (DropDownRegionModel item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.nameRegion,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (DropDownRegionModel?
                                                newValue) {
                                              setState(() {
                                                selectedDropDownRegionItem =
                                                    newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              print(checkSelectedIdRegion);
                                              print(selectedNameRegion);
                                              context
                                                  .read<FilterTouristBloc>()
                                                  .add(FilterTouristAttraction(
                                                      idRegion: '',
                                                      idProvines: ''));
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.amber),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                  );
                                },
                              );
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
            // danh sách các địa điểm du lịch khi lọc
            BlocBuilder<FilterTouristBloc, FilterTouristState>(
              builder: (context, state) {
                if (state is FilterTouristLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FilterTouristLoaded) {
                  final touristAttractions = state.tourist;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: touristAttractions.length,
                    itemBuilder: (context, index) {
                      final touristAttraction = touristAttractions[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              '/detail_touriestAttraction_about',
                              arguments: {
                                'aboutTouristData': touristAttraction,
                              });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: touristAttraction.imgTourist != null
                                      ? Image.asset(
                                          'assets/img/${touristAttraction.imgTourist!}',
                                          width: 145,
                                          height: 145,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/img/img_12.png',
                                          width: 145,
                                          height: 145,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      touristAttraction.nameTourist,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      touristAttraction.address,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
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
          ],
        ),
      ),
    );
  }
}
