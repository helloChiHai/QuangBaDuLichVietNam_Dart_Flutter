import 'package:flutter/material.dart';

import '../../culture/screens/culture_page.dart';
import '../../history/screens/history_page.dart';
import '../../specialDish/screens/specialDish_page.dart';
import '../../touristAttraction/screens/touristAttraction_page.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: 210,
                        color: Colors.white,
                        width: double.infinity,
                        child: const Image(
                          image: AssetImage(
                            'assets/img/img_8.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        height: 50,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 25,
                  left: MediaQuery.of(context).size.width * 0.8,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/account');
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.dehaze_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  left: 15,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/searchTouristAttraction');
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.search,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Bắt đầu tìm nơi để đi chơi thôi nào!',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // bạn muốn đến vùng...
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bạn muốn đến...',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 150,
                    color: Colors.white,
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/img/img_9.png',
                                ),
                                height: 85,
                                width: 85,
                              ),
                              Text(
                                'Núi',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/img/img_10.png',
                                ),
                                height: 70,
                                width: 70,
                              ),
                              Text(
                                'Biển',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/img/img_11.png',
                                ),
                                height: 70,
                                width: 70,
                              ),
                              Text(
                                'Rừng',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            // MỘT SỐ CÁC ĐỊA ĐIỂM
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/showAllTouristAttraction');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nhất định phải đến',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          size: 35,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TouristAttractionPage(),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // VĂN HÓA
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              width: double.infinity,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Người Việt Nam dễ thương lắm',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CulturePage(),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // ĐẶC SẢN
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              width: double.infinity,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đặc sản Việt Nam: Món ngon đầy hương vị',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SpecialDishPage(),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // LỊCH SỬ
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              width: double.infinity,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cùng nhìn lại lịch sử hào hùng của dân tộc Việt Nam',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  HistoryPage(),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
