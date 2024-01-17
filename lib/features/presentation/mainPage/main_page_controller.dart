import 'package:my_coffe_test_task/features/data/data_repository.dart';
import 'package:my_coffe_test_task/features/domain/coffee_recipe_domain.dart';
import 'package:my_coffe_test_task/features/domain/domain_repository.dart';

class MainPageController {
  //emulation a Interactor (and inject/ i don't know how use inject in flutter)
  final DomainRepository repository = DataRepository();

  Future<List<DomainCoffeeRecipe>> getRecipeList() async {
    return repository.getRecipeList();
  }
}
