import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_manager/data/model/home/expense_purpose.dart';
import 'package:personal_manager/data/model/home/expense_purpose_detail.dart';
import 'package:tiny_charts/tiny_charts.dart';
import 'package:personal_manager/presentations/common/colors.dart' as colors;

import '../../../data/shared/utils/date/date_format/datetime_format.dart';
import '../../../logic_bussiness/home/category/category_detail/category_detail_bloc.dart';

class CategoryDetailView extends StatefulWidget {
  const CategoryDetailView({super.key, required this.item});

  final ExpensePurpose item;
  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

final TextEditingController _namePurposeController = TextEditingController();
final TextEditingController _feePurposeController = TextEditingController();

class _CategoryDetailViewState extends State<CategoryDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
      builder: (context, state) {
        if (state is CategoryDetailSuccess) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                  backgroundColor: colors.darkLiver,
                  expandedHeight: 120.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(widget.item.name ?? ''),
                  ),
                  actions: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.add_circle),
                        tooltip: 'Add new entry',
                        onPressed: () => showDialog(
                              context: context,
                              builder: (buildContext) => AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        BlocProvider.of<CategoryDetailBloc>(
                                                context)
                                            .add(CategoryDetailAddDetail(
                                                fee: double.parse(
                                                    _feePurposeController.text),
                                                name:
                                                    _namePurposeController.text,
                                                memo: "1"));
                                      },
                                      child: Text('Add'))
                                ],
                                content: Column(children: [
                                  TextFormField(
                                    controller: _namePurposeController,
                                  ),
                                  TextFormField(
                                    controller: _feePurposeController,
                                  ),
                                ]),
                              ),
                            )),
                  ]),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Card(
                      // decoration: BoxDecoration(
                      //     color: index.isOdd ? Colors.white : Colors.black12),
                       color: colors.lavenderBlush,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(64),
                          side: const BorderSide(color: colors.rossoCorsa)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                  state.ePDetailListByEP[index].fee.toString()),
                              Text(
                                state.ePDetailListByEP[index].name ?? '',
                              ),
                              Text(FormatDateConstants.convertUTCDateTimeShort2(
                                  state.ePDetailListByEP[index].dateTime!)),
                                  Text(
                                  state.ePDetailListByEP[index].memo??''),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: state.ePDetailListByEP.length,
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
