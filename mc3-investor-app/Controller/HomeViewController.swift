//
//  HomeViewController.swift
//  mc3-investor-app
//
//  Created by Muhammad Arif Setyo Aji on 15/07/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var lessonData : [Lesson] = []
    var helper = Helper()
    
    @IBOutlet weak var lessonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonCollectionView.delegate = self
        lessonCollectionView.dataSource = self
        
        lessonCollectionView.showsVerticalScrollIndicator = false
        
        initData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notification:)), name: NSNotification.Name("reload_data"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func initData() {
        lessonData = []
        let lessons: [Lesson] = [
            Lesson(id: 1, code: "lesson_1", name: "Equity", image: "1-lesson", desc1: ["Hi Investors! Today, We are going to teach you about how to buy a business, in stock market, but to simplify the rationale behind, We will use a simple business for an easier understanding.", "Now if a business is doing well, it generates a lot of income, people are willing to buy it at 2-3 or even 5 times the original capital that is required to set up the business.", "Now you should have a better idea of what good business and what is a bad business."], desc2: ["So owning a share or stock, is actually owning a piece of the real business, Let me give you a real life example of a paper and pulp business , in this case, a paper company called INKP", "However if the business is not doing well, or even losing money, people are not willing to buy it at the original capital used to set up the business. some are not interested at all with the business, while others might still see some value, but will value it at 1/2 the original capital or even 1/3 or lower.", "There are some basic financial ratios that is present in any businesses, and you will be well advised to take a look at these ratios and hope that they are healthy for you to even consider buying them. In the next exploration, you’ll start to unravel these ratios."], descImage: ["1-lesson", "2-lesson", ""], isLock: false),
            Lesson(id: 2, code: "lesson_2", name: "Find Liabilities", image: "2-lesson", desc1: [""], desc2: [""], descImage: [""], isLock: true),
            Lesson(id: 3, code: "lesson_3", name: "Price to Equity Ratio", image: "3-lesson", desc1: [""], desc2: [""], descImage: [""], isLock: true),
            Lesson(id: 4, code: "lesson_4", name: "Price to Book Value", image: "4-lesson", desc1: [""], desc2: [""], descImage: [""], isLock: true),
            Lesson(id: 5, code: "lesson_5", name: "Debt to Equity Ratio", image: "5-lesson", desc1: [""], desc2: [""], descImage: [""], isLock: true),
            Lesson(id: 6, code: "lesson_6", name: "Margin of Safety", image: "6-lesson", desc1: [""], desc2: [""], descImage: [""], isLock: true),
        ]
        
        lessons.forEach { (lesson) in
            let savedLesson = helper.getLesson(key: lesson.code!)
            if savedLesson != nil {
                lessonData.append(savedLesson!)
            } else {
                helper.saveLesson(lesson: lesson, key: lesson.code!)
                lessonData.append(lesson)
            }
        }
        lessonCollectionView.reloadData()
    }
    
    @objc func reloadData(notification: NSNotification) {
        initData()
    }
}

// MARK: - Collection View Delegate and Datasource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = lessonCollectionView.dequeueReusableCell(withReuseIdentifier: "lessonCell", for: indexPath) as! LessonCell
        let item = lessonData[indexPath.row]
        
        cell.lessonImage.image = UIImage(named: item.image!)
        cell.lessonName.text = item.name
        
        if item.isLock! {
            cell.isUserInteractionEnabled = false
            cell.lockImageView.isHidden = false
            cell.lockImageView.image = UIImage(named: "lock-lesson")
        } else {
            cell.isUserInteractionEnabled = true
            cell.lockImageView.isHidden = true
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToLessonSegue", sender: lessonData[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LessonViewController {
            destination.lesson = sender as? Lesson
        }
    }
    
}


// MARK: - Setting Collection View Layout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (UIScreen.main.bounds.width/2) - 30

        return CGSize(width: width, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
