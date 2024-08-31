import 'package:flutter/material.dart';
import '../../global_key.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const settings = Center(
      child: Text(
        'Settings',
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
    return const Column(children: [
      settings,
      Dialogs(),
    ]);
    // return const Center(
    //   child: Text(
    //     'Settings',
    //     style: TextStyle(
    //         color: Colors.white
    //     ),
    //   ),
    // );
  }
}


class Dialogs extends StatefulWidget {
  const Dialogs({super.key});

  @override
  State<Dialogs> createState() => _DialogsState();
}

class _DialogsState extends State<Dialogs> {
  void openDialog(BuildContext context) {
    openedDialog = 'dialog';

    showDialog<void>(
      context: context,
      builder: (context) => 
      PopScope(
        child: AlertDialog(
          key: GlobalKey(debugLabel: 'dialog'),
          title: const Text('What is a dialog?'),
          content: const Text(
              'A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FilledButton(
              child: const Text('Okay'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        onPopInvoked: (didPop) {
          print('onPopInvoked');
          print('didPop: $didPop');
          if (didPop) {
            print('Dialog was dismissed');
            openedDialog = '';
          }
        },
      )
    );
  }

  void openFullscreenDialog(BuildContext context) {
    openedDialog = 'fullscreenDialog';
    showDialog<void>(
      context: context,
      builder: (context) => 
      PopScope(
        child: 
        Dialog.fullscreen(
          key: GlobalKey(debugLabel: 'fullscreenDialog'),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Full-screen dialog'),
                centerTitle: false,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        ),
        onPopInvoked: (didPop) {
          print('onPopInvoked');
          print('didPop: $didPop');
          if (didPop) {
            print('Dialog was dismissed');
            openedDialog = '';
          }
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Dialog',
      tooltipMessage:
          'Use showDialog with Dialog.fullscreen, AlertDialog, or SimpleDialog',
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          TextButton(
            child: const Text(
              'Show dialog',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => openDialog(context),
          ),
          TextButton(
            child: const Text(
              'Show full-screen dialog',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => openFullscreenDialog(context),
          ),
        ],
      ),
    );
  }
}

class ComponentDecoration extends StatefulWidget {
  const ComponentDecoration({
    super.key,
    required this.label,
    required this.child,
    this.tooltipMessage = '',
  });

  final String label;
  final Widget child;
  final String? tooltipMessage;

  @override
  State<ComponentDecoration> createState() => _ComponentDecorationState();
}

const smallSpacing = 10.0;
const double widthConstraint = 450;

class _ComponentDecorationState extends State<ComponentDecoration> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: smallSpacing),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.label,
                    style: Theme.of(context).textTheme.titleSmall),
                Tooltip(
                  message: widget.tooltipMessage,
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(Icons.info_outline, size: 16)),
                ),
              ],
            ),
            ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(width: widthConstraint),
              // Tapping within the a component card should request focus
              // for that component's children.
              child: Focus(
                focusNode: focusNode,
                canRequestFocus: true,
                child: GestureDetector(
                  onTapDown: (_) {
                    focusNode.requestFocus();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 20.0),
                      child: Center(
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
