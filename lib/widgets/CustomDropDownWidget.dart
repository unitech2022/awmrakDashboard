import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropDownWidget extends StatefulWidget {
  final List<DropdownMenuItem<Object>> list;
  final Function(dynamic) onSelect;
  final String hint;
  final bool hasType;
  final bool isTwoIcons;
  final IconData icon1;
  final IconData icon2;
  final  actionBtn;
  final Color colorBackRound;
  final Color iconColor, textColor;
  final dynamic currentValue;
  final bool selectCar;

  const CustomDropDownWidget(
      {this.selectCar = false,
        this.currentValue,
        required this.colorBackRound,
        required this.textColor,
        required this.iconColor,
        this.actionBtn,
        required this.icon2,
        required this.icon1,
        this.hasType=true,
        this.isTwoIcons = false,
        required this.list,
        required this.onSelect,
        required this.hint});

  @override
  _CustomDroopDownWidgetState createState() => _CustomDroopDownWidgetState();
}

class _CustomDroopDownWidgetState extends State<CustomDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            widget.isTwoIcons
                ? Icon(
              widget.icon1,
              color: widget.iconColor,
            )
                : SizedBox(),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                widget.hint,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "pnuR",
                  fontWeight: FontWeight.bold,
                  color: widget.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items:widget.list,
        value: widget.currentValue,
        onChanged: widget.onSelect,
        icon: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: widget.iconColor,
        ),
        iconSize: 18,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: double.infinity,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.colorBackRound,
        ),
        itemHeight: 40,
        // itemWidth: MediaQuery.of(context).size.width-40.0,
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color:widget.colorBackRound,
        ),
        dropdownElevation: 2,
        scrollbarRadius: const Radius.circular(30),
        scrollbarThickness: 4,
        scrollbarAlwaysShow: true,
        offset: Offset(0,-5),
      ),

    );
  }
}
