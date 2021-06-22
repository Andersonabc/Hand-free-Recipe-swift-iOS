//
//  RecommendProvider.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/22.
//

import Foundation
//import FirebaseFirestore

public struct RecommendProvider {
//    static func xx(id: Int) -> String{
//        let db = Firestore.firestore()
//        var name = ""
//        db.collection("Recipe").whereField("categoryId", arrayContains: id).limit(to: 1).getDocuments { snapshot, error in
//            if let snapshot = snapshot {
//                for document in snapshot.documents{
//                    let data = document.data()
//                    name = data["name"] as? String ?? ""
//                }
//            }
//
//         }
//        return name
//    }

    

    public static func all() -> [String] {
        return ["Summer Chicken-and-Pepper Stew", "Southern Savory Baked Chicken", "Grilled Chicken with Marinated Tomatoes and Onions", "Pollo al Pastor with Charred Tomato Salsa", "Smoky Skillet-Grilled Chicken with Crispy Bread", "Chicken Fricassee Stir-Fry with Asparagus", "Butter Chicken Calzones", "Rosemary-Roasted Chicken with Artichokes and Potatoes", "Balinese Grilled Chicken", "Chicken in a Pot with Lemon Orzo", "Gaeng Rawaeng", "Chicken Mole", "Roast Chicken with Chile-Basil Vinaigrette, Charred Broccoli, and Potatoes", "Soto Ayam", "Korean Fried Chicken with Soy Sauce", "Mole Verde con Pollo with Corn Tortillas", "Brisket-Braised Chicken","Creamed Corn Pasta", "Fried Yuba Tacos with Sweet Corn Relish", "Blistered Shishitos with Furikake Ranch and Crispy Quinoa", "Rainbow Vegetable Gratin", "Slow-Grilled Cauliflower with Tahina and Zhough", "Coal-Roasted Sweet Potatoes", "Grilled Mushrooms with Smoked Crème Fraîche", "Niños Envueltos Dominicanos (Dominican Stuffed Cabbage Rolls)", "Vigorón (Nicaraguan Cabbage and Yuca with Chicharrones)", "Carrot Cake Marmalade with Yogurt and Fresh Fruit", "Oto (Mashed Yam Patties)", "Grilled Verona Radicchio with Bottarga and Wild Apple Molasses", "Namasu", "Puntarelle-Citrus Salad with Roasted Beets"]
    }
    
    static func random() -> String {
      let allRecipe = self.all()
      let randomIndex = Int.random(in: 0..<allRecipe.count)
      return allRecipe[randomIndex]
    }
}
