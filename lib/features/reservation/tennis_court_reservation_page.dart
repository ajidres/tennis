import 'package:flutter/material.dart';
import 'package:tenniscourt/style/themes.dart';
import 'package:tenniscourt/widgets/appbar_widget.dart';

import '../../extentions/image_extentions.dart';
import 'dialog_reservation_widget.dart';

const courtA = 'Court A';
const courtB = 'Court B';
const courtC = 'Court C';

class TennisCourtReservationPage extends StatelessWidget {
  static const tennisCourtReservation = '/tennisCourtReservation';

  const TennisCourtReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(
        title: 'Court selection',
        showBack: true,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    double latMargin = 8;

    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: [
        _courtCard(context, Images.courtA.key, courtA),
        _courtCard(context, Images.courtB.key, courtB),
        _courtCard(context, Images.courtC.key, courtC)
      ],
    );
  }

  Widget _courtCard(BuildContext context, String image, String name) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogCourtReservationPage(courtName: name);
                });
          },
          child: Card(
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  height: 200,
                ),
              ),
              Center(
                child: name.setTextThemeCard(context),
              )
            ]),
          ),
        ));
  }
}
