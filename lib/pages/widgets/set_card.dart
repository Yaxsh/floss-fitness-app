import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetCard extends StatefulWidget {
  const SetCard({Key? key}) : super(key: key);

  @override
  State<SetCard> createState() => _SetCardState();
}

class _SetCardState extends State<SetCard> {

  //todo: extract all exercises from DB
  static const List<String> items = <String>['Deadlift', 'Squat', 'Bench', 'OHP'];
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      color: Colors.grey,
      child: Column(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme
                      .of(context)
                      .hintColor,
                ),
              ),
              items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                });
              },
              buttonHeight: 40,
              buttonWidth: 140,
              itemHeight: 40,
              dropdownMaxHeight: 200,
              searchController: textEditingController,
              searchInnerWidget: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Select an exercise...',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return (item.value.toString().toLowerCase().contains(searchValue.toLowerCase()));
              },
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          ),
          const Divider(color: Color.fromARGB(255, 89, 87, 87), indent: 5, endIndent: 5,),
          Row(
            children: const [
              SizedBox(child: TextField(keyboardType: TextInputType.number,), width: 20,),
              Text("kg x "),
              SizedBox(child: TextField(keyboardType: TextInputType.number), width: 20,),
              Text("reps."),
            ],
          ),
          const Divider(color: Color.fromARGB(255, 89, 87, 87), indent: 5, endIndent: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Elevated")),
              TextButton(onPressed: () {}, child: const Text("Text")),
              OutlinedButton(onPressed: () {}, child: const Text("Outlined")),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
