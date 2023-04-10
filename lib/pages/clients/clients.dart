import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import '../../bloc/user_cubit/user_cubit.dart';
import '../../constants/constans.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/functions.dart';
import '../../helpers/reponsiveness.dart';
import '../../models/user_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';

class ClientsPage extends StatefulWidget {
   const ClientsPage({Key? key}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final _controllerBody = TextEditingController();
  final _controllerTitle = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserCubit.get(context).getUsers();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerBody.dispose();
    _controllerTitle.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            Obx(
              () => Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: ResponsiveWidget.isSmallScreen(context)
                              ? 56
                              : 6),
                      child: CustomText(
                        text: menuController.activeItem.value,
                        size: 24,
                        weight: FontWeight.bold, color: homeColor,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 180,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: 80,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: homeColor,
                      onPressed: () {

                        showDialog(
                          context: context,
                          builder: (context) {
                            // return object of type Dialog
                            return Container(
                              // height: 200,
                              child: AlertDialog(
                                title: Texts(
                                    fSize: 18,
                                    color: Colors.red,
                                    title: "ارسال اشعار",
                                    weight: FontWeight.bold),
                                content:  Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey,width: 1)
                                  ),
                                  height: 200,
                                  width: 320,
                                  child: Column(
                                    children: [

                                      TextField(
                                        maxLines: null,
                                        controller: _controllerTitle,
                                        style: const TextStyle(fontFamily: "pnuM"),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "عنوان الرسالة",
                                        ),
                                      ),
                                      TextField(
                                        maxLines: null,
                                        controller: _controllerBody,
                                        style: const TextStyle(fontFamily: "pnuM"),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "نص الرسالة",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  MaterialButton(
                                    minWidth: 50,
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(4)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 2),
                                      child: Text("ارسال",
                                          style: TextStyle(
                                              fontFamily: "pnuM",
                                              color: Colors.white)),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 1);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      "الغاء",
                                      style:
                                      TextStyle(fontFamily: "pnuM"),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 0);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ).then((value) {
                          print(value);
                          if (value == null) {
                            return;
                          } else if (value == 1) {
                            if(_controllerBody.text.isNotEmpty&&_controllerTitle.text.isNotEmpty){

                              UserCubit.get(context).sendNotification(
                                  context: context,title: _controllerTitle.text,
                                  body: _controllerBody.text,
                                  onSuccess: (){
                                    _controllerBody.text="";
                                    _controllerTitle.text="";
                                  }
                              );
                            }else{
                              HelperFunctions.slt.notifyUser(
                                  color: Colors.green,message: "الرسالة فارغة",context: context
                              );
                            }

                          }
                        });

                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CustomText(
                              text: "ارسال اشعار للعملاء",
                              color: Colors.white,
                              weight: FontWeight.bold, size: 16,
                            ),
                            SizedBox(width: 10,),

                            Icon(Icons.notifications_active_outlined,color: Colors.white,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
                child: UserCubit.get(context).loadUsers
                    ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.blue,
                      ),
                    )
                    : TableWidgetUsers(
                        list: UserCubit.get(context).listUsers,
                        name: "JDJDJD",
                        image: "HDDDDDDD",
                        id: "1",
                        label: "الاقسام",
                        onDelete: false,
                        onUpdate: false,
                      )),
          ],
        );
      },
    );
  }
}

class TableWidgetUsers extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<UserModel> list;

  const TableWidgetUsers(
      {Key? key, required this.label,
      required this.name,
      required this.id,
      required this.onDelete,
      required this.onUpdate,
      required this.image,
      required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,

                columns: const [

                  DataColumn2(
                    label: Text('الاسم'),
                    size: ColumnSize.L
                  ),

                  DataColumn2(
                    label: Text('الصورة'),
                    size: ColumnSize.S,
                  ),
                  DataColumn(
                    label: Text('تاريخ التسجيل'),
                  ),
                  DataColumn2(
                    label: Text("تفاسيل"),
                    size: ColumnSize.L,
                  ),
                ],
                rows: List<DataRow>.generate(list.length, (index) {
                  DateTime now =
                      DateTime.parse(list[index].createdAt.toString());
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(now);

                  return DataRow2(
                      onTap: (){


                      },
                      cells: [

                    DataCell(CustomText(text: list[index].fullName!, size: 16,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  )),
                    DataCell(SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: CachedNetworkImage(
                          imageUrl: "$baseUrlImages${list[index].imageUrl}",
                          height: 60,
                          width: 100,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    )),
                    DataCell(CustomText(text: formattedDate, size: 16,
                  color: Colors.black,
                  weight: FontWeight.bold,
                  )),
                        DataCell(Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          height: 50,
                          width: 120,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            color:Colors.green,
                            onPressed: () {

                              showDialogAction(context, list[index]);

/*                          showDialog(
                            context: context,
                            builder: (context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: Texts(
                                    fSize: 18,
                                    color: Colors.red,
                                    title: list[index].order!.id.toString(),
                                    weight: FontWeight.bold),
                                content: Texts(
                                    fSize: 20,
                                    color: Colors.black,
                                    title: list[index].order!.status == 0
                                        ? "ارسال الطلب الى المحل "
                                        : "وقف الطلب",
                                    weight: FontWeight.bold),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  MaterialButton(
                                    minWidth: 50,
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 2),
                                      child: Text("نعم",
                                          style: TextStyle(
                                              fontFamily: "pnuM",
                                              color: Colors.white)),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 1);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      "الغاء",
                                      style: TextStyle(fontFamily: "pnuM"),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 0);
                                    },
                                  ),
                                ],
                              );
                            },
                          ).then((value) {
                            print(value);
                            if (value == null) {
                              return;
                            } else if (value == 1) {
                              if (list[index].order!.status == 0) {
                                OrderCubit.get(context).updateStatusOrder(context: context,
                                  fcmToken: list[index].field!.token,
                                    status: 1, id: list[index].order!.id);
                              } else {
                                OrderCubit.get(context).updateStatusOrder(context: context,
                                    fcmToken: list[index].field!.token,
                                    status: 0, id: list[index].order!.id);
                              }
                            }
                          });*/
                            },
                            child: const Center(
                              child: CustomText(
                                text: "التفاصيل",
                                color: Colors.white,
                                weight: FontWeight.bold,
                                size: 16,
                              ),
                            ),
                          ),
                        )),
                  ]);
                })),
          ],
        ),
      ),
    );
  }

  Future showDialogAction(BuildContext context, UserModel model) async {
    DateTime now =
    DateTime.parse(model.createdAt.toString());
    String formattedDate =
    DateFormat('yyyy-MM-dd – kk:mm').format(now);
    showDialog(
      context: context,
      builder: (context) {
        // return object of type Dialog
        return Container(
          // height: 200,

          child: AlertDialog(
            title: Texts(
                fSize: 18,
                color: Colors.red,
                title: "تفاصيل العميل",
                weight: FontWeight.bold),
            content: Column(
              children: [
                DetailsSuggestion("اسم العميل :",model.fullName),
                SizedBox(height: 20,),
                DetailsSuggestion("رقم الهاتف :",model.userName),
                SizedBox(height: 20,),
                DetailsSuggestion("الحالة :",model.role),
                SizedBox(height: 20,),
                DetailsSuggestion("تاريخ التسجيل :",formattedDate),
                SizedBox(height: 20,),

              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog

              TextButton(
                child: const Text("حسنا",style: TextStyle(
                    fontFamily: "pnuB",fontSize: 25,fontWeight: FontWeight.bold
                ),),
                onPressed: () {
                  Navigator.pop(context, 0);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
class DetailsSuggestion extends StatelessWidget {
  final String? title,value;


  DetailsSuggestion(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Texts(
            fSize: 20,
            color: Colors.black,
            title: title,
            weight: FontWeight.bold),
        SizedBox(width: 20,),
        Texts(
            fSize: 25,
            color: Colors.black,
            title: value,
            weight: FontWeight.bold),
      ],
    );
  }
}