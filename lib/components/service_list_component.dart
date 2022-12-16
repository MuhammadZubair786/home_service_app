import 'package:flutter/material.dart';
import 'package:home_services_app/custom_widget/space.dart';
import 'package:home_services_app/models/common_model.dart';
import 'package:home_services_app/screens/provider_review_screen.dart';

class ServiceListComponent extends StatelessWidget {
  final CommonModel? commonModel;
  final int? index;

  ServiceListComponent({this.commonModel, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProviderReview(index: index!)),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 180,
                  height: 100,
                  child: Image.asset(commonModel!.imagePath!, fit: BoxFit.cover),
                )),
            Space(4),
            Text(
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              commonModel!.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
