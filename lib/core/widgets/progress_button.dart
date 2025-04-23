import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/colors_manager.dart';
import '../../core/theme/text_styles.dart';

class AppProgressButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final double? width;
  final double? height;
  final double? radius;
  final double? elevation;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? progressIndicatorColor;
  final EdgeInsets? padding;
  final bool isBordered;
  final bool isOutlined;
  final Color? borderColor;
  final Function(AnimationController) onPressed;

  const AppProgressButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.width,
    this.height,
    this.radius = 65,
    this.elevation = 0,
    this.fontSize,
    this.backgroundColor = ColorsManager.primary,
    this.textColor,
    this.progressIndicatorColor,
    this.padding,
    this.isBordered = false,
    this.isOutlined = false,
    this.borderColor,
  }) : assert(
         text != null || child != null,
         'Either text or child must be provided',
       );

  @override
  State<AppProgressButton> createState() => _AppProgressButtonState();
}

class _AppProgressButtonState extends State<AppProgressButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<BorderRadius?> _radiusAnimation;
  late double _buttonHeight;
  double? _initialWidth;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _buttonHeight = widget.height ?? 45.sp; // Update height here
    _initializeAnimations();
  }

  @override
  void didUpdateWidget(AppProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.height != widget.height ||
        oldWidget.width != widget.width ||
        oldWidget.radius != widget.radius) {
      _buttonHeight = widget.height ?? 45.sp; // Update height here
      _initializeAnimations();
    }
  }

  void _initializeAnimations() {
    _initialWidth = widget.width?.sp ?? MediaQuery.of(context).size.width;

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _sizeAnimation = Tween<double>(
      begin: _initialWidth,
      end: _buttonHeight,
    ).animate(curvedAnimation);

    _radiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(widget.radius?.r ?? 65.r),
      end: BorderRadius.circular(_buttonHeight / 2),
    ).animate(curvedAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder:
          (context, child) => Container(
            constraints: BoxConstraints(minWidth: _buttonHeight),
            width: _sizeAnimation.value,
            height: _buttonHeight,
            child: MaterialButton(
              padding:
                  widget.padding ??
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              elevation: widget.elevation,
              shape: _buildButtonShape(),
              color:
                  widget.isOutlined
                      ? Colors.transparent
                      : widget.backgroundColor,
              onPressed:
                  _controller.isCompleted
                      ? null
                      : () => widget.onPressed(_controller),
              child: _buildButtonContent(),
            ),
          ),
    );
  }

  RoundedRectangleBorder _buildButtonShape() {
    return RoundedRectangleBorder(
      borderRadius:
          _radiusAnimation.value ??
          BorderRadius.circular(widget.radius?.r ?? 8.r),
      side: _getBorderSide(),
    );
  }

  BorderSide _getBorderSide() {
    if (widget.isOutlined || widget.isBordered) {
      return BorderSide(
        color: widget.borderColor ?? ColorsManager.black,
        width: 1.w,
      );
    }
    // When isBordered is false and isOutlined is false, return a transparent border
    return BorderSide(
      color: Colors.transparent, // Transparent border
      width: 1.w, // Maintain the same width for consistency
    );
  }

  Widget _buildButtonContent() {
    if (_controller.isCompleted) {
      return _buildLoadingIndicator();
    }
    return _buildButtonText();
  }

  Widget _buildLoadingIndicator() {
    return OverflowBox(
      maxWidth: _buttonHeight,
      maxHeight: _buttonHeight,
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 1.w,
          backgroundColor: widget.progressIndicatorColor ?? ColorsManager.white,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.textColor ?? ColorsManager.white,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonText() {
    return FittedBox(
      child:
          widget.child ??
          Text(
            widget.text ?? 'Click Me',
            style: TextStyles.semiBold14.copyWith(
              color:
                  widget.isOutlined
                      ? widget.textColor ?? ColorsManager.black
                      : widget.textColor ?? ColorsManager.white,
              fontSize: widget.fontSize?.sp,
            ),
          ),
    );
  }
}
