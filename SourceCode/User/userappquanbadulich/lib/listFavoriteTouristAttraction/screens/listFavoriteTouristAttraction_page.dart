import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/imformationCustomer/bloc/imformationCus_bloc.dart';
import 'package:userappquanbadulich/model/CustomerModel.dart';

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
  @override
  void initState() {
    super.initState();
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
      body: BlocBuilder<CustomerBloc, CustomerModel?>(
        builder: (context, customer) {
          if (customer == null) {
            return const Text('Bạn đưa đăng nhập');
          } else {
            return BlocBuilder<GetTouristInFavoriteListBloc,
                GetTouristInFavoriteListState>(
              builder: (context, state) {
                if (state is GetTouristInFavoriteListInitial) {
                  context.read<GetTouristInFavoriteListBloc>().add(
                        FetchTouristAttractionInFavoriteList(
                          idCus: customer.idCus,
                        ),
                      );
                }

                if (state is GetTouristInFavoriteListLoaded) {
                  final touristList = state.touristAttractions;

                  return SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: touristList.length,
                      itemBuilder: (context, index) {
                        final touristAttraction = touristList[index];
                        return GestureDetector(
                          onTap: () {
                            print(touristAttraction.idTourist);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                        color: Color.fromARGB(255, 98, 98, 98),
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
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/img/${touristAttraction.imgTourist}'),
                                            width: 110,
                                            height: 110,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
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
                                              overflow: TextOverflow.ellipsis,
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
                                              overflow: TextOverflow.ellipsis,
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
                                        IconButton(
                                          onPressed: () {
                                            // Xử lý thêm/xóa yêu thích
                                          },
                                          icon: const Icon(
                                            Icons.favorite,
                                            size: 30,
                                            color: Colors.red,
                                          ),
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
                    ),
                  );
                } else if (state is GetTouristInFavoriteListFailure) {
                  print(state.error);
                  print(customer.idCus);
                  return const Text('Lỗi');
                }

                return Container();
              },
            );
          }
        },
      ),
    );
  }
}
