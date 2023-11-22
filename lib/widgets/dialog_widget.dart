import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../style/themes.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget(
      {super.key,
      this.txtTitle = '',
      this.txtMessage = '',
      this.textBtnAccept = 'Accept',
      this.textBtnCancel = 'Cancel',
      this.showCancelButton = true});

  final String txtTitle;
  final String txtMessage;
  final String textBtnAccept;
  final String textBtnCancel;

  final bool showCancelButton;

  final double latMargin = 12.0;
  final double topMargin = 20.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      child: _dialogContent(context),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _titleText(context),
            _messageText(context),
          ],
        ),
        _buttons(context),
      ],
    );
  }

  Widget _titleText(BuildContext context) {
    return Visibility(visible: txtTitle.isNotEmpty, child: Padding(
      padding: const EdgeInsets.only(top:10),
      child: txtTitle.setTextTitleThemeSmall(context),
    ));
  }

  Widget _messageText(BuildContext context) {
    return Visibility(
        visible: txtMessage.isNotEmpty,
        child: Padding(
          padding: EdgeInsets.only(top: topMargin, bottom: topMargin),
          child: txtMessage.setTextThemeMedium(context),
        ));
  }

  Widget _buttons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Visibility(
          visible: showCancelButton,
          child: Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: _buttonSingleCancel(context, textBtnCancel),
            ),
          ),
        ),
        Visibility(
          visible: showCancelButton,
          child: SizedBox(
            width: 1,
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(true);
          },
          child: _buttonSingleAccept(context, textBtnAccept),
        )),
      ],
    );
  }

  Widget _buttonSingleCancel(BuildContext context, String title) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColorPalette.primary,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(0))),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: title.setTextThemeButton(context),
      ),
    );
  }

  Widget _buttonSingleAccept(BuildContext context, String title) {
    var radiosRight = showCancelButton ? const Radius.circular(10) : const Radius.circular(10);
    var radiosLeft = showCancelButton ? const Radius.circular(0) : const Radius.circular(10);
    return Container(
      decoration: BoxDecoration(
          color: AppColorPalette.primary,
          borderRadius: BorderRadius.only(bottomLeft: radiosLeft, bottomRight: radiosRight)),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: title.setTextThemeButton(context),
      ),
    );
  }
}
