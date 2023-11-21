import 'package:flutter/material.dart';
import 'package:oninto_flutter/utills/colors_file.dart';

class FavouriteButton extends StatefulWidget {
  FavouriteButton(
      {super.key,
      required this.onClick,
      required this.isFavourite,
      this.size,
      this.activeColor,
      this.unactiveColor,
      this.activeIcon,
      this.unactiveIcon});
  final Function onClick;
  final bool isFavourite;
  Color? activeColor;
  Color? unactiveColor;
  double? size;
  IconData? activeIcon;
  IconData? unactiveIcon;

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick();
        _controller.reverse().then((value) => _controller.forward());
      },
      child: ScaleTransition(
        scale: Tween(begin: 0.7, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
        child: widget.isFavourite
            ? Icon(widget.activeIcon ?? Icons.favorite,
                size: widget.size, color: widget.activeColor ?? themeColor)
            : Icon(widget.unactiveIcon ?? Icons.favorite_border,
                size: widget.size, color: widget.unactiveColor ?? themeColor),
      ),
    );
  }
}
