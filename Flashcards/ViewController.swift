//
//  ViewController.swift
//  Flashcards
//
//  Created by Miguel Batilando on 2/6/20.
//  Copyright © 2020 miguel. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var extraAnswerOne: String
    var extraAnswerTwo: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    var correctAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // updateFlashcard
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the capital of Brazil?", answer: "Brasilia", firstExtraAnswer: "New York", secondExtraAnswer: "Canada", isExisting: true)
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
        
        // Card container
        self.cardView.layer.cornerRadius = 20.0
        self.cardView.layer.shadowRadius = 15.0
        self.cardView.layer.shadowOpacity = 0.3
        
        // Question and answer
        self.frontLabel.clipsToBounds = true
        self.frontLabel.layer.cornerRadius = 20.0
        self.backLabel.clipsToBounds = true
        self.backLabel.layer.cornerRadius = 20.0
        
        // Buttons
        self.firstButton.layer.borderWidth = 3.0
        self.firstButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.firstButton.layer.cornerRadius = 20.0
        self.secondButton.layer.borderWidth = 3.0
        self.secondButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.secondButton.layer.cornerRadius = 20.0
        self.thirdButton.layer.borderWidth = 3.0
        self.thirdButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.thirdButton.layer.cornerRadius = 20.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.cardView.alpha = 0.0
        self.firstButton.alpha = 0.0
        self.secondButton.alpha = 0.0
        self.thirdButton.alpha = 0.0
        
        self.cardView.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        self.firstButton.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        self.secondButton.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        self.thirdButton.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.cardView.alpha = 1.0
            self.firstButton.alpha = 1.0
            self.secondButton.alpha = 1.0
            self.thirdButton.alpha = 1.0
            self.cardView.transform = CGAffineTransform.identity
            self.firstButton.transform = CGAffineTransform.identity
            self.secondButton.transform = CGAffineTransform.identity
            self.thirdButton.transform = CGAffineTransform.identity
        })
    }
    
    func updateFlashcard(question: String, answer: String, firstExtraAnswer: String, secondExtraAnswer: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne:  firstExtraAnswer, extraAnswerTwo: secondExtraAnswer)
        
        // self.frontLabel.text = flashcard.question
        // self.backLabel.text = flashcard.answer
        
        if isExisting {
            self.flashcards.append(flashcard)
            print("Added flashcard! Current number: \(flashcards.count)")
            currentIndex = flashcards.count - 1
        }
        
        
        print("Current index: \(self.currentIndex)")
        
        self.updateLabels()
        self.updateNextPrevButtons()
        
        
        // self.firstButton.setTitle(firstExtraAnswer, for: .normal)
        // self.secondButton.setTitle(answer, for: .normal)
        // self.thirdButton.setTitle(secondExtraAnswer, for: .normal)
        
        
        self.saveFlashcardsToDisk()
    }
    
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            // self.nextButton.isEnabled = false
            nextButton.isEnabled = false
        }
        else {
            self.nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            self.prevButton.isEnabled = false
        }
        else {
            self.prevButton.isEnabled = true
        }
        
        // self.firstButton.isEnabled = true
        // self.secondButton.isEnabled = true
        // self.thirdButton.isEnabled = true
    }
    
    func updateLabels() {
        let currentFlashcard = self.flashcards[self.currentIndex]
        self.frontLabel.text = currentFlashcard.question
        self.backLabel.text = currentFlashcard.answer
        
        // self.firstButton.setTitle(currentFlashcard.extraAnswerOne, for: .normal)
        // self.secondButton.setTitle(currentFlashcard.answer, for: .normal)
        // self.thirdButton.setTitle(currentFlashcard.extraAnswerTwo, for: .normal)
        
        let buttons = [self.firstButton, self.secondButton, self.thirdButton].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.extraAnswerOne, currentFlashcard.extraAnswerTwo].shuffled()
        
        for (button, answer) in zip(buttons, answers) {
            button?.setTitle(answer, for: .normal)
            
            if answer == currentFlashcard.answer {
                self.correctAnswerButton = button
            }
        }
    }
    
    func saveFlashcardsToDisk() {
        let dictArray = self.flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer": card.answer, "extraAnswerOne": card.extraAnswerOne, "extraAnswerTwo": card.extraAnswerTwo]
        }
        
        UserDefaults.standard.set(dictArray, forKey: "flashcards")
        
        print("Flashcards saved to disk!")
    }
    
    func readSavedFlashcards() {
        if let dictArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            let savedCards = dictArray.map({ (dictionary) -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne: dictionary["extraAnswerOne"] ?? "", extraAnswerTwo: dictionary["extraAnswerTwo"] ?? "")
            })
            
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        self.flipFlashcard()
    }
    
    func flipFlashcard() {
        UIView.transition(with: cardView, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if self.frontLabel.isHidden == false {
                self.frontLabel.isHidden = true
            }
            else {
                self.frontLabel.isHidden = false
            }
            
        })
    }
    
    // tapped on next
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cardView.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }) { (finished) in
            self.animateCardIn()
            self.updateLabels()
        }
    }
    
    func animateCardIn() {
        cardView.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3) {
            self.cardView.transform = CGAffineTransform.identity
        }
    }
    
    // tapped on prev
    func animatePrevCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cardView.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }) { (finished) in
            self.animatePrevCardIn()
            self.updateLabels()
        }
    }
    
    func animatePrevCardIn() {
        cardView.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        UIView.animate(withDuration: 0.3) {
            self.cardView.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func didTapFirstButton(_ sender: Any) {
        // self.firstButton.isHidden = true
        if self.firstButton == correctAnswerButton {
            flipFlashcard()
        }
        else {
            frontLabel.isHidden = false
            firstButton.isEnabled = false
        }
    }
    
    @IBAction func didTapSecondButton(_ sender: Any) {
        // self.frontLabel.isHidden = true
        if self.secondButton == correctAnswerButton {
            flipFlashcard()
        }
        else {
            frontLabel.isHidden = false
            secondButton.isEnabled = false
        }
    }
    
    @IBAction func didTapThirdButton(_ sender: Any) {
        // self.thirdButton.isHidden = true
        if self.thirdButton == correctAnswerButton {
            flipFlashcard()
        }
        else {
            frontLabel.isHidden = false
            thirdButton.isEnabled = false
        }
    }
    
    @IBAction func didTapPrev(_ sender: Any) {
        self.currentIndex -= 1
        self.updateNextPrevButtons()
        self.updateLabels()
        self.animatePrevCardOut()
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        self.currentIndex += 1
        self.updateNextPrevButtons()
        // self.updateLabels()
        self.animateCardOut()
    }
    
    @IBAction func didTapDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete card", message: "You sure?", preferredStyle: .actionSheet)
        let deletAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deletAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard() {
        self.flashcards.remove(at: currentIndex)
        if flashcards.count == 1 {
            currentIndex = 0
        }
        else if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        self.updateNextPrevButtons()
        self.updateLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsViewController = self
        
        if segue.identifier == "editSegue" {
             creationController.initialQuestion = frontLabel.text
             creationController.initialAnswer = backLabel.text
             creationController.extraAnswerOne = firstButton.titleLabel?.text
             creationController.extraAnswerTwo = secondButton.titleLabel?.text
        }
        else if segue.identifier == "addSegue" {
            let currentFlashcard = self.flashcards[self.currentIndex]
            creationController.initialQuestion = currentFlashcard.question
            creationController.initialAnswer = currentFlashcard.answer
        }
    }
}

