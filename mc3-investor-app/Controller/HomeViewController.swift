//
//  HomeViewController.swift
//  mc3-investor-app
//
//  Created by Muhammad Arif Setyo Aji on 15/07/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    struct Lesson {
        let name: String?
        let image: UIImage?
        var isLock: Bool = true
    }
    
    let lessonData : [Lesson] = [
        Lesson(name: "Outstanding Share", image: UIImage(named: "dummy_image"), isLock: false),
        Lesson(name: "Find Liabilities", image: UIImage(named: "dummy_image"), isLock: true),
        Lesson(name: "Find Equities", image: UIImage(named: "dummy_image"), isLock: true),
        Lesson(name: "Calculate Book Value", image: UIImage(named: "dummy_image"), isLock: true),
        Lesson(name: "Calculate Earning Ratio", image: UIImage(named: "dummy_image"), isLock: true),
    ]
    
    @IBOutlet weak var lessonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lessonCollectionView.delegate = self
        lessonCollectionView.dataSource = self
        
        lessonCollectionView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.isNavigationBarHidden = true
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
        
        cell.lessonImage.image = item.image
        cell.lessonName.text = item.name
        
        if item.isLock {
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
        performSegue(withIdentifier: "GoToLessonSegue", sender: lessonData[indexPath.row].name)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LessonViewController {
            destination.lessonTitle = sender as? String
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
