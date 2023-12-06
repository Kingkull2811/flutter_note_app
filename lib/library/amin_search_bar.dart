import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AminSearchBar extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String lableText;
  final int animationDurationInMilli;
  final Function() onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final Function(int) searchBarOpen;

  const AminSearchBar({
    Key? key,
    required this.width,
    this.height = 100.0,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.lableText = 'Search...',
    this.animationDurationInMilli = 375,
    required this.onSuffixTap,
    this.rtl = false,
    this.autoFocus = false,
    this.style,
    this.closeSearchOnSuffixTap = false,
    this.color = Colors.white,
    this.textFieldColor = Colors.white,
    this.searchIconColor = Colors.grey,
    this.textFieldIconColor = Colors.black,
    this.inputFormatters,
    this.boxShadow = true,
    required this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    required this.searchBarOpen,
  }) : super(key: key);

  @override
  State<AminSearchBar> createState() => _AminSearchBarState();
}

///toggle - 0 => false or closed
///toggle 1 => true or open
int toggle = 0;

/// * use this variable to check current text from OnChange
String textFieldValue = '';

class _AminSearchBarState extends State<AminSearchBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: widget.animationDurationInMilli));
  }

  void unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: widget.rtl ? Alignment.centerRight : const Alignment(-1.0, 0.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: widget.height,
        width: (toggle == 0) ? 48.0 : widget.width,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: toggle == 1 ? widget.textFieldColor : widget.color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: !widget.boxShadow ? null : [const BoxShadow(color: Colors.black26, spreadRadius: -10, blurRadius: 10, offset: Offset(0.0, 10.0))],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 6.0,
              right: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: toggle == 0 ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(30)),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, widget) => Transform.rotate(
                      angle: _controller.value * 2.0 * pi,
                      child: widget,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        try {
                          widget.onSuffixTap;
                          if (textFieldValue == '') {
                            unfocusKeyboard();
                            setState(() => toggle = 0);
                            _controller.reverse();
                          }

                          widget.controller.clear();
                          textFieldValue = '';

                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() => toggle = 0);
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        }
                      },
                      child: widget.suffixIcon ?? Icon(Icons.close, size: 20, color: widget.textFieldIconColor),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: toggle == 0 ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: 11.0,
              child: AnimatedOpacity(
                opacity: toggle == 0 ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topCenter,
                  width: widget.width / 1.7,
                  child: TextField(
                    controller: widget.controller,
                    inputFormatters: widget.inputFormatters,
                    focusNode: focusNode,
                    textInputAction: widget.textInputAction,
                    cursorRadius: const Radius.circular(10.0),
                    cursorWidth: 2.0,
                    cursorColor: Colors.black,
                    onChanged: (v) => textFieldValue = v,
                    onSubmitted: (v) => {
                      widget.onSubmitted(v),
                      unfocusKeyboard(),
                      setState(() => toggle = 0),
                      widget.controller.clear(),
                    },
                    onEditingComplete: () {
                      unfocusKeyboard();
                      setState(() => toggle = 0);
                    },
                    style: widget.style ?? const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: widget.lableText,
                      labelStyle: const TextStyle(color: Color(0xFF5B5B5B), fontSize: 17, fontWeight: FontWeight.w500),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ),

            ///Using material widget here to get the ripple effect on the prefix icon
            Material(
              color: toggle == 0 ? widget.color : widget.textFieldColor,
              borderRadius: BorderRadius.circular(30),
              child: IconButton(
                onPressed: () {
                  ///if the search bar is closed
                  setState(() {
                    if (toggle == 0) {
                      toggle = 1;
                      setState(() {
                        ///if the autoFocus is true, the keyboard will pop open, automatically
                        if (widget.autoFocus) FocusScope.of(context).requestFocus(focusNode);
                      });

                      ///forward == expand
                      _controller.forward();
                    } else {
                      ///if the search bar is expanded
                      toggle = 0;

                      ///if the autoFocus is true, the keyboard will close, automatically
                      setState(() {
                        if (widget.autoFocus) unfocusKeyboard();
                      });

                      ///reverse == close
                      _controller.reverse();
                    }
                  });

                  widget.searchBarOpen(toggle);
                },
                splashRadius: 20.0,
                icon: widget.prefixIcon != null
                    ? toggle == 1
                        ? Icon(Icons.arrow_back_ios, color: widget.textFieldIconColor)
                        : widget.prefixIcon!
                    : Icon(toggle == 1 ? Icons.arrow_back_ios : Icons.search, color: toggle == 0 ? widget.searchIconColor : widget.textFieldIconColor, size: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
