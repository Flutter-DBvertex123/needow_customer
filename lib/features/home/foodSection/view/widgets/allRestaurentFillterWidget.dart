import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/apptheme.dart';
import '../../restaurent/controller/fillterAllRestaurntScreenController.dart';


class AllRestaurantsFilterWidget extends StatelessWidget {
  final AllRestaurantsFilterController controller;

  const AllRestaurantsFilterWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // "All" filter option
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: const Text('All'),
                  selected: controller.selectedFilter.value == null,
                  onSelected: (selected) {
                    controller.applyFilter(null);
                    print('✅ "All" filter selected');
                  },
                  backgroundColor: Colors.white,
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: controller.selectedFilter.value == null
                        ? Colors.white
                        : Colors.black,
                    fontWeight: controller.selectedFilter.value == null
                        ? FontWeight.w600
                        : FontWeight.w500,
                    fontSize: 12,
                  ),
                  side: BorderSide(
                    color: controller.selectedFilter.value == null
                        ? AppColors.primary
                        : Colors.grey[300]!,
                    width: 1,
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              // Restaurant type filters
              ...controller.filters.value.map((filter) {
                final isSelected = controller.selectedFilter.value == filter;

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        controller.applyFilter(filter);
                        print('🔍 Filter selected: $filter');
                      } else {
                        controller.applyFilter(null);
                        print('❌ Filter deselected');
                      }
                    },
                    backgroundColor: Colors.white,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 12,
                    ),
                    side: BorderSide(
                      color:
                      isSelected ? AppColors.primary : Colors.grey[300]!,
                      width: 1,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}