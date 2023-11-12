import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/addTouristToList_bloc.dart';
import '../bloc/addTouristToList_event.dart';
import '../bloc/addTouristToList_state.dart';

class AddAndRemoveTouristPage extends StatefulWidget {
  final bool isCheckFavourite;
  final String idCus;
  final String idTourist;

  const AddAndRemoveTouristPage({
    Key? key,
    required this.isCheckFavourite,
    required this.idCus,
    required this.idTourist,
  }) : super(key: key);

  @override
  State<AddAndRemoveTouristPage> createState() =>
      _AddAndRemoveTouristPageState();
}
class _AddAndRemoveTouristPageState extends State<AddAndRemoveTouristPage> {
  late bool isCheckFavourite;
  late String idCus;
  late String idTourist;
  final GlobalKey<_AddAndRemoveTouristPageState> _key =
      GlobalKey<_AddAndRemoveTouristPageState>();

  @override
  void initState() {
    super.initState();
    isCheckFavourite = widget.isCheckFavourite;
    idCus = widget.idCus;
    idTourist = widget.idTourist;
  }

  void reloadWidget() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {
          // Bạn có thể đặt bất kỳ logic khởi tạo nào ở đây
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAndRemoveTouristListBloc,
        AddAndRemoveTouristListState>(
      builder: (context, state) {
        if (state is AddTouristToListSuccess) {
          print('Thêm thành công');
          reloadWidget(); // Tải lại widget khi thêm địa điểm du lịch thành công
        } else if (state is RemoveTouristFromListSuccess) {
          print('Xóa thành công');
          reloadWidget(); // Tải lại widget khi xóa địa điểm du lịch thành công
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            onPressed: () {
              if (isCheckFavourite) {
                BlocProvider.of<AddAndRemoveTouristListBloc>(context).add(
                  AddTouristToListButtonPressed(
                    idCus: idCus,
                    idTourist: idTourist,
                  ),
                );
              } else {
                BlocProvider.of<AddAndRemoveTouristListBloc>(context).add(
                  RemoveTouristFromListButtonPressed(
                    idCus: idCus,
                    idTourist: idTourist,
                  ),
                );
              }

              setState(() {
                isCheckFavourite = !isCheckFavourite;
              });
              print(isCheckFavourite);
            },
            icon: Icon(
              isCheckFavourite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              size: 30,
              color: isCheckFavourite ? Colors.red : null,
            ),
          ),
        );
      },
    );
  }
}
