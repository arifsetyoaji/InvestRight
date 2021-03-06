//
//  ChallengeViewController.swift
//  mc3-investor-app
//
//  Created by Adrian Renaldi on 30/07/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {

    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var challengeSummaryLabel: UILabel!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeTitleLabel2: UILabel!
    @IBOutlet weak var openPdfButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var challengeResultLabel: UILabel!
    @IBOutlet weak var challengeResultView: UIView!
    
    var challengeImage: UIImage?
    var challengeTitle: String?
    var challengeSummary: String?
    var valueTapped: Double?
    var currentLesson: Lesson?
    var helper = Helper()
    var isContinue: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = challengeTitle
        
        if let lesson = currentLesson {
            if lesson.challengeDesc != nil || lesson.challengeDesc != "" {
                challengeSummary = lesson.challengeDesc
            }
        }
        
        submitButton.layer.cornerRadius = 10.0
        challengeImageView.image = challengeImage
        challengeTitleLabel.text = challengeTitle
        challengeTitleLabel2.text = challengeTitle
        challengeSummaryLabel.text = challengeSummary
        challengeSummaryLabel.numberOfLines = 0
        challengeSummaryLabel.textAlignment = .left
        
        showResult(hidden: true, message: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PDFViewController {
            destination.currentLesson = currentLesson
        }
    }
    
    @IBAction func entityTapped(_ unwindSegue: UIStoryboardSegue) {
        if let value = valueTapped {
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let val = formatter.string(for: value)

            openPdfButton.setTitle(val, for: .normal)
            openPdfButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func openPDF(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToPDFViewer", sender: nil)
    }
    
    @IBAction func submitChallenge(_ sender: UIButton) {
        if !isContinue {
            if valueTapped == nil {
                challengeResultView.backgroundColor = .red
                showResult(hidden: false, message: "Wrong answer! Please try again 🙁")
            } else {
                challengeResultView.backgroundColor = .systemGreen
                showResult(hidden: false, message: "Correct! You unlock the next chapter 🥳")
                submitButton.setTitle("Continue", for: .normal)
                isContinue = true
                
                if let current = currentLesson {
                    if var nextLesson = helper.getLesson(key: "lesson_\(current.id!+1)") {
                        nextLesson.isLock = false
                        helper.saveLesson(lesson: nextLesson, key: nextLesson.code!)
                        NotificationCenter.default.post(name: NSNotification.Name("reload_data"), object: nil)
                    }
                }
            }
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func openHelper(_ sender: UIButton) {
    }

}


extension ChallengeViewController {
    
    func showResult(hidden: Bool, message: String) {
        challengeResultLabel.text = message
        challengeResultView.isHidden = hidden
    }
    
}
