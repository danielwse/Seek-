import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AddNote extends StatefulWidget {
  AddNote({Key key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  bool showFab = true;
  PersistentBottomSheetController bottomSheetController;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        mini: true,
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          bottomSheetController = showBottomSheet(
              context: context, builder: (context) => BottomSheetWidget());
          // bottomSheetController.closed.then((value) {
          // showFloatingActionButton(false);
          // });

          //bottomSheetController.close();
          // showFloatingActionButton(true);
        });
  }

  void showFloatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }
}

//widget inside the pop-up
class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 400,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.grey[300],
                        spreadRadius: 5)
                  ]),
              child: Column(children: [DecoratedTextField()]),
            )
          ]),
    ));
  }
}

class DecoratedTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close, size: 40)),
          Spacer(),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.check, size: 40)),
        ],
      ),
      //DemoToggleButtons(),
      Container(
        height: 200,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: TextField(
            maxLines: null,
            autocorrect: true,
            showCursor: true,
            maxLengthEnforced: true,
            maxLength: 300,
            textAlign: TextAlign.start,
            decoration: InputDecoration.collapsed(
              hintText: 'Encourage and Enrich!',
            )),
      ),
      ColorPicker()
    ]);
  }
}

class DemoToggleButtons extends StatefulWidget {
  @override
  _DemoToggleButtonsState createState() => _DemoToggleButtonsState();
}

class _DemoToggleButtonsState extends State<DemoToggleButtons> {
  List<bool> isSelected = [true, false];
  FocusNode focusNodeButton1 = FocusNode();
  FocusNode focusNodeButton2 = FocusNode();
  List<FocusNode> focusToggle;

  @override
  void initState() {
    super.initState();
    focusToggle = [focusNodeButton1, focusNodeButton2];
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNodeButton1.dispose();
    focusNodeButton2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        color: Colors.greenAccent,
        selectedColor: Colors.white,
        //fillColor: Colors.purple,
        // splashColor: Colors.lightBlue,
        // highlightColor: Colors.lightBlue,
        // borderColor: Colors.white,
        // borderWidth: 5,
        //selectedBorderColor: Colors.greenAccent,
        // renderBorder: true,
        borderRadius: BorderRadius.circular(10),
        disabledColor: Colors.blueGrey,
        disabledBorderColor: Colors.blueGrey,
        focusColor: Colors.red,
        focusNodes: focusToggle,
        children: <Widget>[
          Text("Anonymous", style: TextStyle(color: Colors.black)),
          Text("Username", style: TextStyle(color: Colors.black)),
        ],
        isSelected: isSelected,
        onPressed: (int index) {
          setState(() {
            for (int indexBtn = 0; indexBtn < isSelected.length; indexBtn++) {
              if (indexBtn == index) {
                isSelected[indexBtn] = true;
              } else {
                isSelected[indexBtn] = false;
              }
            }
          });
        });
  }
}

class ColorPicker extends StatefulWidget {
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  // Use temp variable to only update color when press dialog 'submit' button
  ColorSwatch _tempMainColor;

  ColorSwatch _mainColor = Colors.blue;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openMainColorPicker() async {
    _openDialog(
      "Select Color",
      MaterialColorPicker(
        selectedColor: _mainColor,
        allowShades: false,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 62.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlineButton(
                onPressed: _openMainColorPicker,
                child: const Text('Select Color'),
              ),
              SizedBox(width: 20),
              CircleAvatar(
                backgroundColor: _mainColor,
                radius: 25.0,
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ],
    );
  }
}