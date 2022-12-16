import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:home_services_app/components/combos_subscriptions_component.dart';
import 'package:home_services_app/components/customer_review_component.dart';
import 'package:home_services_app/components/home_contruction_component.dart';
import 'package:home_services_app/components/home_service_component.dart';
import 'package:home_services_app/components/popular_service_component.dart';
import 'package:home_services_app/components/renovate_home_component.dart';
import 'package:home_services_app/fragments/bookings_fragment.dart';
import 'package:home_services_app/models/customer_details_model.dart';
import 'package:home_services_app/screens/notification_screen.dart';
import 'package:home_services_app/screens/service_providers_screen.dart';
import 'package:home_services_app/screens/sign_in_screen.dart';
import 'package:home_services_app/utils/images.dart';
import 'package:home_services_app/utils/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../custom_widget/space.dart';
import '../main.dart';
import '../models/customer_review_model.dart';
import '../models/services_model.dart';
import '../screens/all_categories_screen.dart';
import '../screens/favourite_services_screen.dart';
import '../screens/my_profile_screen.dart';
import '../utils/colors.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  double aspectRatio = 0.0;
  List<String> bannerList = [banner1, banner2, banner];

  final offerPagesController = PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);
  final reviewPagesController = PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);

  @override
  void dispose() {
    offerPagesController.dispose();
    reviewPagesController.dispose();
    super.dispose();
  }

  Future<void> _showLogOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to Logout?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      appBar: AppBar(
        title: Image.network("https://i.ibb.co/HKg91fS/logo1.png" ,height: 50,width: 500,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        iconTheme: IconThemeData(size: 30),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          Observer(
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Switch(
                  value: appData.isDark,
                  onChanged: (value) {
                    setState(() {
                      appData.toggle();
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
              color: appData.isDark ? Colors.black : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "J",
                      style: TextStyle(fontSize: 24.0, color: appData.isDark ? Colors.black : whiteColor),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appData.isDark ? whiteColor : Colors.black,
                    ),
                  ),
                  Space(4),
                  Text(
                    getName,
                    style: TextStyle(fontSize: 18, color: appData.isDark ? whiteColor : Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Space(4),
                  Text(getEmail, style: TextStyle(color: secondaryColor)),
                ],
              ),
            ),
            drawerWidget(
              drawerTitle: "My Profile",
              drawerIcon: Icons.person,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "My Favourites",
              drawerIcon: Icons.favorite,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteProvidersScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "Notifications",
              drawerIcon: Icons.notifications,
              drawerOnTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "My bookings",
              drawerIcon: Icons.calendar_month,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingsFragment(fromProfile: true)),
                );
              },
            ),
            drawerWidget(
              drawerTitle: "Refer and earn",
              drawerIcon: Icons.paid_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Contact Us",
              drawerIcon: Icons.mail,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Help Center",
              drawerIcon: Icons.question_mark_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Logout",
              drawerIcon: Icons.logout,
              drawerOnTap: () {
                Navigator.pop(context);
                _showLogOutDialog();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontSize: 17),
                  decoration: commonInputDecoration(
                    suffixIcon: Icon(Icons.search, size: 20, color: appData.isDark ? Colors.white : Colors.black),
                    hintText: "Search for services",
                  ),
                ),
              ),
            ),
            Space(16),
            SizedBox(
              height: 170,
              child: PageView.builder(
                controller: offerPagesController,
                itemCount: bannerList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ServiceProvidersScreen(index: index)),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(bannerList[index], fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: offerPagesController,
              count: 3,
              effect: ExpandingDotsEffect(
                dotHeight: 7,
                dotWidth: 8,
                activeDotColor: appData.isDark ? Colors.white : Colors.black,
                expansionFactor: 2.2,
              ),
            ),
            Space(8),
            homeTitleWidget(
              titleText: "Home Services",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(list: serviceProviders, fromProviderDetails: false),
                  ),
                );
              },
            ),
            HomeServiceComponent(),
            Space(16),
            // homeTitleWidget(
            //   titleText: "Home Construction",
            //   onAllTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => AllCategoriesScreen(list: serviceProviders, fromProviderDetails: false),
            //       ),
            //     );
            //   },
            // ),
            // HomeConstructionComponent(),
            Space(16),
            homeTitleWidget(
              titleText: "Popular Services",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(list: serviceProviders, fromProviderDetails: false),
                  ),
                );
              },
            ),
            Space(4),
            PopularServiceComponent(),
            Space(24),
            homeTitleWidget(
              titleText: "Renovate your home",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(list: serviceProviders, fromProviderDetails: false),
                  ),
                );
              },
            ),
            Space(4),
            RenovateHomeComponent(),
            Space(24),
            homeTitleWidget(
              titleText: "Combos And Subscriptions",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(list: serviceProviders, fromProviderDetails: false),
                  ),
                );
              },
            ),
            Space(4),
            CombosSubscriptionsComponent(),
            Space(32),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "What our customers say",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ),
            ),
            Space(16),
            SizedBox(
              height: 117,
              child: PageView.builder(
                itemCount: customerReviews.length,
                controller: reviewPagesController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CustomerReviewComponent(customerReviewModel: customerReviews[index]);
                },
              ),
            ),
            Space(16),
            SmoothPageIndicator(
              controller: reviewPagesController,
              count: customerReviews.length,
              effect: ScaleEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: appData.isDark ? Colors.white : activeDotColor,
                dotColor: Colors.grey.withOpacity(0.2),
              ),
            ),
            Space(16),
          ],
        ),
      ),
    );
  }
}
