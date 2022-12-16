import 'package:flutter/material.dart';
import 'package:home_services_app/components/favorite_service_component.dart';
import 'package:home_services_app/utils/colors.dart';

import '../models/service_provider_model.dart';

class FavouriteProvidersScreen extends StatefulWidget {
  const FavouriteProvidersScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteProvidersScreen> createState() => _FavouriteProvidersScreenState();
}

class _FavouriteProvidersScreenState extends State<FavouriteProvidersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Favorite Service Providers",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return FavoriteServiceComponent(
            index,
            serviceProviderModel: likedProviders[index % likedProviders.length],
          );
        },
      ),
    );
  }
}
