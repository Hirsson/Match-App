//
//  CardCollectionViewCell.swift
//  Work Ethic Shit
//
//  Created by MBP on 22/03/2019.
//  Copyright © 2019 MBP. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
  
  //  @IBOutlet weak var frontImageView: UIImageView!
    
    //  @IBOutlet weak var backImageView: UIImageView!}
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        // Keep track of the card that gets passed in
        self.card = card
        
        frontImageView.image = UIImage(named: card.imageName)
        
        print(card.imageName)
        
        if card.isMatched == true {
            
            
              // If the card has been matched, then make the image views invisible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        }
        else {
            
              // If the card hasn't been matched, then make the image views visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        
     //   frontImageView.image = UIImage(named: card.imageName)
        
        // Determine if card in fliped up state or flipped down state
        if card.isFlipped == true {
            // Make sure the frontImageView is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else {
            // Make sure the backImageView is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        
    }
 
    func flip() {
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        
        UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
        }
    }
    
    func remove() {
        
        // Remove the both imageViews from being visible
        backImageView.alpha = 0
        
        // TODO: Animiate it
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion: nil)
    
      //  UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
        }
        
    }
    


