import 'package:diverge_task/custom/d_image.dart';
import 'package:diverge_task/custom/tab_bar/tab_border_shape.dart';
import 'package:diverge_task/utils/constants.dart';
import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});
  String? iconData;
  // IconData? iconData;
  String? text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({super.key,
    this.items,
    this.centerItemText,
    this.height = 70.0,
    this.iconSize = 22.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items!.length == 2 || this.items!.length == 4);
  }
  final List<FABBottomAppBarItem>? items;
  final String? centerItemText;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int>? onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int? _selectedIndex;

  _updateIndex(int index) {
    widget.onTabSelected!(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items!.length, (int index) {
      return _buildTabItem(
        item: widget.items![index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    // return BottomAppBar(
    //   shape: widget.notchedShape,
    //   child: Row(
    //     mainAxisSize: MainAxisSize.max,
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: items,
    //   ),
    //   color: widget.backgroundColor,
    // );

    return Transform.translate(
      offset: const Offset(0, 0),
      child: Container(
        height:70,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: ShapeDecoration(
          color: Constants.white,
          shape: TabBorderShape(),
          shadows: const [
            BoxShadow(color: Colors.black38, blurRadius: 1.0, offset: Offset(0.5, 0.5)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:items,
        ),
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    Color color =_selectedIndex!=null&& _selectedIndex == index ? widget.selectedColor! : widget.color!;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed!(index!),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DImage(item!.iconData!, color: color,width: widget.iconSize,height: widget.iconSize,),
                // Icon(item!.iconData, color: color, size: widget.iconSize),
                Text(item.text!,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

