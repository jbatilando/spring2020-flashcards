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
    
    @IBAction func didTapFirstButton(_ sender: Any) {
        self.firstButton.isHidden = true
    }
    
    @IBAction func didTapSecondButton(_ sender: Any) {
        self.frontLabel.isHidden = true
    }
    
    @IBAction func didTapThirdButton(_ sender: Any) {
        self.thirdButton.isHidden = true
    }
}

