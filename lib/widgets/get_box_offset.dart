import 'package:flutter/material.dart';

class GetBoxOffSet extends StatefulWidget {

  final Widget child;
  final Function(Offset offset) offset;

  const GetBoxOffSet({
    super.key,
    required this.child,
    required this.offset,
  });

  @override
  State<GetBoxOffSet> createState() => _GetBoxOffSetState();
}

class _GetBoxOffSetState extends State<GetBoxOffSet> {

  GlobalKey widgetKey = GlobalKey();
  late Offset offset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = widgetKey.currentContext?.findRenderObject() as RenderBox;
      offset = box.localToGlobal(Offset.zero);
      widget.offset(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Aqui falta algo
    return SizedBox(
      key: widgetKey,
      child: widget.child,
    );
  }
}
