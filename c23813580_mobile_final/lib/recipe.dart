import 'package:flutter/material.dart';
import'package:http/http.dart' as http; //performs network requests
import 'dart:convert'; 


class Recipe extends StatefulWidget {
  final String title;
  const Recipe(this.title, {super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}
class _RecipeState extends State<Recipe> {
  Map<String, dynamic>? recipeDetails;

  @override
  void initState() {
  super.initState();
  fetchRecipe();
  }

  Future<void> fetchRecipe() async {
    final url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=${widget.title}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List mealsData = data['meals'];

      if (mealsData != null && mealsData.isNotEmpty) {
        setState(() {
        recipeDetails = mealsData[0];
        });
      }
    } else {
      throw Exception('Failed to load recipe');
    }
  }
   List<Widget> buildIngredients() {
    List<Widget> ingredientsList = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = recipeDetails?['strIngredient$i'];
      final measure = recipeDetails?['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().isNotEmpty &&
          measure != null &&
          measure.toString().isNotEmpty) {
        ingredientsList.add(
          Text('• $measure of $ingredient', style: const TextStyle(fontSize: 16)),
        );
      }
    }

    return ingredientsList;
  }
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: recipeDetails == null
          ? const Center(child: CircularProgressIndicator())
          :
          Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      // child: 
                      // Image.network(recipeDetails!['strMealThumb'], width: 300,),
                      child: Expanded(
                      flex: 7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(recipeDetails!['strMealThumb'], 
                          width: 250,
                          fit: BoxFit.cover,
                         
                        ),
                      ),
                    ),
                      
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                      recipeDetails!['strMeal'],
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    ),
                    
                    const SizedBox(height: 24),
                    const Text(
                      'Ingredients:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    ...buildIngredients(), 
                    const SizedBox(height: 24),
                    const Text(
                      'Instructions:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipeDetails!['strInstructions'],
                      style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
       ),
    );
  }
}
 
