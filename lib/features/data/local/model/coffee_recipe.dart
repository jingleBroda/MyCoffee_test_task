import 'dart:convert';
import '../../../domain/coffee_recipe_domain.dart';

class CoffeeRecipe {
  final int id;
  final String? extra;
  final String canisterIds;
  final String recipeName;
  final String stepses;
  final String? esAttr;
  final String? instantAttr;
  final String date;

  CoffeeRecipe({
    required this.id,
    required this.extra,
    required this.canisterIds,
    required this.recipeName,
    required this.stepses,
    required this.esAttr,
    required this.instantAttr,
    required this.date,
  });

  factory CoffeeRecipe.fromJson(Map<String, dynamic> json) {
    return CoffeeRecipe(
        id: json['id'],
        extra: json['extra'],
        canisterIds: json['canisterIds'],
        recipeName: json['recipeName'],
        stepses: json['stepses'],
        esAttr: json['esAttr'],
        instantAttr: json['instantAttr'],
        date: json['date']);
  }

  List<int> getIngredientIdList() {
    String jsonString = stepses;
    List<dynamic> jsonList = jsonDecode(jsonString);

    List<int> result = [];

    for (var item in jsonList) {
      if (item.containsKey('canisterId')) {
        result.add(item['canisterId']);
      } else {
        result.add(0); //если не нашли id, буду предполагать что это вода
      }
    }

    return result;
  }

  List<double> getIngredientWeightList() {
    String jsonString = stepses;
    List<dynamic> jsonList = jsonDecode(jsonString);

    List<double> result = [];

    for (var item in jsonList) {
      if (item.containsKey('gradientWeight')) {
        result.add(double.parse(item['gradientWeight']));
      } else {
        result.add(0); //если не нашли вес, буду предполагать что это вода (т.е. вес 0)
      }
    }

    return result;
  }

  DomainCoffeeRecipe toDomainModel(Map<String, double> ingredientsAndWeightsMap) {
    return DomainCoffeeRecipe(recipeName, ingredientsAndWeightsMap);
  }

  @override
  String toString() {
    return "{id=$id, extra=$extra, canisterIds=$canisterIds, recipeName=$recipeName, stepses=$stepses, esAttr=$esAttr, instantAttr=$instantAttr, date=$date}";
  }
}