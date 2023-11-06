import 'package:appquangbadulich/model/dropdownRegionModel.dart';
import 'package:flutter/material.dart';

class ShowFilterAllTouristCultureHistoryFoodPage extends StatefulWidget {
  const ShowFilterAllTouristCultureHistoryFoodPage({super.key});

  @override
  State<ShowFilterAllTouristCultureHistoryFoodPage> createState() =>
      _ShowFilterAllTouristCultureHistoryFoodPageState();
}

class _ShowFilterAllTouristCultureHistoryFoodPageState
    extends State<ShowFilterAllTouristCultureHistoryFoodPage> {
  final List<DropDownRegionModel> itemRegions = [
    DropDownRegionModel(idRegion: 'PB', nameRegion: 'Miền Bắc'),
    DropDownRegionModel(idRegion: 'PT', nameRegion: 'Miền Trung'),
    DropDownRegionModel(idRegion: 'PN', nameRegion: 'Miền Nam'),
  ];

  late DropDownRegionModel selectedDropDownRegionItem;

  @override
  void initState() {
    super.initState();
    selectedDropDownRegionItem = itemRegions[0];
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
              color: Colors.blue,
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
                    Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber),
                      child: DropdownButton<DropDownRegionModel>(
                        isExpanded: true,
                        menuMaxHeight: 150,
                        value: selectedDropDownRegionItem,
                        items: itemRegions.map((DropDownRegionModel item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.nameRegion,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (DropDownRegionModel? newValue) {
                          setState(() {
                            selectedDropDownRegionItem = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber),
                      child: DropdownButton<DropDownRegionModel>(
                        isExpanded: true,
                        menuMaxHeight: 150,
                        value: selectedDropDownRegionItem,
                        items: itemRegions.map((DropDownRegionModel item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.nameRegion,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (DropDownRegionModel? newValue) {
                          setState(() {
                            selectedDropDownRegionItem = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        print(selectedDropDownRegionItem.idRegion);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Tìm kiếm',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 500,
              width: double.infinity,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
