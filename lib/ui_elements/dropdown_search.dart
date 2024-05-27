import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class DropdownSearch extends StatefulWidget {
  DropdownSearch({super.key, 
    required this.items,
    required this.tec,
  });

  final List<String> items;
  final TextEditingController tec;
  bool isPopupOpen = false;

  @override
  _DropdownSearchState createState() => _DropdownSearchState();
}

class _DropdownSearchState extends State<DropdownSearch> {
  late GlobalKey globalKey = GlobalKey();
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
    textFieldStreamController.add('');
    textFieldStream = textFieldStreamController.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    super.dispose();
  }

  updatePopupListFilter(String searchString, BuildContext context) {
    if (!widget.isPopupOpen) {
      _showOptionsPopup(
          context, globalKey, widget.items, widget.tec, textFieldStream, () {
        widget.isPopupOpen = false;
      });
      widget.isPopupOpen = true;
    }
    textFieldStreamController.add(searchString);
  }

  List<String> filteredOptions = [];

  StreamController<String> textFieldStreamController =
      StreamController<String>();
  late Stream<String> textFieldStream;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: TextFormField(
          key: globalKey,
          controller: widget.tec,
          onTap: () {
            updatePopupListFilter(widget.tec.text, context);
          },
          onChanged: (newString) {
            textFieldStreamController.add(newString);
            updatePopupListFilter(widget.tec.text, context);
          },
          decoration: const InputDecoration(
            isDense: true,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            suffixIcon: Icon(
              Icons.search_outlined,
              color: Colors.black,
              size: 24.0,
            ),
          ),
          // style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      )
    ]);
  }
}

_showOptionsPopup(
  BuildContext context,
  GlobalKey trackedObjectKey,
  List<String> content,
  TextEditingController tec,
  Stream<String> stream,
  Function close,
) {
  final RenderBox renderBox =
      trackedObjectKey.currentContext!.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final position = renderBox.localToGlobal(Offset.zero);
  double left = position.dx;
  double top = position.dy + size.height;

  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(builder: (context) {
    return Stack(
      children: [
        GestureDetector(
            onTap: () {
              overlayEntry.remove();
              close();
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            )),
        Positioned(
            top: top + 2,
            left: left,
            child: Material(
                color: Colors.transparent,
                child: Container(
                  key: UniqueKey(),
                  color: Colors.transparent,
                  width: size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: StreamBuilder(
                    stream: stream,
                    initialData: '',
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        List<String> filteredOptions = firstX(
                            6,
                            sortStringsToMatchTarget(
                                snapshot.data as String, content));
                        return ListOptionStringWidgets(
                          options: filteredOptions,
                          onSelectCallback: (stringValue) {
                            tec.text = stringValue;
                            overlayEntry.remove();
                            close();
                          },
                        );
                      }
                    },
                  ),
                ))),
      ],
    );
  });
  Overlay.of(context).insert(overlayEntry);
}

List<T> firstX<T>(int count, List<T> vals) {
  if (vals.length < count) {
    return vals;
  }
  List<T> ret = [];
  for (int i = 0; i < count; i++) {
    ret.add(vals[i]);
  }
  return ret;
}

class ListOptionStringWidgets extends StatefulWidget {
  const ListOptionStringWidgets({
    super.key,
    required this.options,
    required this.onSelectCallback,
  });

  final List<String> options;
  final Function(String) onSelectCallback;
  @override
  State<ListOptionStringWidgets> createState() =>
      _ListOptionStringWidgetsState();
}

class _ListOptionStringWidgetsState extends State<ListOptionStringWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        widget.options.length,
        (index) => GestureDetector(
          onTap: () => widget.onSelectCallback(widget.options[index]),
          child: ListTile(
              title: Text(widget.options[index]), tileColor: Colors.grey),
        ),
      ),
    );
  }
}

int measureStringSimilarity(String s, String t, {bool caseSensitive = false}) {
  return levenshteinStringSimilarity(
      s, t); //TODO: Add nicer search criteria. Levenshtein a bit underwhelming
}

int levenshteinStringSimilarity(String s, String t,
    {bool caseSensitive = false}) {
  if (!caseSensitive) {
    s = s.toLowerCase();
    t = t.toLowerCase();
  }
  if (s == t) return 0;
  if (s.isEmpty) return t.length;
  if (t.isEmpty) return s.length;

  List<int> v0 = List<int>.filled(t.length + 1, 0);
  List<int> v1 = List<int>.filled(t.length + 1, 0);

  for (int i = 0; i < t.length + 1; i < i++) {
    v0[i] = i;
  }

  for (int i = 0; i < s.length; i++) {
    v1[0] = i + 1;

    for (int j = 0; j < t.length; j++) {
      int cost = (s[i] == t[j]) ? 0 : 1;
      v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
    }

    for (int j = 0; j < t.length + 1; j++) {
      v0[j] = v1[j];
    }
  }

  return v1[t.length];
}

List<String> sortStringsToMatchTarget(String input, List<String> source) {
  List<Map<String, int>> valMap = [];
  for (int i = 0; i < source.length; i++) {
    valMap.add({source[i]: measureStringSimilarity(input, source[i])});
  }
  valMap.sort(
    (a, b) => a.values.first.compareTo(b.values.first),
  );
  return List<String>.generate(
      valMap.length, (index) => valMap[index].keys.first);
}