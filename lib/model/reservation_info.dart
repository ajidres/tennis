import 'dart:convert';

class ReservationList {
  List<ReservationInfo> reservation;

  ReservationList(this.reservation);

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "reservation": List<dynamic>.from(reservation.map((x) => x.toJson())),
      };

  factory ReservationList.fromRawJson(String str) => ReservationList.fromJson(json.decode(str));

  factory ReservationList.fromJson(Map<String, dynamic> json) => ReservationList(
        json["reservation"] == null
            ? []
            : List<ReservationInfo>.from(json["reservation"]!.map((x) => ReservationInfo.fromJson(x))),
      );
}

class ReservationInfo {
  String court;
  String date;
  String nameReservation;
  int dateInt;

  ReservationInfo({this.court = '', this.date = '', this.nameReservation = '', this.dateInt = 0});

  factory ReservationInfo.fromRawJson(String str) => ReservationInfo.fromJson(json.decode(str));

  factory ReservationInfo.fromJson(Map<String, dynamic> json) =>
      ReservationInfo(court: json["court"], date: json["date"], nameReservation: json["nameReservation"], dateInt: json["dateInt"]);

  Map<String, dynamic> toJson() =>
      {"court": court, "date": date, "nameReservation": nameReservation, "dateInt": dateInt};
}
