//
//  CardModel.swift
//  Work Ethic Shit
//
//  Created by MBP on 17/02/2019.
//  Copyright © 2019 MBP. All rights reserved.
//

import Foundation


class CardModel {
    
    func getCards() -> [Card] {
        
        // Declare an array to store cards we've already generated
        var generatedNumbersArray = [Int]()
        
        // Declare an array to store the generated cards
        var generatedCardsArray = [Card]()

        // Randomly generated cards
       // for _ in 1...8 {
        while generatedNumbersArray.count < 8 {
            
        
            // Get a random number
            let randomNumber = arc4random_uniform(13) + 1
            
            // Ensure that random number isn't one we already have
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                
                // Log the random number
                print("generating random number: \(randomNumber)")
                
                // Store the number in generatedNumbersArray
                generatedNumbersArray.append(Int(randomNumber))
                
                // Create the first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardOne)
                
                
                // Create the second card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)
                
            }
        
        }
            
        // Randomize array
        for i in 0...generatedCardsArray.count-1 {
            
            // Find the random index to swap with
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
            
            // Swap the two cards
            let temporaryStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temporaryStorage
            
        }
        
        // Return array
        return generatedCardsArray
    }
    
}
