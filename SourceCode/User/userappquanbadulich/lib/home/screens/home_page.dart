import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/imformationCustomer/bloc/imformationCus_bloc.dart';
import 'package:userappquanbadulich/showAllFilterHistory/screens/showAllCulture_page.dart';
import 'package:userappquanbadulich/showAllFilterSpecialDish/screens/showAllSpecial_page.dart';
import '../../culture/screens/culture_page.dart';
import '../../filterTypeTourist/screens/filterTypeTourist_page.dart';
import '../../history/screens/history_page.dart';
import '../../model/CustomerModel.dart';
import '../../searchTouristAttraction/srceens/searchTouristAttraction_page.dart';
import '../../showAllFilterCulture/screens/showAllCulture_page.dart';
import '../../showFilterAllTourist/screens/showAllTouristAttraction_page.dart';
import '../../specialDish/screens/specialDish_page.dart';
import '../../touristAttraction/screens/touristAttraction_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CustomerBloc, CustomerModel?>(
        builder: (context, customer) {
          if (customer == null) {
            return const Text('Chưa có thông tin khách hàng');
          } else {
            return SingleChildScrollView(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SearchTouristAttractionPage(
                                    idCus: customer.idCus,
                                  ),
                                ));
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
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
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
                        const SizedBox(height: 10),
                        FilterTypeTouristPage(idCus: customer.idCus),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowAllTouristAttraction(
                                    idCus: customer.idCus),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Nhất định phải đến',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.navigate_next,
                                  size: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        TouristAttractionPage(idCus: customer.idCus),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ShowAllCulure(idCus: customer.idCus),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Người Việt Nam dễ thương lắm',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.navigate_next,
                                  size: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        CulturePage(idCus: customer.idCus),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ShowAllSpecialDish(idCus: customer.idCus),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Đặc sản Việt Nam: Món ngon đầy hương vị',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.navigate_next,
                                  size: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SpecialDishPage(idCus: customer.idCus),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ShowAllHistory(idCus: customer.idCus),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Cùng nhìn lại lịch sử hào hùng của dân tộc Việt Nam',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.navigate_next,
                                  size: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        HistoryPage(idCus: customer.idCus),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
