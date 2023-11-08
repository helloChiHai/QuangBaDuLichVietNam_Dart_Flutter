import 'package:appquangbadulich/imformationCustomer/bloc/imformationCus_bloc.dart';
import 'package:appquangbadulich/model/CustomerModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Thông tin tài khoản',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CustomerBloc, CustomerModel?>(
                builder: (context, customer) {
              if (customer == null) {
                return const Text('Chưa có thông tin khách hàng');
              } else {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/detailAccount',
                        arguments: {'customerData': customer});
                  },
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 9,
                                child: SizedBox(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image(
                                          image: customer.imgCus!.isEmpty
                                              ? const AssetImage(
                                                  'assets/img/SP_CUL_3.jpg',
                                                )
                                              : AssetImage(
                                                  'assets/img/${customer.imgCus}',
                                                ),
                                          width: 75,
                                          height: 75,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        customer.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.navigate_next_sharp,
                                  size: 35,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage(
                                    'assets/img/SP_CUL_3.jpg',
                                  ),
                                  width: 60,
                                  height: 60,
                                ),
                                Text(
                                  'Danh sách địa điểm đã lưu',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Xin lỗi bạn nhiều',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              content: const Text(
                                'VietWander đang phát triển tính năng này. Bạn vui lòng quay lại sau.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Row(
                        children: [
                          Image(
                            image: AssetImage('assets/img/img_12.png'),
                            fit: BoxFit.cover,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Đánh giá VietWander',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Xin lỗi bạn nhiều'),
                              content: const Text(
                                'VietWander đang phát triển tính năng này. Bạn vui lòng quay lại sau.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Row(
                        children: [
                          Image(
                            image: AssetImage('assets/img/img_12.png'),
                            fit: BoxFit.cover,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Thông báo',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Bạn cần hỗ trợ hả'),
                              content: const Text(
                                'Bạn vui lòng gọi vào 0949162193 hoặc gửi Email đến vuongchihai0711@gmail.com',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Row(
                        children: [
                          Image(
                            image: AssetImage('assets/img/img_12.png'),
                            fit: BoxFit.cover,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Hỗ trợ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Thông báo'),
                              content: const Text(
                                'Bạn đừng vi phạm pháp luật là được. Hãy là một công dân tốt',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Row(
                        children: [
                          Image(
                            image: AssetImage('assets/img/img_12.png'),
                            fit: BoxFit.cover,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Điều khoản và Chính sách',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                color: Color(0xffFCF54C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thả ga với VietWander',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '"VietWander - Khám phá Việt Nam theo cách độc đáo của bạn."',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.transparent,
                      child: const Image(
                        image: AssetImage('assets/img/img_12.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phiên bản hiện tại: V1.0.0',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '>',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 140,
            ),
            const Text(
              'VietWander',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xff00B2EE),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
