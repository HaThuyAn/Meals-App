import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

// when using StateNotifier, the existing values in the memory
// cannot be editted, instead creating a new one
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]); // set the initial data

  // add methods to edit the initial data
  bool toggleMealFavoriteStatus(Meal meal) {
    // .add(); // not allowed
    // .remove(); // not allowed
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal]; // pull out every elements of the list, assign them to the new list, and add a new element to it
      return true;
    }
    // state = []; // state: a property holding data
  }
}

// final favoriteMealsProvider = Provider(); // better for use when data is not changed
final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier(); // return an instance of FavoriteMealsNotifier class
});