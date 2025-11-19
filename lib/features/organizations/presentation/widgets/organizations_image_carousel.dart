import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OrganizationsImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double? height;
  final bool enableInfiniteScroll;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final bool showIndicators;

  const OrganizationsImageCarousel({
    super.key,
    required this.imageUrls,
    this.height,
    this.enableInfiniteScroll = true,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.showIndicators = true,
  });

  @override
  State<OrganizationsImageCarousel> createState() =>
      _OrganizationsImageCarouselState();
}

class _OrganizationsImageCarouselState
    extends State<OrganizationsImageCarousel> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    return Column(
      children: [
        // Carousel Slider
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            final imageUrl = widget.imageUrls[index];
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50.w,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.height ?? 200.h,
            autoPlay: widget.autoPlay,
            autoPlayInterval: widget.autoPlayInterval,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            viewportFraction: 0.85,
            enableInfiniteScroll: widget.enableInfiniteScroll,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),

        // Smooth Page Indicators
        if (widget.showIndicators && widget.imageUrls.length > 1) ...[
          SizedBox(height: 16.h),
          AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: widget.imageUrls.length,
            onDotClicked: (index) {
              _carouselController.animateToPage(index);
            },
            effect: WormEffect(
              dotWidth: 14.w,
              dotHeight: 4.h,
              spacing: 8.w,
              radius: 2.r,
              dotColor:
                  theme.textTheme.bodyLarge?.color?.withOpacity(0.5) ??
                  AppColors.greyColor.withOpacity(0.5),
              activeDotColor: theme.primaryColor,
              paintStyle: PaintingStyle.fill,
            ),
          ),
        ],
      ],
    );
  }
}
