import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class SearchListView<T extends RealmObject> extends StatefulWidget {
  final List<T> objects;
  final bool Function(T object)? onFilter;
  final Widget Function(BuildContext context, T object) itemBuilder;
  final String hintText;
  const SearchListView({
    super.key,
    required this.objects,
    required this.itemBuilder,
    this.onFilter,
    this.hintText = '搜索',
  });

  @override
  State<SearchListView> createState() => _SearchListViewState<T>();
}

class _SearchListViewState<T extends RealmObject>
    extends State<SearchListView<T>> {
  List<T> _displayObjects = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayObjects = widget.objects;
  }

  @override
  void didUpdateWidget(covariant SearchListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    _filter(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: widget.hintText,
          ),
          controller: _controller,
          onSubmitted: (value) {
            _filter(value);
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _displayObjects.length,
            itemBuilder: (context, index) {
              final item = _displayObjects[index];
              return widget.itemBuilder(context, item);
            },
          ),
        )
      ],
    );
  }

  void _filter(String value) {
    setState(() {
      _displayObjects = widget.objects.where((element) {
        if (widget.onFilter == null || value.isEmpty) {
          return true;
        }
        return widget.onFilter!(element);
      }).toList();
    });
  }
}
