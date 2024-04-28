import 'package:csh_app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PinCodeTextField extends StatefulWidget {
  final int length;
  late dynamic callback;

  PinCodeTextField({required this.length,required this.callback});

  @override
  _PinCodeTextFieldState createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _controllers = List.generate(widget.length, (index) {
      TextEditingController controller = TextEditingController(text: '');
      controller.addListener(() {
        Future.microtask(() {
          if (!controller.text.isEmpty && index == 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (controller.text.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          } else if (controller.text.length == 1 && index < widget.length - 1) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (index == widget.length - 1 && controller.text.isNotEmpty) {
            // perform a final action for instance Focus the next widget.
            widget.callback(_controllers);
          }
        });
      });
      return controller;
    });
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < _controllers.length; i++) ...[
          Container(
            width: 46,
            margin: EdgeInsets.all(8),
            child: TextField(
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: MyTheme.textfield_grey, width: 0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: MyTheme.textfield_grey, width: 0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: MyTheme.accent_color, width: 0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)))),
              onChanged: (value) {
                if (value.length > 1) {
                  _controllers[i].text = value.substring(0, 1);
                }
              },
              onSubmitted: (_) {
                if (i < widget.length - 1) {
                  FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                }
              },
            ),
          ),
        ],
      ],
    );
  }
}
