//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Anh on 6/25/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(image: UIImage(systemName: "trophy"), style: .plain, target: self, action: #selector(scoreTapped))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion(action: nil)
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "Guess: \(countries[correctAnswer].uppercased())"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct"
            message = "Your score is \(score)."
        } else {
            score -= 1
            title = "Wrong"
            message = "Wrong! That's the flag of \(countries[correctAnswer]). Your score is \(score)."
        }
        
        questionsAnswered += 1
        
        if questionsAnswered == 10 {
            title = "Game finished"
            message = "Your final score was \(score)"
            score = 0
            questionsAnswered = 0
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: questionsAnswered == 10 ? "Restart" : "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    
    @objc func scoreTapped() {
        let ac = UIAlertController(title: "Your score is \(score)", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
