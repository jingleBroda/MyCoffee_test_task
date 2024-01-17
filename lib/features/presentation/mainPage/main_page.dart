import 'package:flutter/material.dart';
import 'package:my_coffe_test_task/features/domain/coffee_recipe_domain.dart';
import 'package:my_coffe_test_task/features/presentation/mainPage/main_page_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final dbHelper = DatabaseHelper();
  //final testIngredient = <String>["Зерна", "Горячая вода", "Молоко"];
  final controller = MainPageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('My Coffee'),
          ),
          body: FutureBuilder(
            future: controller.getRecipeList(),//dbHelper.getAllCoffeeRecipes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final recipe = snapshot.data as List<DomainCoffeeRecipe>;
              return ListView.builder(
                itemCount: recipe.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Card(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(recipe[index].recipeName),
                                ),
                                // Добавляем ExpansionTile для отображения ингредиентов
                                ExpansionTile(
                                  title: const Text('Ингредиенты:'),
                                  children: [
                                    // Отображаем список ингредиентов
                                    // Отображаем список ингредиентов
                                    Column(
                                      children: recipe[index].ingredientsAndWeightsMap.entries.map((entry) {
                                        return ListTile(
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(entry.key),
                                              Text(entry.value.toString()),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          )),
    );
  }
}
/*


 */

/*
// Отображаем список ингредиентов
                                    Column(
                                      children: testIngredient.map((ingredient) {
                                        return ListTile(
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(ingredient), // Название ингредиента слева
                                              const Text('35'), // Вес ингредиента справа
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      */

