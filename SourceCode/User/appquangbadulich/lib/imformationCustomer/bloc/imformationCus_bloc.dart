import 'package:appquangbadulich/model/CustomerModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerBloc extends Cubit<CustomerModel?> {
  CustomerBloc() : super(null);

  void setCustomer(CustomerModel customer) {
    emit(customer);
  }
}
