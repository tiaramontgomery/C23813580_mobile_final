import 'package:flutter/material.dart';
import 'mealcard.dart';
import 'recipe.dart';
import'package:http/http.dart' as http; //performs network requests
import 'dart:convert'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: "Cookbook+"), 
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> meals = [];
  String selectedCategory = 'Starter'; 

  Future<void> fetchMeals(String category) async {
    final url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List mealsData = data['meals'];

      List<Widget> loadedMeals = [];

      for (var meal in mealsData) {
        var title = meal['strMeal'];
        var img = meal['strMealThumb'];
        

        loadedMeals.add(Mealcard(img, title));
      }

       setState(() {
        selectedCategory = category;
        meals = mealsData.take(6).map((meal) {
        var title = meal['strMeal'];
        var img = meal['strMealThumb'];
        return Mealcard(img, title);
      }).toList();
    });
  } else {
    throw Exception('Failed to load meals');
  }
  
  }
  @override
  void initState() {
  super.initState();
  fetchMeals('Starter'); 
}

 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      
      title: const Text("Cookbook+"),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 90,
                height: 40,
                child: 
                TextButton(
                style: TextButton.styleFrom(
                backgroundColor: selectedCategory == 'Starter' ? Colors.red[700] : Colors.red, 
                textStyle: const TextStyle(fontSize: 15), shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                ),), 
                onPressed: () => fetchMeals('Starter'),
                child: const Text('Starters', style: TextStyle(color: Colors.white)),

              ),
              ),
              
              SizedBox(
                width: 90,
                height: 40,
                child: 
                TextButton(
                style: TextButton.styleFrom(
                backgroundColor: selectedCategory == 'Beef' ? Colors.red[700] : Colors.red, 
                textStyle: const TextStyle(fontSize: 15), shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                ),), 
                onPressed: () => fetchMeals('Beef'),
                child: const Text('Mains', style: TextStyle(color: Colors.white)),

              ),
              ),
             SizedBox(
                width: 90,
                height: 40,
                child: 
                TextButton(
                style: TextButton.styleFrom(
                backgroundColor: selectedCategory == 'Dessert' ? Colors.red[700] : Colors.red, 
                textStyle: const TextStyle(fontSize: 15), shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                ),), 
                onPressed: () => fetchMeals('Dessert'),
                child: const Text('Desserts', style: TextStyle(color: Colors.white)),

              ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: meals,
          ),
        ),
      ],
    ),
  );
}
}