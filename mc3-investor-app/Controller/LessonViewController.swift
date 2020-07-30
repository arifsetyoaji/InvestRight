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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        

    }
    

}

extension LessonViewController {
    
    func setupView(){
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = lessonTitle
        
        //startChallengeButton.layer.cornerRadius = 10.0
    }
    
}
