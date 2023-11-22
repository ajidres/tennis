import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/reservation_info.dart';


part 'reservation_state.dart';

const reservationSave = 'reservationSave';

class ReservationCubit extends Cubit<ReservationState> {
  late SharedPreferences prefs;
  late ReservationList reservationList;
  late DateFormat dateFormat;

  ReservationCubit(DateTime date, String courtName) : super(ReservationInitial()) {
    initVar(date, courtName);

  }

  Future<void> initVar(DateTime date, String courtName) async {
    prefs = await SharedPreferences.getInstance();
    dateFormat = DateFormat('d/MM/y');
    String reservationSaved = prefs.getString(reservationSave) ?? '';
    if (reservationSaved.isEmpty) {
      reservationList = ReservationList([]);
    } else {
      reservationList = ReservationList.fromRawJson(reservationSaved);
    }

    validateDate(date, courtName);
  }

  void validateDate(DateTime date, String courtName) {
    var filterList = reservationList.reservation.where((r) => r.dateInt == date.millisecondsSinceEpoch
        && r.court == courtName).toList();
    emit(ReservationDayAvailable(filterList.length < 3));
  }

  void scheduleCourt(DateTime dateReservation, String courtName, String username) {
    final reservation =
        ReservationInfo(date: dateFormat.format(dateReservation),
            court: courtName, nameReservation: username, dateInt: dateReservation.millisecondsSinceEpoch);
    reservationList.reservation.add(reservation);
    String listToJson = reservationList.toRawJson();
    prefs.setString(reservationSave, listToJson);
    emit(ReservationSaved());
  }
}
