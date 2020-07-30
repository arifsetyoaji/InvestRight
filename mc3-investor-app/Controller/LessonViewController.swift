//
//  LessonViewController.swift
//  mc3-investor-app
//
//  Created by Muhammad Arif Setyo Aji on 15/07/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {

    var lessonTitle: String?
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var startChallengeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        contentImageView.image = UIImage(named: "content-image")
    }
    

}

extension LessonViewController {
    
    func setupView(){
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = lessonTitle
        
        startChallengeButton.layer.cornerRadius = 10.0
    }
    
}
