part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeData extends HomeState {
  final List<ReservationInfo> data;
  final int rain;

  HomeData(this.data, this.rain);

}

class HomeWeather extends HomeState {
  final int rain;

  HomeWeather(this.rain);

}
