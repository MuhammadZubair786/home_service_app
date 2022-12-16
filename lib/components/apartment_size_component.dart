import 'package:flutter/material.dart';
import 'package:home_services_app/main.dart';
import 'package:home_services_app/models/apartment_size_model.dart';
import 'package:home_services_app/utils/colors.dart';

class ApartmentSizeComponent extends StatefulWidget {
  @override
  _ApartmentSizeComponentState createState() => _ApartmentSizeComponentState();
}

class _ApartmentSizeComponentState extends State<ApartmentSizeComponent> {
  String selectedBHK = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      runSpacing: 8,
      spacing: 8,
      children: List.generate(
        apartmentSizeList.length,
        (index) => GestureDetector(
          onTap: () {
            for (var i = 0; i < apartmentSizeList.length; i++) {
              if (i == index) {
                apartmentSizeList[i].isSelected = true;
                selectedBHK = apartmentSizeList[i].size;
              } else {
                apartmentSizeList[i].isSelected = false;
              }
              setState(() {});
            }
          },
          child: Card(
            color: appData.isDark
                ? apartmentSizeList[index].isSelected
                    ? selectedCard
                    : greyColor
                : apartmentSizeList[index].isSelected
                    ? selectedCard
                    : unselectedCard,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                apartmentSizeList[index].size,
                style: TextStyle(color: apartmentSizeList[index].isSelected ? whiteColor : blackColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
