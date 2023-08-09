import 'package:be_thrift/config/config.dart';
import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final void Function()? onPressed;

  const CategorySelector({
    Key? key,
    required this.category,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          isSelected
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: thriftyBlue.withOpacity(0.15),
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      'assets/categories/${category.icon}',
                    ),
                  ),
                  Text(
                    S
                        .of(context)!
                        .categoryName(transformCategoryToKey(category)),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
