//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Miguel Batilando on 2/25/20.
//  Copyright © 2020 miguel. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var firstExtraAnswerTextField: UITextField!
    @IBOutlet weak var secondExtraAnswerTextField: UITextField!
    
    // MARK: Variables
    var initialQuestion: String?
    var initialAnswer: String?
    var extraAnswerOne: String?
    var extraAnswerTwo: String?

    // MARK: Lifecycle
    var flashcardsViewController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        firstExtraAnswerTextField.text = extraAnswerOne
        secondExtraAnswerTextField.text = extraAnswerTwo
    }
    
    // MARK: IBActions
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let firstExtraAnswer = firstExtraAnswerTextField.text ?? ""
        let secondExtraAnswer = secondExtraAnswerTextField.text ?? ""
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            let alert = UIAlertController(title: "Missing Text", message: "Please enter text", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        }
        else {
            var isExisting = false
            if self.initialQuestion != nil {
                isExisting = true
            }
            flashcardsViewController.updateFlashcard(question: questionText!, answer: answerText!, firstExtraAnswer: firstExtraAnswer, secondExtraAnswer: secondExtraAnswer, isExisting: isExisting)
            dismiss(animated: true)
        }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
