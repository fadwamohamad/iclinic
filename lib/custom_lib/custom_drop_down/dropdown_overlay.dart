part of 'custom_dropdown.dart';

const _overlayIcon = Icon(
  Icons.keyboard_arrow_up_rounded,
  color: Colors.black,
  size: 20,
);
const _headerPadding = EdgeInsets.only(
  left: 16.0,
  top: 16,
  bottom: 16,
  right: 14,
);
const _overlayOuterPadding = EdgeInsets.only(bottom: 12, left: 12, right: 12);
const _overlayOffset = Offset(-12, 0);
const _overlayShadowOffset = Offset(0, 6);
const _listItemPadding = EdgeInsets.symmetric(vertical: 12, horizontal: 20);

class _DropdownOverlay extends StatefulWidget {
  final List<dynamic> items;
  final TextEditingController controller;
  final Size size;
  final LayerLink layerLink;
  final VoidCallback hideOverlay;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? headerStyle;
  final TextStyle? listItemStyle;
  final bool? excludeSelected;
  final BorderRadius? borderRadius;
  final callback myVoidCallback;
  final Color inColor;

  const _DropdownOverlay({
    Key? key,
    required this.items,
    required this.myVoidCallback,
    required this.controller,
    required this.size,
    required this.layerLink,
    required this.hideOverlay,
    required this.suffixIcon,
    required this.prefixIcon,
    required this.hintText,
    this.headerStyle,
    this.inColor =  MyColors.mainColor,
    this.listItemStyle,
    this.excludeSelected,
    this.borderRadius,
  }) : super(key: key);

  @override
  _DropdownOverlayState createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<_DropdownOverlay> {
  bool displayOverly = true;
  late String headerText;
  late List<dynamic> items;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    headerText = widget.controller.text;
    if (widget.excludeSelected! && widget.controller.text.isNotEmpty) {
      items = widget.items.where((item) => item != headerText).toList();
    } else {
      items = widget.items;
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // border radius
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(12);

    // items list
    final list = _ItemsList(
      scrollController: scrollController,
      excludeSelected: widget.excludeSelected!,
      items: items,
      headerText: headerText,
      myVoidCallback: widget.myVoidCallback,
      itemTextStyle: widget.listItemStyle,
      onItemSelect: (value) {
        if (headerText != value) {
          widget.controller.text = value.toString();
        }
        setState(() => displayOverly = false);
      },
    );

    return GestureDetector(
      onTap: () => setState(() => displayOverly = false),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,

        child: Stack(
          children: [
            Positioned(
              width: widget.size.width + 24,
              child: CompositedTransformFollower(
                link: widget.layerLink,
                showWhenUnlinked: false,
                offset: _overlayOffset,
                child: Padding(
                  padding: _overlayOuterPadding,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: widget.inColor,
                      borderRadius: borderRadius,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 24.0,
                          color: Colors.black.withOpacity(.08),
                          offset: _overlayShadowOffset,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: AnimatedSection(
                        animationDismissed: widget.hideOverlay,
                        expand: displayOverly,
                        child: SizedBox(
                          height: items.length > 4 ? 225 : null,
                          child: ClipRRect(
                            borderRadius: borderRadius,
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (notification) {
                                notification.disallowGlow();
                                return true;
                              },
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  scrollbarTheme: ScrollbarThemeData(
                                    isAlwaysShown: true,
                                    thickness: MaterialStateProperty.all(5),
                                    radius: const Radius.circular(4),
                                    thumbColor: MaterialStateProperty.all(
                                      Colors.grey[300],
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: _headerPadding,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              headerText.isNotEmpty
                                                  ? headerText
                                                  : widget.hintText,
                                              style: widget.headerStyle,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          widget.suffixIcon ?? _overlayIcon,
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      indent: 16,
                                      endIndent: 16,
                                      height: 0,
                                      color: Colors.grey[300],
                                    ),
                                    items.length > 4
                                        ? Expanded(child: list)
                                        : list
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemsList extends StatelessWidget {
  final ScrollController scrollController;
  final List<dynamic> items;
  final bool excludeSelected;
  final String headerText;
  final ValueSetter<dynamic> onItemSelect;
  final TextStyle? itemTextStyle;
  final callback myVoidCallback;

  const _ItemsList({
    Key? key,
    required this.scrollController,
    required this.items,
    required this.excludeSelected,
    required this.headerText,
    required this.onItemSelect,
    required this.myVoidCallback,
    this.itemTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listItemStyle = const TextStyle(
      fontSize: 16,
    ).merge(itemTextStyle);

    return Scrollbar(
      controller: scrollController,
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: items.length,
        itemBuilder: (_, index) {
          final selected = !excludeSelected && headerText == items[index];
          var area = items[index];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.grey[200],
              onTap: () {
                myVoidCallback(area);
                onItemSelect(items[index].toString());
              },
              child: Container(
                color: selected ? Colors.grey[100] : Colors.transparent,
                padding: _listItemPadding,
                child: Text(
                  items[index].toString(),
                  style: listItemStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
