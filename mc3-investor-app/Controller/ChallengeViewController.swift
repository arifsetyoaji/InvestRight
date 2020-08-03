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
    @IBOutlet weak var openPdfButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    var challengeTitle: String?
    var challengeSummary = "Find the number of equity by looking for these words:\n\nEquity attributable to owners of the parent\n\nin this case : the equity is USD 4.180.792.000"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = challengeTitle
        
        submitButton.layer.cornerRadius = 10.0
        challengeTitleLabel.text = challengeTitle
        challengeSummaryLabel.text = challengeSummary
        challengeSummaryLabel.numberOfLines = 0
        challengeSummaryLabel.textAlignment = .left
    }
    
    @IBAction func entityTapped(_ unwindSegue: UIStoryboardSegue) {
        print("finished")
    }
    
    @IBAction func openPDF(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToPDFViewer", sender: nil)
    }
    
    @IBAction func submitChallenge(_ sender: UIButton) {
    }
    
    @IBAction func openHelper(_ sender: UIButton) {
    }

}
