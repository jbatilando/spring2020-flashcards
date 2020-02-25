//
//  ViewController.swift
//  Flashcards
//
//  Created by Miguel Batilando on 2/6/20.
//  Copyright © 2020 miguel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Card container
        self.card.layer.cornerRadius = 20.0
        self.card.layer.shadowRadius = 15.0
        self.card.layer.shadowOpacity = 0.3
        
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
    
    func updateFlashcard(question: String, answer: String, firstExtraAnswer: String?, secondExtraAnswer: String?) {
        self.frontLabel.text = question
        self.backLabel.text = answer
        
        self.firstButton.setTitle(firstExtraAnswer, for: .normal)
        self.secondButton.setTitle(answer, for: .normal)
        self.thirdButton.setTitle(secondExtraAnswer, for: .normal)
    }
    
    @IBAction func didTapFirstButton(_ sender: Any) {
        self.firstButton.isHidden = true
    }
    
    @IBAction func didTapSecondButton(_ sender: Any) {
        self.frontLabel.isHidden = true
    }
    
    @IBAction func didTapThirdButton(_ sender: Any) {
        self.thirdButton.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsViewController = self
        
        if segue.identifier == "editSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
}

