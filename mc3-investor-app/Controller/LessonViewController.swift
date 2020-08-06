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
    
    var scrollHeight: CGFloat! = 0.0
    var scrollWidth: CGFloat! = 0.0
    var lesson: Lesson?
    var indexPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        navigationController?.isNavigationBarHidden = false
        if let lesson = lesson {
            navigationItem.title = lesson.name
        }
        setupLessonSlider()
        
        startChallengButton.layer.cornerRadius = 10.0
        startChallengButton.setTitle("Continue", for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        scrollWidth = lessonScrollView.frame.size.width
        scrollHeight = lessonScrollView.frame.size.height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChallengeViewController {
            if let lesson = lesson {
                destination.challengeImage = UIImage(named: "1-lesson")
                destination.challengeTitle = lesson.name
                destination.currentLesson = lesson
            }
        }
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        lessonScrollView.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat(lessonPageControl.currentPage), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    @IBAction func startChallenge(_ sender: UIButton) {
        if startChallengButton.title(for: .normal) == "Start Challenge" {
            performSegue(withIdentifier: "GoToChallengeSegue", sender: nil)
        }
    }
    
    
    
    @IBAction func continueTapped(_ sender: UIButton) {
        if let lesson = lesson {
            setIndicatorForCurrentPage()
            if indexPage >= lesson.desc1.count {
                indexPage = 0  //Repeat to first slide
                scrollToPage(page: 0, animated: true)
            } else {
                scrollToPage(page: indexPage+1, animated: true)
                lessonPageControl.currentPage = indexPage+1
                indexPage += 1
            }
            
        }
    }
    
    func setupPage(){
        let page = (lessonScrollView.contentOffset.x)/scrollWidth
        lessonPageControl.currentPage = Int(page)
        indexPage = Int(page)
    }
}

extension LessonViewController: UIScrollViewDelegate {
    
    func setupLessonSlider() {
        setupPage()
        
        self.lessonScrollView.delegate = self
        lessonScrollView.isPagingEnabled = true
        lessonScrollView.showsHorizontalScrollIndicator = false
        lessonScrollView.showsVerticalScrollIndicator = false
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        if let lesson = lesson {
            for index in 0..<lesson.desc1.count {
                frame.origin.x = scrollWidth * CGFloat(index)
                frame.size = CGSize(width: scrollWidth, height: scrollHeight)
                let slide = UIView(frame: frame)
                
                let slideImage = UIImageView.init(image: UIImage(named: lesson.image!))
                slideImage.frame = CGRect(x: 32, y: 28, width: 55, height: 55)
                slideImage.contentMode = .scaleAspectFit
                //slideImage.center = CGPoint(x: scrollWidth/2, y: scrollHeight/2 - 15)
                
                let slideTitle = UILabel.init(frame: CGRect(x: 95, y: 28, width: 144, height: 55))
                slideTitle.font = .boldSystemFont(ofSize: 17)
                slideTitle.textAlignment = .left
                slideTitle.numberOfLines = 0
                slideTitle.lineBreakMode = .byWordWrapping
                slideTitle.text = lesson.name
                
                let txt1 = UILabel.init(frame: CGRect(x: 32, y: 65, width: scrollWidth - 64, height: scrollHeight / 3))
                txt1.textAlignment = .left
                txt1.numberOfLines = 0
                txt1.lineBreakMode = .byWordWrapping
                txt1.text = lesson.desc1[index]
                
                var txt2Yposition: CGFloat = 180
                if lesson.descImage[index] != "" {
                    let imageView = UIImageView.init(image: UIImage(named: lesson.descImage[index]!))
                    imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                    imageView.contentMode = .scaleAspectFit
                    imageView.center = CGPoint(x: scrollWidth/2, y: scrollHeight/2 + 30)
                    slide.addSubview(imageView)
                    
                    txt2Yposition = 430
                }
                
                let txt2 = UILabel.init(frame: CGRect(x: 32, y: txt2Yposition, width: scrollWidth - 64, height: scrollHeight/3))
                txt2.textAlignment = .left
                txt2.numberOfLines = 0
                txt2.lineBreakMode = .byWordWrapping
                txt2.text = lesson.desc2[index]
                
                slide.addSubview(slideImage)
                slide.addSubview(slideTitle)
                slide.addSubview(txt1)
                slide.addSubview(txt2)
                lessonScrollView.addSubview(slide)
            }
            
            lessonScrollView.contentSize = CGSize(width: scrollWidth * CGFloat(lesson.desc1.count), height: scrollHeight)
            lessonScrollView.contentSize.height = 1.0
            
            lessonPageControl.numberOfPages = lesson.desc1.count
            lessonPageControl.currentPage = indexPage
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndicatorForCurrentPage()
    }
    
    func setIndicatorForCurrentPage() {
        let page = (lessonScrollView.contentOffset.x)/scrollWidth
        lessonPageControl.currentPage = Int(page)
        if let lesson = lesson {
            if Int(page) >= lesson.desc1.count-1 {
                startChallengButton.setTitle("Start Challenge", for: .normal)
            } else {
                startChallengButton.setTitle("Continue", for: .normal)
            }
        }
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.lessonScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.lessonScrollView.scrollRectToVisible(frame, animated: animated)
    }
}
