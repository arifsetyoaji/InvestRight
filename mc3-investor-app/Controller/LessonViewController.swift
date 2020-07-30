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
    var contents = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed volutpat convallis blandit. Sed non maximus leo. Praesent scelerisque ipsum id urna congue aliquam.", "Proin laoreet sollicitudin risus, sit amet lacinia dolor fringilla sed. Nullam at turpis ac lectus accumsan imperdiet. Vestibulum pretium velit eu sem auctor consectetur.", "Curabitur tristique, elit sed laoreet dictum, eros mauris finibus velit, at congue sem nibh vel massa. In luctus imperdiet risus at ornare. Aenean eget dui luctus, eleifend ex eget, euismod quam."]
    
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
            txt1.textAlignment = .center
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
