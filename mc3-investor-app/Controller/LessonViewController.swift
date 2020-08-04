//
//  LessonViewController.swift
//  mc3-investor-app
//
//  Created by Muhammad Arif Setyo Aji on 15/07/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {

    @IBOutlet weak var lessonScrollView: UIScrollView!
    @IBOutlet weak var lessonPageControl: UIPageControl!
    @IBOutlet weak var startChallengButton: UIButton!
    
    var lessonTitle: String?
    var scrollHeight: CGFloat! = 0.0
    var scrollWidth: CGFloat! = 0.0
    
    var contents: [[String:String]] = [
        ["text1": "Hi Investors! Today, We are going to teach you about how to buy a business, in stock market, but to simplify the rationale behind, We will use a simple business for an easier understanding.", "image": "1-lesson", "text2":"So owning a share or stock, is actually owning a piece of the real business, Let me give you a real life example of a paper and pulp business , in this case, a paper company called INKP"],
        ["text1": "Now if a business is doing well, it generates a lot of income, people are willing to buy it at 2-3 or even 5 times the original capital that is required to set up the business.", "image": "2-lesson", "text2": "However if the business is not doing well, or even losing money, people are not willing to buy it at the original capital used to set up the business. some are not interested at all with the business, while others might still see some value, but will value it at 1/2 the original capital or even 1/3 or lower."],
        ["text1": "Now you should have a better idea of what good business and what is a bad business.", "image": "", "text2": "There are some basic financial ratios that is present in any businesses, and you will be well advised to take a look at these ratios and hope that they are healthy for you to even consider buying them. In the next exploration, you’ll start to unravel these ratios."]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = lessonTitle
        
        startChallengButton.layer.cornerRadius = 10.0
        
        setupLessonSlider()
    }
    
    override func viewDidLayoutSubviews() {
        scrollWidth = lessonScrollView.frame.size.width
        scrollHeight = lessonScrollView.frame.size.height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChallengeViewController {
            destination.challengeTitle = lessonTitle
        }
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        lessonScrollView.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat(lessonPageControl.currentPage), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    @IBAction func startChallenge(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToChallengeSegue", sender: nil)
    }
}

extension LessonViewController: UIScrollViewDelegate {
    
    func setupLessonSlider() {
        self.lessonScrollView.delegate = self
        lessonScrollView.isPagingEnabled = true
        lessonScrollView.showsHorizontalScrollIndicator = false
        lessonScrollView.showsVerticalScrollIndicator = false
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        for index in 0..<contents.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
            let slide = UIView(frame: frame)
            
            let txt1 = UILabel.init(frame: CGRect(x: 32, y: 0, width: scrollWidth - 64, height: scrollHeight / 3))
            txt1.textAlignment = .left
            txt1.numberOfLines = 0
            txt1.lineBreakMode = .byWordWrapping
            txt1.text = contents[index]["text1"]
            
            var txt2Yposition: CGFloat = 120
            if contents[index]["image"] != "" {
                let imageView = UIImageView.init(image: UIImage(named: contents[index]["image"]!))
                imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                imageView.contentMode = .scaleAspectFit
                imageView.center = CGPoint(x: scrollWidth/2, y: scrollHeight/2 - 15)
                slide.addSubview(imageView)
                
                txt2Yposition = 420
            }
            
            let txt2 = UILabel.init(frame: CGRect(x: 32, y: txt2Yposition, width: scrollWidth - 64, height: scrollHeight/3))
            txt2.textAlignment = .left
            txt2.numberOfLines = 0
            txt2.lineBreakMode = .byWordWrapping
            txt2.text = contents[index]["text2"]
            
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            lessonScrollView.addSubview(slide)
        }
        
        lessonScrollView.contentSize = CGSize(width: scrollWidth * CGFloat(contents.count), height: scrollHeight)
        lessonScrollView.contentSize.height = 1.0
        
        lessonPageControl.numberOfPages = contents.count
        lessonPageControl.currentPage = 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndicatorForCurrentPage()
    }
    
    func setIndicatorForCurrentPage() {
        let page = (lessonScrollView.contentOffset.x)/scrollWidth
        lessonPageControl.currentPage = Int(page)
    }
}
