part of 'care_cubit.dart';

@immutable
abstract class CareState {}

class CareInitial extends CareState {}


class GetCaresSuccessStat extends CareState {
  final List<Care> list ;
  GetCaresSuccessStat(this.list);
}
class GetCaresErrorStat extends CareState {
  final String error;
  GetCaresErrorStat(this.error);
}
class GetCaresLoadStat extends CareState {}



//Add Category
class AddCareLoadStat extends CareState {}
class AddCareSuccessStat extends CareState {
  final String success;

  AddCareSuccessStat(this.success);
}
class AddCareErrorStat extends CareState {

  final String error;

  AddCareErrorStat(this.error);
}

//upload image
class UpdateCareLoadImageStat extends CareState {}
class UpdateCareLoadedImageStat extends CareState {
  final String image;

  UpdateCareLoadedImageStat(this.image);
}
class UpdateCareLoadErrorImageStat extends CareState {}

//delete
class DeleteCareLoadStat extends CareState {}
class DeleteCareSuccessStat extends CareState {
  final String success;

  DeleteCareSuccessStat(this.success);
}
class DeleteCareErrorStat extends CareState {

  final String error;

  DeleteCareErrorStat(this.error);
}

// update
class UpdateCaresLoadStat extends CareState {}

class UpdateCaresSuccessStat extends CareState {
  final String success;

  UpdateCaresSuccessStat(this.success);
}
class UpdateCaresSuccessErrorStat extends  CareState{}


//upload image
class UpdateCategoriesLoadImageStat extends CareState {}
class UpdateCategoriesLoadedImageStat extends CareState {
  final String image;

  UpdateCategoriesLoadedImageStat(this.image);
}
class UpdateCategoriesLoadErrorImageStat extends CareState {}