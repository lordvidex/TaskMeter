import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_back_button.dart';
import '../create_task_group/custom_text_form_field.dart';
import 'settings_button.dart';

class SettingsOptionScreen<T> extends StatefulWidget {
  final String title;
  final Iterable<T> options;
  final T current;
  final String Function(T) valueToString;
  final Set<T> fullRowButtons;
  final Function(T) update;
  final bool hasCustomButton;
  const SettingsOptionScreen({
    @required this.title,
    @required this.options,
    @required this.current,
    @required this.update,
    this.fullRowButtons,
    this.hasCustomButton = false,
    this.valueToString,
  });

  @override
  _SettingsOptionScreenState<T> createState() =>
      _SettingsOptionScreenState<T>();
}

class _SettingsOptionScreenState<T> extends State<SettingsOptionScreen<T>> {
  // the current selected option
  T current;
  // the list of all options
  List<T> options;
  // state for the activity of customButton
  bool customButtonIsInactive = true;

  TextEditingController _customController;

  int _customValue;

  Widget _switchingWidget;

  @override
  void initState() {
    _customController = TextEditingController();
    _customValue = -1;
    current = widget.current;
    options = [...Set.of(widget.options)..add(current)];
    super.initState();
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    _switchingWidget = Expanded(
        child: customButtonIsInactive
            ? SettingsButton<int>(
                child: 'Custom',
                value: -1,
                isSelected: false,
                onPressed: () => setState(() {
                  current = -1 as T;
                  customButtonIsInactive = !customButtonIsInactive;
                }),
              )
            : CustomTextFormField.numbersOnly(
                context: context,
                hintText: widget.valueToString(100 as T),
                controller: _customController,
                onChanged: (x) =>
                    _customValue = int.tryParse(x.trim()) ?? _customValue,
                onSubmitted: (_) {
                  current = int.parse(_customController.text) as T;
                  _customController.clear();
                  widget.update(current);
                  options = [...Set.of(widget.options)..add(current)];
                  setState(() {
                    customButtonIsInactive = !customButtonIsInactive;
                  });
                },
                isDarkMode: Theme.of(context).brightness == Brightness.dark,
              ));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 48),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(),
                Padding(
                  padding: const EdgeInsets.only(top: 27.0, bottom: 35),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                _generateGrid()
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _generateGrid() {
    int maxCrossCount = 2;
    int currentCrossCount = 0;
    List<Widget> result = [];
    List<Widget> partial = [];
    for (var y in options) {
      final mWidget = Expanded(
          child: SettingsButton<T>(
              isSelected: y == current,
              child: widget.valueToString(y),
              onPressed: () {
                setState(() => current = y);
                widget.update(y);
              },
              value: y));

      if (currentCrossCount == maxCrossCount ||
          (widget.fullRowButtons?.contains(y) ?? false)) {
        result
          ..add(Row(
            children: partial,
            mainAxisSize: MainAxisSize.max,
          ))
          ..add(SizedBox(height: 16));

        // reset the rows
        partial = [];
        currentCrossCount = 0;

        // a full width button
        if (widget.fullRowButtons?.contains(y) ?? false) {
          result
            ..add(Row(
              children: [mWidget],
              mainAxisSize: MainAxisSize.max,
            ))
            ..add(SizedBox(height: 16));
          continue;
        }
      }
      if (currentCrossCount == 1) {
        partial.add(SizedBox(width: 16));
      }
      partial.add(mWidget);
      currentCrossCount++;
    }

    if (currentCrossCount == 1) {
      partial
        ..add(SizedBox(width: 16))
        ..add(widget.hasCustomButton
            ? _switchingWidget
            : Expanded(child: Container()));
    }
    result
      ..add(Row(
        children: partial,
        mainAxisSize: MainAxisSize.max,
      ))
      ..add(SizedBox(height: 16));

    if (currentCrossCount != 1 && widget.hasCustomButton)
      result.add(Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _switchingWidget,
          SizedBox(
            width: 16,
          ),
          Expanded(child: Container())
        ],
      ));
    return Column(
      children: result,
    );
  }
}
