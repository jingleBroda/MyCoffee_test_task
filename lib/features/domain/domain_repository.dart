import 'coffee_recipe_domain.dart';

abstract class DomainRepository {
  Future<List<DomainCoffeeRecipe>> getRecipeList();
  Future<List<String>> getIngredientName(List<int> keys);
}