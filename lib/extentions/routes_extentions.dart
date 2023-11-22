import 'package:flutter/material.dart';
import '../features/home/home_page.dart';
import '../features/reservation/tennis_court_reservation_page.dart';

extension RoutesExtention on String {
  navigate(BuildContext context, {dynamic argument}) async {
    switch (this) {
      case TennisCourtReservationPage.tennisCourtReservation:
        await Navigator.of(context).pushNamed(this, arguments: argument);
    }
  }
}

Map<String, WidgetBuilder> routesList() => {
      HomePage.home: (context) => const HomePage(),
      TennisCourtReservationPage.tennisCourtReservation: (context) => const TennisCourtReservationPage()
    };
