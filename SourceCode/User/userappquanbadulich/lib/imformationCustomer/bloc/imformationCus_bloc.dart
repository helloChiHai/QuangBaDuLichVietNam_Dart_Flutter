import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/model/CustomerModel.dart';

class CustomerBloc extends Cubit<CustomerModel?> {
  CustomerBloc() : super(null);

  void setCustomer(CustomerModel customer) {
    emit(customer);
  }
}
