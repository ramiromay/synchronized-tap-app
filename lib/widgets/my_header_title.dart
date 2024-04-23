import 'package:flutter/material.dart';

const headerTitle = 80.0;
typedef OnHeaderChange = void Function(bool visible);

class MyHeaderTitle extends SliverPersistentHeaderDelegate {

  final OnHeaderChange onHeaderChange;
  final String title;

  MyHeaderTitle({
    required this.title,
    required this.onHeaderChange,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // esta parte era diferente
    onHeaderChange(shrinkOffset > 0);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  double get maxExtent => headerTitle;

  @override
  double get minExtent => headerTitle;
}