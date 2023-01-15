import 'package:flutter/material.dart';
import 'package:smc/src/commons/commons.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';

// ignore: must_be_immutable
class DropdrownCMP extends StatelessWidget {
  BuildContext context;
  List<String> list;
  String comparation;
  Function(String?) onChanged;
  String decorationTitle;
  String decorationHint;
  bool decorationPadding = true;
  double heigth;
  double width;
  DropdrownCMP({
    Key? key,
    required this.context,
    required this.list,
    required this.comparation,
    required this.onChanged,
    required this.decorationTitle,
    required this.decorationHint,
    required this.decorationPadding,
    this.heigth = 80,
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        return SizedBox(
          height: heigth,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(),
                ),
                fillColor: ThemeProvider.instance.isDarkTheme
                    ? bgColor
                    : Colors.black12,
                hintText: decorationHint,
                labelText: decorationTitle,
                prefixStyle: TextStyle(
                  color: ThemeProvider.instance.isDarkTheme
                      ? Colors.white
                      : Colors.black,
                ),
                labelStyle: TextStyle(
                  color: ThemeProvider.instance.isDarkTheme
                      ? Colors.white
                      : Colors.black,
                ),
                isDense: true,
                filled: true,
                contentPadding: decorationPadding
                    ? const EdgeInsets.symmetric(vertical: 5, horizontal: 15)
                    : null,
              ),
              child: DropDownWidget.getDropDownButton(
                comparation,
                (newValue) {
                  onChanged(newValue);
                },
                list,
              ),
            ),
          ),
        );
      },
    );
  }
}


/*
class DropdrownCMP extends StatelessWidget {
  const DropdrownCMP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.lightGreen, //background color of dropdown button
          border: Border.all(
              color: Colors.black38, width: 3), //border of dropdown button
          borderRadius:
              BorderRadius.circular(50), //border raiuds of dropdown button
          boxShadow: const <BoxShadow>[
            //apply shadow on Dropdown button
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 5) //blur radius of shadow
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: DropdownButton(
          value: "United Kingdom",
          items: const [
            //add items in the dropdown
            DropdownMenuItem(
              value: "United Kingdom",
              child: Text("United Kingdom"),
            ),
            DropdownMenuItem(value: "Canada", child: Text("Canada")),
            DropdownMenuItem(
              value: "Russia",
              child: Text("Russia"),
            )
          ],
          onChanged: (value) {
            //get value when changed
            // ignore: avoid_print
            print("You have selected $value");
          },
          icon: const Padding(
              //Icon at tail, arrow bottom is default icon
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.arrow_circle_down_sharp)),
          iconEnabledColor: Colors.white, //Icon color
          style: const TextStyle(
              //te
              color: Colors.white, //Font color
              fontSize: 20 //font size on dropdown button
              ),

          dropdownColor: Colors.redAccent, //dropdown background color
          underline: Container(), //remove underline
          isExpanded: true, //make true to make width 100%
        ),
      ),
    );
  }
}
*/