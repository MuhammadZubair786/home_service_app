import 'package:flutter/material.dart';
import 'package:home_services_app/screens/active_bookings_screen.dart';
import 'package:home_services_app/screens/booking_history_screen.dart';
import 'package:home_services_app/utils/colors.dart';

class BookingsFragment extends StatefulWidget {
  final bool fromProfile;

  const BookingsFragment({Key? key, required this.fromProfile}) : super(key: key);

  @override
  State<BookingsFragment> createState() => _BookingsFragmentState();
}

class _BookingsFragmentState extends State<BookingsFragment> with SingleTickerProviderStateMixin {
  late TabController bookingTabController = TabController(length: 2, vsync: this, initialIndex: 0);

  @override
  void dispose() {
    super.dispose();
    bookingTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        leading: Visibility(
          visible: widget.fromProfile ? true : false,
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Bookings",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        bottom: TabBar(
          controller: bookingTabController,
          labelStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          indicatorColor: blackColor,
          tabs: [
            Tab(text: "Active"),
            Tab(text: "History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: bookingTabController,
        children: [
          ActiveBookingsScreen(),
          BookingHistoryScreen(),
        ],
      ),
    );
  }
}
