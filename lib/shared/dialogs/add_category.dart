import 'package:be_thrift/config/config.dart';
import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/services/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryDialog extends StatefulWidget {
  final String type;

  const AddCategoryDialog(this.type, {super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  String? _selectedIcon;
  final TextEditingController _nameController = TextEditingController();

  final List<String> icons = [
    'custom/custom_blue.png',
    'custom/custom_brown.png',
    'custom/custom_green.png',
    'custom/custom_indigo.png',
    'custom/custom_orange.png',
    'custom/custom_purple.png',
    'custom/custom_red.png',
    'custom/custom_teal.png',
    'custom/custom_yellow.png',
    'expense/automobile.png',
    'expense/baby.png',
    'expense/books.png',
    'expense/charity.png',
    'expense/clothing.png',
    'expense/drinks.png',
    'expense/education.png',
    'expense/electronics.png',
    'expense/entertainment.png',
    'expense/food.png',
    'expense/friends.png',
    'expense/gifts.png',
    'expense/groceries.png',
    'expense/health.png',
    'expense/hobbies.png',
    'expense/insurance.png',
    'expense/investments.png',
    'expense/laundry.png',
    'expense/mobile.png',
    'expense/office.png',
    'expense/others.png',
    'expense/pets.png',
    'expense/rent.png',
    'expense/salon.png',
    'expense/shopping.png',
    'expense/tax.png',
    'expense/transportation.png',
    'expense/travel.png',
    'expense/utilities.png',
    'income/awards.png',
    'income/bonus.png',
    'income/freelance.png',
    'income/grants.png',
    'income/interest.png',
    'income/lottery.png',
    'income/refunds.png',
    'income/salary.png',
    'income/sale.png',
  ];

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context);
    var type = widget.type == 'income'
        ? S.of(context)!.categoriesScreenTabBarTextIncome
        : S.of(context)!.categoriesScreenTabBarTextExpense;

    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(
            S.of(context)!.addCategoryBottomSheetHeadingText(type),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              (_selectedIcon != null)
                  ? Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                width: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                          child: CategoryIcon(
                            icon: _selectedIcon!,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    )
                  : Container(),
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: icons.length,
                    itemBuilder: (context, index) {
                      return CategoryIcon(
                        onTap: () {
                          setState(() => _selectedIcon = icons[index]);
                        },
                        isSelected: _selectedIcon == icons[index],
                        icon: icons[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText:
                  S.of(context)!.addCategoryBottomSheetLabelTextCategoryName,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                //  textColor: Colors.red[600],
                icon: const Icon(Icons.clear),
                label: Text(
                  S.of(context)!.addCategoryBottomSheetButtonTextCancel,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  if (_nameController.text.isEmpty || _selectedIcon == null) {
                    return;
                  }
                  categoryProvider.insert(Category(
                    id: 'custom_${UniqueKey().toString()}',
                    icon: _selectedIcon!,
                    name: _nameController.text,
                    type: widget.type,
                  ));
                  Navigator.pop(context);
                },
//                textColor: Theme.of(context).colorScheme.secondary,
                icon: const Icon(Icons.check),
                label: Text(
                  S.of(context)!.addCategoryBottomSheetButtonTextAdd,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final void Function()? onTap;
  final bool isSelected;
  final String icon;

  const CategoryIcon({
    Key? key,
    this.onTap,
    this.isSelected = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          children: <Widget>[
            isSelected
                ? Center(
                    child: Container(
                      width: 80,
                      color: thriftyBlue.withOpacity(0.2),
                    ),
                  )
                : Container(),
            Center(
              child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/categories/$icon'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
