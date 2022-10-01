import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../controllers/home/home_controller.dart';
import '../../../models/categories/CategoryModel.dart';
import '../../../models/offers/OfferModel.dart';
import '../../../shared/widgets/constant/color_constants.dart';

class ExploreTab extends GetView<HomeController> {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
              floating: true,
              pinned: true,
              title: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? ColorConstants.gray600
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      hintText: "Search E.g iPhone X",
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? ColorConstants.gray900
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Icon(
                              IconlyLight.filter,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )),
                ),
              )),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildOfferCarousel(context),
              _buildOfferIndicator(),
              const SizedBox(
                height: 16,
              ),
              _buildSection('Top Categories', theme),
              const SizedBox(
                height: 8,
              ),
              _buildCategories(theme),
              const SizedBox(
                height: 16,
              ),
              _buildSection('Discounts', theme),
              const SizedBox(
                height: 8,
              ),
              _buildDiscountedProducts(theme)
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCarousel(context) {
    return Obx(() => SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: CarouselSlider.builder(
            carouselController: controller.carouselController,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 1,
              initialPage: 0,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) => controller.changeBanner(index),
            ),
            itemCount: controller.activeOffers.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    _buildOffer(controller.activeOffers[itemIndex]),
          ),
        ));
  }

  Widget _buildOffer(OfferModel offer) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            imageUrl: offer.image,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }

  Widget _buildOfferIndicator() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.activeOffers.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Get.isDarkMode ? Colors.white : Colors.blueGrey)
                      .withOpacity(
                          controller.currentBanner == entry.key ? 0.9 : 0.2)),
            );
          }).toList(),
        ));
  }

  Widget _buildSection(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.subtitle1
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          MaterialButton(
            onPressed: () {},
            minWidth: 50,
            splashColor: theme.primaryColor.withAlpha(10),
            highlightColor: theme.primaryColor.withAlpha(30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
            child: Icon(
              IconlyLight.arrow_right,
              size: 20,
              color: theme.primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategories(ThemeData theme) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          return _buildCategory(controller.categories[index], index, theme);
        },
      ),
    );
  }

  Widget _buildCategory(CategoryModel category, index, theme) {
    return ZoomTapAnimation(
      beginDuration: const Duration(milliseconds: 300),
      endDuration: const Duration(milliseconds: 500),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            right: controller.categories.length - 1 == index ? 0 : 8),
        child: Stack(
          children: [
            SizedBox(
              width: 120,
              height: 60,
              child: CachedNetworkImage(
                imageUrl: category.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(110),
                ),
                child: Center(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.subtitle1
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountedProducts(ThemeData theme) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: controller.discountedProducts.length,
        itemBuilder: (context, index) {
          return AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                    '/product/${controller.discountedProducts[index].id}');
              },
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Get.isDarkMode
                        ? ColorConstants.gray700
                        : Colors.grey.shade200,
                    border: Border.all(
                        color: Get.isDarkMode
                            ? Colors.transparent
                            : Colors.grey.shade200,
                        width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: controller.discountedProducts[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.discountedProducts[index].name,
                                style: theme.textTheme.subtitle1),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(controller.discountedProducts[index].brand,
                                style: theme.textTheme.bodyText2),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${controller.discountedProducts[index].price}",
                                  style: theme.textTheme.bodyText1?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: ColorConstants.gray200),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  IconlyLight.arrow_right,
                                  size: 18,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${controller.discountedProducts[index].discountPrice}",
                                  style: theme.textTheme.subtitle1?.copyWith(),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
