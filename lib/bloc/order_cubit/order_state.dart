part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}
class GetOrdersSuccessStat extends OrderState {
  final List<ResponseOrder> list ;
  GetOrdersSuccessStat(this.list);
}

class GetOrdersErrorStat extends OrderState {
  final String error;
  GetOrdersErrorStat(this.error);
}

class GetOrdersLoadStat extends OrderState {}







class UpdateOrderSuccessStat extends OrderState {

  UpdateOrderSuccessStat();
}

class UpdateOrderErrorStat extends OrderState {
  final String error;
  UpdateOrderErrorStat(this.error);
}

class UpdateOrderLoadStat extends OrderState {}

class ChangeValue extends OrderState {}


//delete
class DeleteOrderLoadStat extends OrderState {}
class DeleteOrderSuccessStat extends OrderState {
  final String success;

  DeleteOrderSuccessStat(this.success);
}
class DeleteOrderErrorStat extends OrderState {

  final String error;

  DeleteOrderErrorStat(this.error);
}


//delete
  class DetailsOrderLoadStat extends OrderState {}
class DetailsOrderSuccessStat extends OrderState {

}
class DetailsOrderErrorStat extends OrderState {


}