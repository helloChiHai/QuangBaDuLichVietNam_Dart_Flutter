import 'package:flutter/material.dart';

import '../../model/typeTouristModel.dart';

class FilterTypeTouristPage extends StatefulWidget {
  final String idCus;

  const FilterTypeTouristPage({
    Key? key,
    required this.idCus,
  }) : super(key: key);

  @override
  State<FilterTypeTouristPage> createState() => _FilterTypeTouristPageState();
}

class _FilterTypeTouristPageState extends State<FilterTypeTouristPage> {
  late String idCus;

  @override
  void initState() {
    super.initState();
    idCus = widget.idCus;
  }

  List<TypeTouristModel> typeTouristList = [
    TypeTouristModel(
      idTypeTourist: 'MT',
      titleTypeTourist: 'Chào mừng đến với Miền Tây',
      nameTypeTourist: 'Miền Tây Sông Nước',
      imgTypeTourist: 'img_MTSN.jpg',
      introTypeTourist:
          'Miền Tây Việt Nam, xanh mướt sông nước, nền văn hóa đậm đà và tình thân thiện',
    ),
    TypeTouristModel(
      idTypeTourist: 'B',
      titleTypeTourist: 'Vẻ Đẹp Biển Việt Nam',
      nameTypeTourist: 'Biển',
      imgTypeTourist: 'img_B.jpg',
      introTypeTourist:
          'Biển Việt Nam, với bờ cát dịu dàng, sóng biển êm đềm, là bức tranh tuyệt vời của thiên nhiên',
    ),
    TypeTouristModel(
      idTypeTourist: 'N',
      titleTypeTourist: 'Hùng vĩ núi đồi Việt Nam',
      nameTypeTourist: 'Núi',
      imgTypeTourist: 'img_Nui.jpg',
      introTypeTourist:
          'Vùng đồi núi Việt Nam quyến rũ bằng sự hùng vĩ hoang sơ và bí ẩn lôi cuốn',
    ),
    TypeTouristModel(
      idTypeTourist: 'TP',
      titleTypeTourist: 'Thành phố không ngủ',
      nameTypeTourist: 'Thành Phố',
      imgTypeTourist: 'img_thanhPho.jpg',
      introTypeTourist:
          'Thành phố đô thị Việt Nam đẹp và phồn thịnh, hứa hẹn trải nghiệm du lịch độc đáo',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: typeTouristList.length,
        itemBuilder: (context, index) {
          final typeTourist = typeTouristList[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detailFilterTypeTourist',
                arguments: {
                  'idTypeTourist': typeTourist.idTypeTourist,
                  'titleTypeTourist': typeTourist.titleTypeTourist,
                  'imgTypeTourist': typeTourist.imgTypeTourist,
                  'introTypeTourist': typeTourist.introTypeTourist,
                  'idCus': idCus,
                },
              );
            },
            child: Container(
              width: 270,
              margin: const EdgeInsets.only(right: 10),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: typeTourist.imgTypeTourist.isNotEmpty
                        ? Image.asset(
                            'assets/img/${typeTourist.imgTypeTourist}',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/img/img_12.png',
                            width: double.infinity,
                            height: double.infinity,
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
                      child: Text(
                        typeTourist.nameTypeTourist,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
