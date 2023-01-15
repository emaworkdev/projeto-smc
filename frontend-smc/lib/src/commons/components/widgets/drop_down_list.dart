import 'package:flutter/material.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';

// ignore: must_be_immutable
class DropDownList extends StatefulWidget {
  List<SelectedListItem> lista;
  String title;
  String hint;
  IconData icon;
  DropDownList(
      {super.key,
      required this.lista,
      required this.title,
      this.hint = '',
      this.icon = FontAwesomeIcons.arrowUp});

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        return _mainBody();
      },
    );
  }

  /// This is Main Body widget.
  Widget _mainBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          title: widget.title,
          hint: widget.hint,
          isSelected: true,
          lists: widget.lista,
          icon: widget.icon,
        ),
      ],
    );
  }
}

/// This is Common App textfiled class.
class AppTextField extends StatefulWidget {
  final String title;
  final String hint;
  final bool isSelected;
  final List<SelectedListItem>? lists;
  final IconData icon;

  const AppTextField({
    required this.title,
    required this.hint,
    required this.isSelected,
    this.lists,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        bottomSheetTitle: Text(
          widget.hint,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: ThemeProvider.instance.isDarkTheme
                ? Colors.white
                : Colors.black,
          ),
        ),
        submitButtonChild: const Text(
          'OK',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.lists ?? [],
        dropDownBackgroundColor:
            ThemeProvider.instance.isDarkTheme ? bgColor : Colors.blueGrey,
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
            }
          }
          showSnackBar(list.toString());
        },
        enableMultipleSelection: true,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        FocusScope.of(context).unfocus();
        onTextFieldTap();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor:
            ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black,
        textStyle: const TextStyle(
          fontSize: 16, //Set font size
        ),
        side: BorderSide(
          color: ThemeProvider.instance.isDarkTheme
              ? Colors.green
              : Colors.black38,
          width: 2,
        ),
        padding:
            const EdgeInsets.all(20.0), //Set the padding on all sides to 20px
      ),
      icon: Icon(widget.icon), //Button icon
      label: Text(" ${widget.title}"),
    );
  }
}
