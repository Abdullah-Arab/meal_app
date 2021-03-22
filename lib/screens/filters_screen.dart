import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routName = '/filters_screen';
  final Function saveFilter;
  final Map<String, bool> currenFilter;

  FilterScreen(this.currenFilter, this.saveFilter);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  @override
  initState() {
    _glutenFree = widget.currenFilter['gluten'];
    _lactoseFree = widget.currenFilter['lactose'];
    _vegan = widget.currenFilter['vagan'];
    _vegetarian = widget.currenFilter['vegeterian'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              final Map<String, bool> selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vagan': _vegan,
                'vegeterian': _vegetarian,
              };
              widget.saveFilter(selectedFilters);
              final snackBar = SnackBar(
                content: Text('Filters have been updated!'),
                duration: Duration(
                  seconds: 1,
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitch('Gluten-Free', _glutenFree, (newVal) {
                setState(() {
                  _glutenFree = newVal;
                });
              }),
              _buildSwitch('Lactose-Free', _lactoseFree, (newVal) {
                setState(() {
                  _lactoseFree = newVal;
                });
              }),
              _buildSwitch('Vegan', _vegan, (newVal) {
                setState(() {
                  _vegan = newVal;
                });
              }),
              _buildSwitch('Vegetarian', _vegetarian, (newVal) {
                setState(() {
                  _vegetarian = newVal;
                });
              }),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }

  Widget _buildSwitch(String filterName, bool filterVal, Function updateVal) {
    return SwitchListTile(
      title: Text(filterName),
      value: filterVal,
      subtitle: Text('Only include $filterName meals'),
      onChanged: updateVal,
    );
  }
}
