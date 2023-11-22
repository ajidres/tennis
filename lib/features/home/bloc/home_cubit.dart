import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../model/reservation_info.dart';
import '../../../model/wheather_info.dart';
import '../../reservation/bloc/reservation_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late SharedPreferences prefs;
  late ReservationList reservationList;

  late int rainPercentage;

  HomeCubit() : super(HomeInitial()) {
    initVar();
  }



  Future<void> initVar() async {
    prefs = await SharedPreferences.getInstance();
    String reservationSaved = prefs.getString(reservationSave) ?? '';
    if (reservationSaved.isEmpty) {
      reservationList = ReservationList([]);
    } else {
      reservationList = ReservationList.fromRawJson(reservationSaved);
    }

    reservationList.reservation.sort((a, b) => a.dateInt.compareTo(b.dateInt));

    getForecast();
  }

  void deleteReservation(int pos){
    reservationList.reservation.removeAt(pos);
    String listToJson = reservationList.toRawJson();
    prefs.setString(reservationSave, listToJson);
    emit(HomeData(reservationList.reservation, rainPercentage));

  }


  Future<void> getForecast() async {
    try {

      String api = 'https://api.openweathermap.org/data/2.5/weather';
      String url = '$api?lat=10.99&lon=44.34&appid=${dotenv.env['WEATHER_KEY']}';

      final response = await http.get(Uri.parse(url));
      final weather = Weather.fromJson(jsonDecode(response.body));
      // emit(HomeWeather(weather.main!.humidity!));

      rainPercentage = weather.main!.humidity!;

      emit(HomeData(reservationList.reservation, rainPercentage));
    } catch (e) {
      rethrow;
    }
  }

}
