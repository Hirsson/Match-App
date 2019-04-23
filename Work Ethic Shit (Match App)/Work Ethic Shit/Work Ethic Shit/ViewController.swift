 //
//  ViewController.swift
//  Work Ethic Shit
//
//  Created by MBP on 17/02/2019.
//  Copyright © 2019 MBP. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

   // @IBOutlet weak var CollectionView: UICollectionView!
   
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var timer:Timer?
    var miliseconds:Float = 30 * 1000
    
  //  var soundManager = SoundManager()
    
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    
        // Call getCards method of card model
        cardArray = model.getCards()
        
        // CollectionView.delegate = self
        // CollectionView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Create Timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(TimerElapesed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        // Set cell size
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let width = self.collectionView.frame.size.width
        let itemWidth = (width - (10*3))/4
        let itemHight = itemWidth * 1.4177
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHight)
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        
        // Play shuffle sound
        // soundManager.playSound(.shuffle)
        SoundManager.playSound(.shuffle)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any recources that can be recreated
    }
    

    // MARK: Timer Methods
    @objc func TimerElapesed() {
        
        miliseconds -= 1
        
        // Convert to seconds
        //let seconds = String(format: "%.2f", arguments: miliseconds/1000)
        let seconds = String(format: "%.2f", miliseconds/1000)
        
        // Set Label
        timerLabel.text = "Time Remaining: \(seconds)"
        
        // When the timer reached 0...
        if miliseconds <= 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            // Check if there are any cards unmatched
            checkGameEnded()
            
        }
        
        
    }
    
    // MARK: UICollectionView Protocols Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get CardCollectionViewCell object
      //  let cell =
      //      collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the card the collectionView is trying to display
        let card = cardArray[indexPath.row]
        
        // Set that card for cell
        cell.setCard(card)
        
        return cell
    
    }
    
    // func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        // Check if there is any time left
        if miliseconds <= 0 {
            return
        }
        
        // Get the cell that user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
      
        // Get the card that user selected
        let card = cardArray[indexPath.row]
        
        //  if card.isFlipped == false
        if card.isFlipped == false && card.isMatched == false {
            
            // Flip the card
            cell.flip()
            
            // Play the flip sound
           // soundManager.playSound(.flip)
            SoundManager.playSound(.flip)
            
            // Set the status of the card
            card.isFlipped = true
            
            // Determine if it's first card or second card that's flipped over
            
            if firstFlippedCardIndex == nil {
                
            // This the first card that being flipped
            firstFlippedCardIndex = indexPath
            }
            
            else {
                // This is second card that being flipped
                
                //TODO: Perform matching logic
                checkForMatches(indexPath)
            }
            
        }

    }   // End of didSelectItemAt method

    // MARK: Game Logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath) {
        
        // Get the cells for the two cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        
        // Get the cards for the two cards that were revealed
      //  let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        
        // Get the cards for two cards that were revealed
        //let cardOne = cardArray(firstFlippedCardIndex!.row)
        //let cardTwo = cardArray(secondFlippedCardIndex.row)
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        // Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            // IT's a match
            
            // Play sound
           // soundManager.playSound(.match)
            SoundManager.playSound(.match)
            
            // Set the statuses of the cards
            //cardOne.isMatch = true
            //cardTwo.isMatch = true
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove cards form the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
         
            // Check if there are any cards unmatched
            checkGameEnded()
            
        }
        else {
            
            // It's not a match
            
            // Play sound
           // soundManager.playSound(.nomatch)
            SoundManager.playSound(.nomatch)
            
            // Set the statuses of cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
        }
            
         // Tell collectionView to reload the cell of the first card if it is nil
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
            
        }
        
        // Reset the property that tracks the first card flipped
        firstFlippedCardIndex = nil

    }
    
    func checkGameEnded() {
    
    // Determine if there are any cards unmatched
    var isWon = true
    
    for card in cardArray {
    
        if card.isMatched == false {
            isWon = false
            break
        }
    
    }
        
    //
        var title = ""
        var message = ""
        
    // If not, user has won, stop the timer
        if isWon == true {
            
            if miliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Congratulations"
            message = "You've won"
            
        }
        
        else {
              // If there are unmatched cards check does user has any time left
         
            if miliseconds > 0 {
                return
            }
            
            title = "Game Over"
            message = "You've lost"
            
        }
        
        // Show won/list messaging
        
     //   let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
     //   let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
     //   alert.addAction(alertAction)
        
     //   present(alert, animated: true, completion: nil)
        
        showAlert(title, message)

        
    }
    
    func showAlert(_ title:String, _ message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    

    
}   // End of ViewContoller Class

