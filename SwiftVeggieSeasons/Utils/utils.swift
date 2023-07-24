//
//  utils.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/21/23.
//

import Foundation

func saveData(data: Any, key: String){
    let defaults = UserDefaults.standard
    defaults.set(data, forKey: key)
}

func removeData(key: String){
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey: key)
}

func loadData(key: String) -> Any? {
    let defaults = UserDefaults.standard
    return defaults.object(forKey: key)
}


func keyExists(key: String) -> Bool {
    let data = loadData(key:key)
    return data != nil
}

func getCal() -> Double {
    let calorieTarget: Double = loadData(key: "calorie") as! Double? ?? 2000.0
    return calorieTarget
}

func getCategories() -> Set<String> {
    let categories = Set(veggieCategoryNames.values)
    return categories
}

func getPreferredCategories() -> Set<String>{
    let categories = getCategories()
    let preferredCategories = keyExists(key: "categories") ? Set(loadData(key: "categories") as? Array<String> ?? []) : categories
    return preferredCategories
}




