import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:health_booster/core/extensions/build_context_extensions.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';

class AppDropdownButton<T extends Object> extends StatefulWidget {
  const AppDropdownButton({
    super.key,
    this.onChange,
    this.flexible,
    this.height,
    this.hintText,
    this.leadingIcon,
    this.trailingIcon,
    this.selectedValue,
    required this.items,
    required this.child,
    this.selectedItemBuilder,
    this.isExpanded = true,
    required this.itemValue,
    this.elevation,
    this.borderRadiusCount = 12,
    this.fillColor,
    this.trailingIconColor,
    this.borderColor,
    this.label,
    this.dropdownFillColor,
    this.selectedItemAlignment = Alignment.center,
    this.itemsPadding = const EdgeInsets.only(left: 10, right: 10),
    this.selectedItemPadding = const EdgeInsets.only(left: 10, right: 10),
    this.borderRadius,
    this.onTrailingTap,
    this.isSearchable = false,
    this.searchMatcher,
  });

  final Function(T? selectItem)? onChange;
  final Widget Function(T item) child;
  final Widget Function(T item)? selectedItemBuilder;
  final T Function(T item) itemValue;
  final IconData? trailingIcon;
  final Function()? onTrailingTap;
  final IconData? leadingIcon;
  final double borderRadiusCount;
  final BorderRadiusGeometry? borderRadius;
  final T? selectedValue;
  final String? hintText;
  final double? flexible;
  final double? height;
  final bool isExpanded;
  final List<T> items;
  final int? elevation;
  final Color? fillColor;
  final Color? dropdownFillColor;
  final Color? borderColor;
  final Color? trailingIconColor;
  final String? label;
  final AlignmentGeometry selectedItemAlignment;
  final EdgeInsetsGeometry selectedItemPadding;
  final EdgeInsetsGeometry itemsPadding;
  final bool isSearchable;
  final bool Function(T item, String searchValue)? searchMatcher;

  @override
  State<AppDropdownButton<T>> createState() => _AppDropdownButtonState<T>();
}

class _AppDropdownButtonState<T extends Object> extends State<AppDropdownButton<T>> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    final labelShow = widget.selectedValue != null && widget.label != null;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: labelShow ? 6 : 0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              isExpanded: widget.isExpanded,
              hint: _buildHint(color),
              items: _buildDropdownItems(),
              barrierColor: color.onSecondaryContainer.withValues(alpha: 0.15),
              value: widget.selectedValue,
              onChanged: (value) {
                if (widget.onChange != null) widget.onChange!(value);
                _searchFocusNode.unfocus();
              },
              buttonStyleData: _buildButtonStyleData(color),
              iconStyleData: _buildIconStyleData(color),
              dropdownStyleData: _buildDropdownStyleData(),
              menuItemStyleData: _buildMenuItemStyleData(color),
              selectedItemBuilder: _buildSelectedItemBuilder(),
              onMenuStateChange: (isOpen) {
                if (isOpen && widget.isSearchable) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _searchFocusNode.requestFocus();
                  });
                } else {
                  _searchController.clear();
                  _searchFocusNode.unfocus();
                }
              },
            ),
          ),
        ),
        if (labelShow)
          Positioned(
            left: 10,
            child: Text(
              widget.label!,
              style: secondaryTextStyle(size: 11, weight: FontWeight.w400),
            ),
          ),
      ],
    );
  }

  Widget _buildHint(ColorScheme colorScheme) {
    return Row(
      children: [
        if (widget.leadingIcon != null) ...[
          Icon(
            widget.leadingIcon,
            size: 16,
            color: colorScheme.onSurface,
          ),
          3.width,
        ],
        3.width,
        if (widget.hintText != null)
          Expanded(
            child: Text(
              widget.hintText!,
              style: secondaryTextStyle(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }

  List<DropdownMenuItem<T>> _buildDropdownItems() {
    return widget.items
        .map((item) => DropdownMenuItem<T>(
      value: widget.itemValue(item),
      child: widget.child(item),
    ))
        .toList();
  }

  ButtonStyleData _buildButtonStyleData(ColorScheme colorScheme) {
    return ButtonStyleData(
      height: widget.height ?? 50,
      width: context.deviceSize.width / (widget.flexible ?? 3),
      padding: widget.selectedItemPadding,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.borderRadiusCount),
        border: Border.all(color: widget.borderColor ?? colorScheme.surfaceContainerLow),
        color: widget.fillColor ?? colorScheme.surfaceContainerLow,
      ),
      elevation: widget.elevation,
    );
  }

  IconStyleData _buildIconStyleData(ColorScheme colorScheme) {
    return IconStyleData(
      icon: IconButton(
        onPressed: widget.onTrailingTap,
        icon: Icon(widget.trailingIcon),
      ),
      iconSize: widget.trailingIcon != null ? 20 : 0,
      iconEnabledColor: widget.trailingIconColor ?? colorScheme.onSurface.withValues(alpha: 0.5),
    );
  }

  DropdownStyleData _buildDropdownStyleData() {
    return DropdownStyleData(
      maxHeight: 200,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      color: widget.dropdownFillColor
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(40),
        thickness: WidgetStateProperty.all(6),
        thumbVisibility: WidgetStateProperty.all(true),
      ),
    );
  }

  MenuItemStyleData _buildMenuItemStyleData(ColorScheme colorScheme) {
    return MenuItemStyleData(
      height: 40,
      padding: widget.itemsPadding,
    );
  }

  DropdownButtonBuilder _buildSelectedItemBuilder() {
    return (context) => widget.items
        .map((item) => Align(
      alignment: widget.selectedItemAlignment,
      child: widget.selectedItemBuilder?.call(item) ?? widget.child(item),
    ))
        .toList();
  }
}