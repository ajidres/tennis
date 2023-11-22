import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tenniscourt/style/themes.dart';

import '../../style/colors.dart';
import '../../widgets/dialog_widget.dart';
import 'bloc/reservation_cubit.dart';

class DialogCourtReservationPage extends StatefulWidget {
  final String courtName;

  const DialogCourtReservationPage({super.key, this.courtName = ''});

  @override
  State<DialogCourtReservationPage> createState() => _DialogCourtReservationPageState();
}

class _DialogCourtReservationPageState extends State<DialogCourtReservationPage> {
  final _today = DateTime.now();
  var _selectedDay = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  var _allowReservation = true;
  final TextEditingController _inputUser = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReservationCubit>(
      lazy: false,
      create: (context) => ReservationCubit(_today, widget.courtName),
      child: Dialog(
        child: SingleChildScrollView(
          child: _dialogContent(context),
        ),
      ),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: 'Select the day for your reservation'.setTextThemeMedium(context),
        ),
        _calendar(context),
        _nameForReservation(context),
        _buttons(context),
      ],
    );
  }

  Widget _nameForReservation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          decoration: getInputDecorator(context, hint: 'Please enter a name for reservation'),
          style: const TextStyle().textThemeMedium(context),
          maxLength: 20,
          validator: (String? value) {
            return _validateUser(_inputUser.value.text) || _inputUser.value.text.isEmpty
                ? null
                : 'Error, please enter a valid name';
          },
          controller: _inputUser,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }

  Widget _calendar(BuildContext context) {
    return BlocConsumer<ReservationCubit, ReservationState>(listener: (context, state) {
      if (state is ReservationDayAvailable) {
        _allowReservation = state.available;
        if (!state.available) _showNotAvailability(context);
      }
      if (state is ReservationSaved) Navigator.of(context).pop();
    }, builder: (context, state) {
      return TableCalendar(
        firstDay: _today,
        lastDay: DateTime.utc(_today.year, _today.month + 1, 30),
        focusedDay: _selectedDay,
        currentDay: _selectedDay,
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: true,
          todayDecoration:
              BoxDecoration(color: AppColorPalette.secondary),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          context.read<ReservationCubit>().validateDate(selectedDay, widget.courtName);
          setState(() {
            _selectedDay = selectedDay;
          });
        },
      );
    });
  }

  Widget _buttons(BuildContext context) {
    return BlocConsumer<ReservationCubit, ReservationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: _buttonSingle(context, 'Cancel', true),
              )),
              SizedBox(
                width: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (_validateUser(_inputUser.value.text) && _allowReservation) {
                    context
                        .read<ReservationCubit>()
                        .scheduleCourt(_selectedDay, widget.courtName, _inputUser.value.text);
                  }
                },
                child: _buttonSingle(context, 'Schedule', false),
              )),
            ],
          );
        });
  }

  Widget _buttonSingle(BuildContext context, String title, bool left) {
    var radiosRight = left ? const Radius.circular(0) : const Radius.circular(10);
    var radiosLeft = left ? const Radius.circular(10) : const Radius.circular(0);
    return Container(
      decoration: BoxDecoration(
          color: left?AppColorPalette.secondary:AppColorPalette.primary,
          borderRadius: BorderRadius.only(bottomLeft: radiosLeft, bottomRight: radiosRight)),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: title.setTextThemeButton(context),
      ),
    );
  }
}

void _showNotAvailability(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DialogWidget(
          txtTitle: 'Availability',
          txtMessage: 'No availability for reservation today',
          showCancelButton: false,
        );
      });
}

bool _validateUser(String data) {
  return data.isNotEmpty && data.length > 5;
}
