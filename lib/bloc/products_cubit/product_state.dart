part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}





class GetProductDataLoad extends ProductState {}
class GetProductDataSuccess extends ProductState {
  final List<Product> list ;

  GetProductDataSuccess(this.list);
}
class GetProductDataError extends ProductState {}



//Add Category

class AddProductLoadStat extends ProductState {}

class AddProductSuccessStat extends ProductState {
  final String success;

  AddProductSuccessStat(this.success);
}
class AddProductErrorStat extends ProductState {

  final String error;

  AddProductErrorStat(this.error);
}



//upload ProductState
class UpdateProductLoadImageStat extends ProductState {}
class UpdateProductLoadedImageStat extends ProductState {
  final String image;

  UpdateProductLoadedImageStat(this.image);
}
class UpdateProductLoadErrorImageStat extends ProductState {}
//delete
class DeleteProductLoadStat extends ProductState {}
class DeleteProductSuccessStat extends ProductState {
  final String success;

  DeleteProductSuccessStat(this.success);
}
class DeleteProductErrorStat extends ProductState {

  final String error;

  DeleteProductErrorStat(this.error);
}

// update
class UpdateProductLoadStat extends ProductState {}

class UpdateProductSuccessStat extends ProductState {
  final String success;

  UpdateProductSuccessStat(this.success);
}
class UpdateProductErrorStat extends ProductState {

  final String error;

  UpdateProductErrorStat(this.error);
}



// sliders
class SliderProductLoadStat extends ProductState {}

class SliderProductSuccessStat extends ProductState {

}
class SliderProductErrorStat extends ProductState {
}

