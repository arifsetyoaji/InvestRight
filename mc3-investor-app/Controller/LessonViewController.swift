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
    var contents = ["Hello Elona, today Papa is going to teach you about how to buy a bssiness in stock market, but to simplify the rationale behind, I will use a simple business for an easier understanding\n\nSo, owning a share or stock, is actually owning a piece of the real business, let me give you a real life example of a Paper and Pulp Business, in this case, a paper company called INKP.", "Now if a business is doing well, it generates a lot of income, people are willing to buy it at 2-3 or even 5 times the original capital that is required to set up the business.\n\nHowever if the business is not doing well, or even losing money, people are not willing to buy it at the original capital used to set up the business.\n\nSome are not interested at all with the business, while others might still see some value, but will value it at 1/2 the original capital or even 1/3 or lower.", "These are some basic financial ratios that is present in any businesses, and you will be well advised to take a look at these ratios and hope that they are healthy for you to even consider buying them, let’s take this company INKP for example:\n\nTotal Asset USD 8.386.259.000 \nTotal Liability USD 4.204.955.000 \nTotal Equity USD 4.181.304.000","Equity represents the value that would be returned to a company’s shareholders if all of the assets were liquidated and all of the company's debts were paid off."]
    
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
            
            let txt1 = UILabel.init(frame: CGRect(x: 32, y: 0, width: scrollWidth - 64, height: scrollHeight))
            txt1.textAlignment = .left
            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
            txt1.numberOfLines = 0
            txt1.lineBreakMode = .byWordWrapping
            txt1.text = contents[index]
            
            slide.addSubview(txt1)
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
