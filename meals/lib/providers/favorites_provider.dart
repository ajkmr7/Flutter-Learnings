import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFavoriteMealStatus(Meal meal) {
    final isMealExisiting = state.contains(meal);

    isMealExisiting
        ? state = state.where((element) => element.id != meal.id).toList()
        : state = [...state, meal];

    return !isMealExisiting;
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) => FavoriteMealsNotifier(),
);
