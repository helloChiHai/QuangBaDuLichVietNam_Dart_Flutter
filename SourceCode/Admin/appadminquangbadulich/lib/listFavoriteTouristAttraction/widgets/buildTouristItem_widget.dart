import 'package:flutter/material.dart';

import '../../model/touristAttractionModel.dart';

class BuildTouristItemWidget extends StatelessWidget {
  const BuildTouristItemWidget({
    super.key,
    required this.touristAttraction,
  });

  final TouristAttractionModel touristAttraction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(touristAttraction.idTourist);
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 5),
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
                    color: Color.fromARGB(
                        255, 98, 98, 98),
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
                    padding:
                        const EdgeInsets.symmetric(
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
                          touristAttraction
                              .nameTourist,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight:
                                FontWeight.w500,
                          ),
                          maxLines: 3,
                          overflow:
                              TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Địa chỉ: ${touristAttraction.address}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontStyle:
                                FontStyle.italic,
                          ),
                          maxLines: 3,
                          overflow:
                              TextOverflow.ellipsis,
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
              mainAxisAlignment:
                  MainAxisAlignment.end,
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
  }
}
