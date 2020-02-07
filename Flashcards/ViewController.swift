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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcards(_ sender: Any) {
        self.frontLabel.isHidden = true
    }
    
}

