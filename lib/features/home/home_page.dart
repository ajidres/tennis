import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenniscourt/extentions/routes_extentions.dart';
import 'package:tenniscourt/features/home/bloc/home_cubit.dart';
import 'package:tenniscourt/features/reservation/tennis_court_reservation_page.dart';
import 'package:tenniscourt/style/themes.dart';

import '../../extentions/image_extentions.dart';
import '../../model/reservation_info.dart';
import '../../style/colors.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/dialog_widget.dart';

class HomePage extends StatefulWidget {
  static const home = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      lazy: false,
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: AppBarMain(
          title: 'Tennis court',
          actions: _actionsAppBarIcon(context),
        ),
        body: _body(),
      ),
    );
  }

  List<Widget> _actionsAppBarIcon(BuildContext context) {
    return [
      BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.date_range),
          padding: EdgeInsets.zero,
          onPressed: () async {
            final value = await TennisCourtReservationPage.tennisCourtReservation.navigate(context);
            setState(() {
              context.read<HomeCubit>().initVar();
            });
          },
        );
      })
    ];
  }

  Widget _body() {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeData) {
        if (state.data.isEmpty) {
          return _emptyState();
        } else {
          return _viewData(context, (state.data));
        }
      } else {
        return _loading();
      }
    });
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColorPalette.secondary,
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.icon.key,
            fit: BoxFit.fill,
            height: 100,
            width: 100,
          ),
          'No reservations'.setTextThemeLarge(context)
        ],
      ),
    );
  }

  Widget _viewData(BuildContext context, List<ReservationInfo> data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ['Next games:'.setTextTitleThemeSmall(context), _rain(), _listGames(context, data)],
        ),
      ),
    );
  }

  Widget _rain() {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeData) {
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: 'The probability of rain for today is ${state.rain.toString()}%'.setTextThemeMediumBold(context),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _listGames(BuildContext context, List<ReservationInfo> data) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            _imageCourtWidget(context, data[index].court),
            Expanded(
                child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 190,
                          child: _reservationCourt(context, data[index].court, data[index].date)),
                      _separator(),
                      data[index].nameReservation.setTextThemeMedium(context),
                      _separator(),
                    ],
                  ),
                ),
              ],
            )),
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.delete_forever_outlined),
              padding: EdgeInsets.zero,
              color: Colors.red,
              onPressed: () {
                _deleteReservation(context, index);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _separator() {
    return const SizedBox(
      height: 8,
    );
  }

  Widget _imageCourtWidget(BuildContext context, String court) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            _imageCourt(court),
            fit: BoxFit.fill,
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }

  Widget _reservationCourt(BuildContext context, String court, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [court.setTextThemeMediumBold(context), date.setTextThemeMediumBold(context)],
    );
  }
}

String _imageCourt(String court) {
  switch (court) {
    case courtA:
      return Images.courtA.key;
    case courtB:
      return Images.courtB.key;
    case courtC:
      return Images.courtC.key;
    default:
      return '';
  }
}

Future<void> _deleteReservation(BuildContext context, int index) async {
  var delete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DialogWidget(
          txtTitle: 'Delete',
          txtMessage: 'Do you want to delete this reservation?',
          showCancelButton: true,
        );
      });

  if (delete) context.read<HomeCubit>().deleteReservation(index);
}
