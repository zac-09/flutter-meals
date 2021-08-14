import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilterss;
  final Map<String, bool> currentFilters;
  FilterScreen(this.saveFilterss, this.currentFilters);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

Widget _buildSwitchListTile(
    String text, bool type, String subTitle, Function update) {
  return SwitchListTile(
      title: Text(text),
      value: type,
      subtitle: Text(subTitle),
      onChanged: (newValue) => update(newValue));
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutrnFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;
  @override
  void initState() {
    _glutrnFree = widget.currentFilters['gluten'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _vegetarian = widget.currentFilters['vegeterian'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("your filters"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutrnFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegeterian': _vegetarian,
                };
                widget.saveFilterss(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  "Gluten-free", _glutrnFree, "only include gluten free meals",
                  (update) {
                setState(() {
                  _glutrnFree = update;
                });
              }),
              _buildSwitchListTile("Lactose-free", _lactoseFree,
                  "only include lactose free meals", (update) {
                setState(() {
                  _lactoseFree = update;
                });
              }),
              _buildSwitchListTile(
                  "Vegan", _vegan, "only include vegan free meals", (update) {
                setState(() {
                  _vegan = update;
                });
              }),
              _buildSwitchListTile("Vegeyerian", _vegetarian,
                  "only include vegeterian free meals", (update) {
                setState(() {
                  _vegetarian = update;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
