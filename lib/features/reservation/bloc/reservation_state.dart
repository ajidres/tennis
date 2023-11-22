part of 'reservation_cubit.dart';

@immutable
abstract class ReservationState {}

class ReservationInitial extends ReservationState {}

class ReservationDayAvailable extends ReservationState {
  final bool available;

  ReservationDayAvailable(this.available);

}

class ReservationSaved extends ReservationState {}
