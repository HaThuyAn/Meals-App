import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed => mutating state
    state = {
      ...state, // copy the existing map's key-value pairs into the new map
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      // if glutenFree filter is on AND the meal is not glutenFree -> false
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      // if lactoseFree filter is on AND the meal is not lactoseFree -> false
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      // if vegetarian filter is on AND the meal is not vegetarian -> false
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      // if vegan filter is on AND the meal is not vegan -> false
      return false;
    }
    return true;
  }).toList();
});
