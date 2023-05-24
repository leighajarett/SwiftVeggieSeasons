//
//  Veggie.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 5/22/23.
//
import SwiftUI

enum VeggieCategory {
    case allium
    case berry
    case citrus
    case cruciferous
    case fern
    case flower
    case fruit
    case fungus
    case gourd
    case leafy
    case legume
    case melon
    case root
    case stealthFruit
    case stoneFruit
    case tropical
    case tuber
    case vegetable
}

enum Season {
    case winter
    case spring
    case summer
    case autumn
}

class Trivia {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int

    init(_ question: String, _ answers: [String], _ correctAnswerIndex: Int) {
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
}

let veggieCategoryNames: [VeggieCategory: String] = [
    .allium: "Allium",
    .berry: "Berry",
    .citrus: "Citrus",
    .cruciferous: "Cruciferous",
    .fern: "Technically a fern",
    .flower: "Flower",
    .fruit: "Fruit",
    .fungus: "Fungus",
    .gourd: "Gourd",
    .leafy: "Leafy",
    .legume: "Legume",
    .melon: "Melon",
    .root: "Root vegetable",
    .stealthFruit: "Stealth fruit",
    .stoneFruit: "Stone fruit",
    .tropical: "Tropical",
    .tuber: "Tuber",
    .vegetable: "Vegetable"
]

let seasonNames: [Season: String] = [
    .winter: "Winter",
    .spring: "Spring",
    .summer: "Summer",
    .autumn: "Autumn"
]

class Veggie {
    let id: Int
    let name: String
    let imageAssetPath: String
    let category: VeggieCategory
    let shortDescription: String
    let accentColor: Color
    let seasons: [Season]
    let vitaminAPercentage: Int
    let vitaminCPercentage: Int
    let servingSize: String
    let caloriesPerServing: Int
    let trivia: [Trivia]
    var isFavorite: Bool

    init(id: Int, name: String, imageAssetPath: String, category: VeggieCategory, shortDescription: String, accentColor: Color, seasons: [Season], vitaminAPercentage: Int, vitaminCPercentage: Int, servingSize: String, caloriesPerServing: Int, trivia: [Trivia], isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.imageAssetPath = imageAssetPath
        self.category = category
        self.shortDescription = shortDescription
        self.accentColor = accentColor
        self.seasons = seasons
        self.vitaminAPercentage = vitaminAPercentage
        self.vitaminCPercentage = vitaminCPercentage
        self.servingSize = servingSize
        self.caloriesPerServing = caloriesPerServing
        self.trivia = trivia
        self.isFavorite = isFavorite
    }

    var categoryName: String? {
        return veggieCategoryNames[category]
    }
}
