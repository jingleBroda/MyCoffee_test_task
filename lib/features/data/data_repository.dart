import 'package:my_coffe_test_task/features/domain/coffee_recipe_domain.dart';
import 'package:my_coffe_test_task/features/domain/domain_repository.dart';

import 'local/database_helper.dart';

class DataRepository implements DomainRepository {
  final _dbHelper = DatabaseHelper();

  @override
  Future<List<DomainCoffeeRecipe>> getRecipeList() async {
    final result = <DomainCoffeeRecipe>[];
    final dataRecipeList = await _dbHelper.getAllCoffeeRecipes();

    for (var recipe in dataRecipeList) {
      //1
      final recipeName = recipe.recipeName;
      //2
      final map = <String, double>{};
      final nameIngredient =  await getIngredientName(recipe.getIngredientIdList());
      final weightsIngredients = recipe.getIngredientWeightList();
      for (int index = 0; index< nameIngredient.length; index++) {
        map[nameIngredient[index]] = weightsIngredients[index];
      }
      //3
      final newDomainCoffeeRecipe = DomainCoffeeRecipe(recipeName, map);
      result.add(newDomainCoffeeRecipe);
    }

    return result;
  }

  @override
  Future<List<String>> getIngredientName(List<int> keys) async {
    final result = <String>[];
    final ingredients = await _dbHelper.getCoffeeIngredients(keys);
    for (var ingredient in ingredients) {
      result.add(ingredient.canisterName);
    }
    return result;
  }
}