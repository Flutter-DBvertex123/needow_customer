// /*import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../../../utils/apptheme.dart';
// import '../../../../../utils/constants.dart';
//
// class Filter extends StatefulWidget {
//   List<String> filters;
//    Filter({super.key,required this.filters});
//
//   @override
//   State<Filter> createState() => _FilterState();
// }
//
// class _FilterState extends State<Filter> {
//   List<String> filterIcons = [filterIcon,vegIcon,vegIcon,spicyIcon,ratingIcons];
//   String? selectedFilter;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
//       child: Row(
//         children: widget.filters.map((filter) {
//           final icon = filterIcons[1];
//           print(icon);
//           final isSelected = selectedFilter == filter;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: FilterChip(
//               label: Row(
//                 children: [
//                   Container(
//                       child: SvgPicture.asset(icon)),
//                   Text(filter),
//                 ],
//               ),
//               selected: isSelected,
//               onSelected: (selected) {
//                 setState(() {
//                   selectedFilter = selected ? filter : null;
//                 });
//               },
//
//               backgroundColor: Colors.white,
//               checkmarkColor: Colors.white,
//               selectedColor: AppColors.primary,
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//               ),
//               side: BorderSide(
//                 color: isSelected ? Colors.blue : Colors.grey[300]!,
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }*/
// /*
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../../../utils/apptheme.dart';
// import '../../../../../utils/constants.dart';
//
// class Filter extends StatefulWidget {
//   final List<String> filters;
//   final ValueChanged<String?>? onFilterChanged;
//
//   const Filter({
//     super.key,
//     required this.filters,
//     this.onFilterChanged,
//   });
//
//   @override
//   State<Filter> createState() => _FilterState();
// }
//
// class _FilterState extends State<Filter> {
//   // Map each filter to its icon - update with your actual constants
//   late final Map<String, String> filterIcons = {
//     'Filters': filterIcon,
//     'Veg': vegIcon,
//     'Non Veg': vegIcon,
//     'Spicy': spicyIcon,
//     'Burgers': ratingIcons,
//   };
//
//   String? selectedFilter;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Row(
//         children: widget.filters.map((filter) {
//           final icon = filterIcons[filter] ?? 'assets/icons/filter_icon.svg';
//           final isSelected = selectedFilter == filter;
//
//           return Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: FilterChip(
//               label: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SvgPicture.asset(
//                     icon,
//                     width: 16,
//                     height: 16,
//                     colorFilter: ColorFilter.mode(
//                       isSelected ? Colors.white : Colors.black,
//                       BlendMode.srcIn,
//                     ),
//                     semanticsLabel: filter,
//                     placeholderBuilder: (context) => _buildFallbackIcon(filter),
//                   ),
//                   const SizedBox(width: 6),
//                   Text(filter),
//                 ],
//               ),
//               selected: isSelected,
//               onSelected: (selected) {
//                 setState(() {
//                   selectedFilter = selected ? filter : null;
//                 });
//                 // Notify parent widget of filter change
//                 widget.onFilterChanged?.call(selectedFilter);
//               },
//               backgroundColor: Colors.white,
//               checkmarkColor: Colors.white,
//               selectedColor: AppColors.primary,
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                 fontSize: 12,
//               ),
//               side: BorderSide(
//                 color: isSelected ? AppColors.primary : Colors.grey[300]!,
//                 width: 1,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildFallbackIcon(String filter) {
//     IconData icon;
//     switch (filter.toLowerCase()) {
//       case 'filters':
//         icon = Icons.filter_list;
//         break;
//       case 'veg':
//         icon = Icons.energy_savings_leaf;
//         break;
//       case 'non veg':
//         icon = Icons.fastfood;
//         break;
//       case 'spicy':
//         icon = Icons.local_fire_department;
//         break;
//       case 'burgers':
//         icon = Icons.lunch_dining;
//         break;
//       default:
//         icon = Icons.check_circle;
//     }
//     return Icon(icon, size: 16);
//   }
// }*/
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../../../../utils/apptheme.dart';
// import '../../../../../../utils/constants.dart';
//
// class Filter extends StatefulWidget {
//   final List<String> filters;
//   final ValueChanged<String?>? onFilterChanged;
//
//   const Filter({
//     super.key,
//     required this.filters,
//     this.onFilterChanged,
//   });
//
//   @override
//   State<Filter> createState() => _FilterState();
// }
//
// class _FilterState extends State<Filter> {
//   // Map each filter to its icon
//   final Map<String, String> filterIcons = {
//     'Filters': filterIcon,
//     'Veg': vegIcon,
//     'Non Veg': vegIcon,
//     'Spicy': spicyIcon,
//     'Burgers': ratingIcons,
//   };
//
//   String? selectedFilter;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Row(
//         children: widget.filters.map((filter) {
//           final icon = filterIcons[filter] ?? 'assets/icons/filter_icon.svg';
//           final isSelected = selectedFilter == filter;
//
//           return Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: FilterChip(
//               label: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // SvgPicture.asset(
//                   //   icon,
//                   //   width: 16,
//                   //   height: 16,
//                   //   colorFilter: ColorFilter.mode(
//                   //     isSelected ? Colors.white : Colors.black,
//                   //     BlendMode.srcIn,
//                   //   ),
//                   //   semanticsLabel: filter,
//                   // ),
//                   const SizedBox(width: 6),
//                   Text(filter),
//                 ],
//               ),
//               selected: isSelected,
//               onSelected: (selected) {
//                 setState(() {
//                   selectedFilter = selected ? filter : null;
//                 });
//                 // Notify parent widget of filter change
//                 widget.onFilterChanged?.call(selectedFilter);
//               },
//               backgroundColor: Colors.white,
//               checkmarkColor: Colors.white,
//               selectedColor: AppColors.primary,
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                 fontSize: 12,
//               ),
//               side: BorderSide(
//                 color: isSelected ? AppColors.primary : Colors.grey[300]!,
//                 width: 1,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../utils/apptheme.dart';
//
// class RestaurantFilterSection extends StatefulWidget {
//   final RxList<String> filters;
//   final ValueChanged<String?> onFilterChanged;
//   final String? selectedFilter;
//
//   const RestaurantFilterSection({
//     Key? key,
//     required this.filters,
//     required this.onFilterChanged,
//     this.selectedFilter,
//   }) : super(key: key);
//
//   @override
//   State<RestaurantFilterSection> createState() => _RestaurantFilterSectionState();
// }
//
// class _RestaurantFilterSectionState extends State<RestaurantFilterSection> {
//   late String? _selectedFilter;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedFilter = widget.selectedFilter;
//   }
//
//   @override
//   void didUpdateWidget(RestaurantFilterSection oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.selectedFilter != oldWidget.selectedFilter) {
//       _selectedFilter = widget.selectedFilter;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Build method will be called whenever filters RxList changes
//     // because this widget rebuilds when its parent rebuilds
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             children: [
//               // "All" filter option
//               Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: FilterChip(
//                   label: const Text('All'),
//                   selected: _selectedFilter == null,
//                   onSelected: (selected) {
//                     setState(() {
//                       _selectedFilter = null;
//                     });
//                     widget.onFilterChanged(null);
//                   },
//                   backgroundColor: Colors.white,
//                   selectedColor: AppColors.primary,
//                   labelStyle: TextStyle(
//                     color: _selectedFilter == null ? Colors.white : Colors.black,
//                     fontWeight: _selectedFilter == null
//                         ? FontWeight.w600
//                         : FontWeight.w500,
//                     fontSize: 12,
//                   ),
//                   side: BorderSide(
//                     color: _selectedFilter == null
//                         ? AppColors.primary
//                         : Colors.grey[300]!,
//                     width: 1,
//                   ),
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 ),
//               ),
//               // Restaurant type filters - use .value to get the list from RxList
//               ...widget.filters.value.map((filter) {
//                 final isSelected = _selectedFilter == filter;
//
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: FilterChip(
//                     label: Text(filter),
//                     selected: isSelected,
//                     onSelected: (selected) {
//                       setState(() {
//                         _selectedFilter = selected ? filter : null;
//                       });
//                       widget.onFilterChanged(_selectedFilter);
//                     },
//                     backgroundColor: Colors.white,
//                     selectedColor: AppColors.primary,
//                     labelStyle: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                       fontWeight: isSelected
//                           ? FontWeight.w600
//                           : FontWeight.w500,
//                       fontSize: 12,
//                     ),
//                     side: BorderSide(
//                       color:
//                       isSelected ? AppColors.primary : Colors.grey[300]!,
//                       width: 1,
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 8),
//                   ),
//                 );
//               }).toList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../utils/apptheme.dart';
//
// class RestaurantFilterSection extends StatefulWidget {
//   final RxList<String> filters;
//   final ValueChanged<String?> onFilterChanged;
//   final String? selectedFilter;
//
//   const RestaurantFilterSection({
//     Key? key,
//     required this.filters,
//     required this.onFilterChanged,
//     this.selectedFilter,
//   }) : super(key: key);
//
//   @override
//   State<RestaurantFilterSection> createState() => _RestaurantFilterSectionState();
// }
//
// class _RestaurantFilterSectionState extends State<RestaurantFilterSection> {
//   late String? _selectedFilter;
//
//   @override
//   void initState() {
//     super.initState();
//     // By default, select "All" filter
//     _selectedFilter = null;
//     widget.onFilterChanged(null);
//   }
//
//   @override
//   void didUpdateWidget(RestaurantFilterSection oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.selectedFilter != oldWidget.selectedFilter) {
//       _selectedFilter = widget.selectedFilter;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Wrap entire filter section in Obx to observe filter list changes
//     return Obx(
//           () => SliverToBoxAdapter(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 // "All" filter option
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: FilterChip(
//                     label: const Text('All'),
//                     selected: _selectedFilter == null,
//                     onSelected: (selected) {
//                       setState(() {
//                         _selectedFilter = null;
//                       });
//                       widget.onFilterChanged(null);
//                       print('✅ "All" filter selected');
//                     },
//                     backgroundColor: Colors.white,
//                     selectedColor: AppColors.primary,
//                     labelStyle: TextStyle(
//                       color: _selectedFilter == null ? Colors.white : Colors.black,
//                       fontWeight: _selectedFilter == null
//                           ? FontWeight.w600
//                           : FontWeight.w500,
//                       fontSize: 12,
//                     ),
//                     side: BorderSide(
//                       color: _selectedFilter == null
//                           ? AppColors.primary
//                           : Colors.grey[300]!,
//                       width: 1,
//                     ),
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   ),
//                 ),
//                 // Restaurant type filters - use .value to get the list from RxList
//                 // This will rebuild whenever filters list changes
//                 ...widget.filters.value.map((filter) {
//                   final isSelected = _selectedFilter == filter;
//
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: FilterChip(
//                       label: Text(filter),
//                       selected: isSelected,
//                       onSelected: (selected) {
//                         setState(() {
//                           _selectedFilter = selected ? filter : null;
//                         });
//                         widget.onFilterChanged(_selectedFilter);
//                         print('🔍 Filter selected: ${_selectedFilter ?? "All"}');
//                       },
//                       backgroundColor: Colors.white,
//                       selectedColor: AppColors.primary,
//                       labelStyle: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black,
//                         fontWeight: isSelected
//                             ? FontWeight.w600
//                             : FontWeight.w500,
//                         fontSize: 12,
//                       ),
//                       side: BorderSide(
//                         color:
//                         isSelected ? AppColors.primary : Colors.grey[300]!,
//                         width: 1,
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 8),
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/apptheme.dart';

class RestaurantFilterSection extends StatelessWidget {
  final RxList<String> filters;
  final Rx<String?> selectedFilter;
  final ValueChanged<String?> onFilterChanged;

  const RestaurantFilterSection({
    Key? key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // "All" filter option
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: const Text('All'),
                    selected: selectedFilter.value == null,
                    onSelected: (selected) {
                      onFilterChanged(null);
                      print('✅ "All" filter selected');
                    },
                    backgroundColor: Colors.white,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: selectedFilter.value == null
                          ? Colors.white
                          : Colors.black,
                      fontWeight: selectedFilter.value == null
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 12,
                    ),
                    side: BorderSide(
                      color: selectedFilter.value == null
                          ? AppColors.primary
                          : Colors.grey[300]!,
                      width: 1,
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                // Restaurant type filters
                ...filters.value.map((filter) {
                  final isSelected = selectedFilter.value == filter;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          onFilterChanged(filter);
                          print('🔍 Filter selected: $filter');
                        } else {
                          onFilterChanged(null);
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
      ),
    );
  }
}