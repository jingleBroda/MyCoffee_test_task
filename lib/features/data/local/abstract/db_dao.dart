import 'package:flutter/cupertino.dart';
import '../model/coffee_canister_set.dart';
import '../model/coffee_recipe.dart';


abstract class CoffeeDao {
  //Test query
  Future<List<String>> getAllTables();

  //Main query
  Future<List<CoffeeRecipe>>  getAllCoffeeRecipes();
  @protected
  Future<List<CoffeeCanisterSet>> getCoffeeIngredient(int canisterId);
}