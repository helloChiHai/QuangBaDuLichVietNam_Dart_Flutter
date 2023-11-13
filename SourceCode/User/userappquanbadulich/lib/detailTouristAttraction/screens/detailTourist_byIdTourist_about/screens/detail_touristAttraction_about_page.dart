import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_event.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_state.dart';
import 'package:userappquanbadulich/model/touristAttractionModel.dart';

import '../../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_bloc.dart';
import '../../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_event.dart';
import '../../../../addTouristAttractionToFavoritesList/bloc/addTouristToList_state.dart';
import '../../../../imformationCustomer/bloc/imformationCus_bloc.dart';
import '../../../../model/CustomerModel.dart';
import '../widget/detail_touristAttraction_about_widget.dart';

class DetailTouristAttraction_AboutPage extends StatefulWidget {
  const DetailTouristAttraction_AboutPage({Key? key}) : super(key: key);

  @override
  State<DetailTouristAttraction_AboutPage> createState() =>
      _DetailTouristAttraction_AboutPageState();
}

class _DetailTouristAttraction_AboutPageState
    extends State<DetailTouristAttraction_AboutPage> {
  late TouristAttractionModel touristAttraction;
  bool isCheckVisibility = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      touristAttraction = arguments['aboutTouristData'];
      context
          .read<DetailTourist_AboutBloc>()
          .add(getTouristWithIdTourist(idTourist: touristAttraction.idTourist));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CustomerBloc, CustomerModel?>(
        builder: (context, customer) {
          if (customer == null) {
            return const Text('chua co thong tin nguoi dung');
          } else {
            return BlocBuilder<DetailTourist_AboutBloc,
                DetailTourist_AboutState>(
              builder: (context, state) {
                if (state is DetailTourist_AboutLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DetailTourist_AboutLoaded) {
                  final tourist = state.touristAttraction;
                  return BlocBuilder<AddAndRemoveTouristListBloc,
                      AddAndRemoveTouristListState>(
                    builder: (context, state) {
                      context.read<AddAndRemoveTouristListBloc>().add(
                          CheckTouristInList(
                              idCus: customer.idCus,
                              idTourist: tourist!.idTourist));
                      if (state is CheckTouristInListSuccess) {
                        bool isCheckFavourite = state.result;
                        TouristAttractionModel touristData = tourist;
                        return DetailTouristAttraction_AboutWidget(
                          isCheckFavourite: isCheckFavourite,
                          tourist: touristData,
                          isCheckVisibility: isCheckVisibility,
                          customer: customer,
                        );
                      } else if (state is CheckTouristInListFailure) {
                        return Text(state.error);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                } else if (state is DetailTourist_AboutFailure) {
                  return Center(
                    child: Text('Đã xảy ra lỗi: ${state.error}'),
                  );
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
