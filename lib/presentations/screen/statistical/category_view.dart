import 'package:flutter/material.dart';

import 'package:personal_manager/presentations/common/colors.dart' as colors;

import '../../components/appbar_radius.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarRadius(
        height: 120,
        child: Text(
          'Category'.toUpperCase(),
          style: const TextStyle(
              color: colors.defaultColor1, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
