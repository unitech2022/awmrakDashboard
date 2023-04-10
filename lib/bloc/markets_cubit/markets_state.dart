part of 'markets_cubit.dart';

@immutable
abstract class MarketsState {}

class MarketsInitial extends MarketsState {}


class GetMarketsDataLoad extends MarketsState {}
class GetMarketsDataSuccess extends MarketsState {


  GetMarketsDataSuccess();

}
class GetMarketsDataError extends MarketsState {}



//update
class UpdateMarketsDataLoad extends MarketsState {}
class UpdateMarketsDataSuccess extends MarketsState {




}
class UpdateMarketsDataError extends MarketsState {}


//delete
class DeleteMarketsDataLoad extends MarketsState {}
class DeleteMarketsDataSuccess extends MarketsState {




}
class DeleteMarketsDataError extends MarketsState {}

class ChangeValueSubCategory extends MarketsState {}


