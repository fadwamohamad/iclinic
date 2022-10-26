import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import '../../awesome_dialog.dart';

class FlareHeader extends StatelessWidget {
  const FlareHeader({
    Key? key,
    required this.dialogType,
    required this.loop,
  }) : super(key: key);

  final DialogType dialogType;
  final bool loop;

  @override
  Widget build(BuildContext context) {
    switch (dialogType) {
      case DialogType.INFO:
        return FlareActor(
          'assets/flare/info2.flr',
          fit: BoxFit.cover,
          animation: loop ? 'appear_loop' : 'appear',
          callback: (String call) {},
        );
      case DialogType.INFO_REVERSED:
        return FlareActor(
          loop
              ? 'assets/flare/info.flr'
              : 'assets/flare/info_without_loop.flr',
          fit: BoxFit.cover,
          animation: 'appear',
        );
      case DialogType.QUESTION:
        return FlareActor(
          'assets/flare/question.flr',
          fit: BoxFit.cover,
          animation: loop ? 'anim_loop' : 'anim',
          callback: (String call) {},
        );
      case DialogType.WARNING:
        return FlareActor(
          loop
              ? 'assets/flare/warning.flr'
              : 'assets/flare/warning_without_loop.flr',
          fit: BoxFit.cover,
          animation: 'appear',
        );
      case DialogType.ERROR:
        return FlareActor(
          'assets/flare/error.flr',
          fit: BoxFit.fill,
          animation: loop ? 'Error' : 'Error_no_loop',
        );
      case DialogType.SUCCES:
        return FlareActor(
          loop
              ? 'assets/flare/succes.flr'
              : 'assets/flare/succes_without_loop.flr',
          fit: BoxFit.fill,
          animation: 'Untitled',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
