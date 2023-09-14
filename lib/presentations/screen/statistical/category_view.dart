import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:personal_manager/presentations/common/colors.dart' as colors;
import 'package:personal_manager/presentations/common/assets.dart' as assets;
import 'package:transformable_list_view/transformable_list_view.dart';
import '../../../logic_bussiness/home/category/bloc/category_bloc.dart';
import '../../components/appbar_radius.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

List<Color> colorsList = [
  colors.lavender,
  colors.honeyDrew,
  colors.pinkLake,
  colors.cornsilk,
  colors.cosmicLatte,
  colors.lavender,
  colors.honeyDrew,
  colors.pinkLake,
  colors.cornsilk,
  colors.cosmicLatte,
  colors.lavender,
  colors.honeyDrew,
  colors.pinkLake,
  colors.cornsilk,
  colors.cosmicLatte,
  colors.lavender,
  colors.honeyDrew,
  colors.pinkLake,
  colors.cornsilk,
  colors.cosmicLatte,
  colors.lavender,
  colors.honeyDrew,
  colors.pinkLake,
  colors.cornsilk,
  colors.cosmicLatte,
];
List<Color> colorText = [
  colors.violetsAreBlue,
  colors.inchworm,
  colors.brilliantRose,
  colors.pastelOrange,
  colors.googerBuster,
  colors.violetsAreBlue,
  colors.inchworm,
  colors.brilliantRose,
  colors.pastelOrange,
  colors.googerBuster,
  colors.violetsAreBlue,
  colors.inchworm,
  colors.brilliantRose,
  colors.pastelOrange,
  colors.googerBuster,
  colors.violetsAreBlue,
  colors.inchworm,
  colors.brilliantRose,
  colors.pastelOrange,
  colors.googerBuster,
  colors.violetsAreBlue,
  colors.inchworm,
  colors.brilliantRose,
  colors.pastelOrange,
  colors.googerBuster,
];

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
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategorySuccess) {
            return Scrollbar(
              child: TransformableListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                getTransformMatrix: getTransformMatrix,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    padding: EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorText[index]),
                      color: colorsList[
                          index] /* index.isEven ? Colors.grey : colors.honeyDrew */,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Image.asset(assets.kIconMoney),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                state.expensePurposeList[index].name ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: colorText[index],
                                ),
                              ),
                              Text(
                                'Chiếm ${state.expensePurposeList[index].totalExpense! / state.totalIncome.totalIncome! * 100}% thu nhập',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text('Đã sử dụng 50%'),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: state.expensePurposeList.length,
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Matrix4 getTransformMatrix(TransformableListItem item) {
    /// final scale of child when the animation is completed
    const endScaleBound = 0.5;

    /// 0 when animation completed and [scale] == [endScaleBound]
    /// 1 when animation starts and [scale] == 1
    final animationProgress = item.visibleExtent / item.size.height;

    /// result matrix
    final paintTransform = Matrix4.identity();

    /// animate only if item is on edge
    if (item.position != TransformableListItemPosition.middle) {
      final scale = endScaleBound + ((1 - endScaleBound) * animationProgress);

      paintTransform
        ..translate(item.size.width / 2)
        ..scale(scale)
        ..translate(-item.size.width / 2);
    }

    return paintTransform;
  }

  Matrix4 getRotateMatrix(TransformableListItem item) {
    /// rotate item to 90 degrees
    const maxRotationTurnsInRadians = pi / 2.0;

    /// 0 when animation starts and [rotateAngle] == 0 degrees
    /// 1 when animation completed and [rotateAngle] == 90 degrees
    final animationProgress = 1 - item.visibleExtent / item.size.height;

    /// result matrix
    final paintTransform = Matrix4.identity();

    /// animate only if item is on edge
    if (item.position != TransformableListItemPosition.middle) {
      /// rotate to the left if even
      /// rotate to the right if odd
      final isEven = item.index?.isEven ?? false;

      /// To select corner of the rotation
      final FractionalOffset fractionalOffset;
      final int rotateDirection;

      switch (item.position) {
        case TransformableListItemPosition.topEdge:
          fractionalOffset = isEven
              ? FractionalOffset.bottomLeft
              : FractionalOffset.bottomRight;
          rotateDirection = isEven ? -1 : 1;
          break;
        case TransformableListItemPosition.middle:
          return paintTransform;
        case TransformableListItemPosition.bottomEdge:
          fractionalOffset =
              isEven ? FractionalOffset.topLeft : FractionalOffset.topRight;
          rotateDirection = isEven ? 1 : -1;
          break;
      }

      final rotateAngle = animationProgress * maxRotationTurnsInRadians;
      final translation = fractionalOffset.alongSize(item.size);

      paintTransform
        ..translate(translation.dx, translation.dy)
        ..rotateZ(rotateDirection * rotateAngle)
        ..translate(-translation.dx, -translation.dy);
    }

    return paintTransform;
  }

  Matrix4 getWheelMatrix(TransformableListItem item) {
    /// rotate item to 36 degrees
    const maxRotationTurnsInRadians = pi / 5.0;
    const minScale = 0.6;
    const maxScale = 1.0;

    /// perception of depth when the item rotates
    const depthFactor = 0.01;

    /// offset when [animationProgress] == 0
    final medianOffset = item.constraints.viewportMainAxisExtent / 2;
    final animationProgress =
        1 - item.offset.dy.clamp(0, double.infinity) / medianOffset;
    final scale = minScale + (maxScale - minScale) * animationProgress.abs();

    /// alignment of item
    final translationOffset = FractionalOffset.center.alongSize(item.size);
    final rotationMatrix = Matrix4.identity()
      ..setEntry(3, 2, depthFactor)
      ..rotateX(maxRotationTurnsInRadians * animationProgress)
      ..scale(scale);

    final result = Matrix4.identity()
      ..translate(translationOffset.dx, translationOffset.dy)
      ..multiply(rotationMatrix)
      ..translate(-translationOffset.dx, -translationOffset.dy);

    return result;
  }
}
