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
            Lesson(id: 0, code: "lesson_0", name: "Stock Investing", image: "0-lesson", desc1: ["Hi Investors! Today, We are going to teach you about how to buy a business, in stock market, but to simplify the rationale behind, We will use a simple business for an easier understanding.", "Now if a business is doing well, it generates a lot of income, people are willing to buy it at 2-3 or even 5 times the original capital that is required to set up the business.", "Now you should have a better idea of what good business and what is a bad business."], desc2: ["So owning a share or stock, is actually owning a piece of the real business, Let me give you a real life example of a paper and pulp business , in this case, a paper company called INKP", "However if the business is not doing well, or even losing money, people are not willing to buy it at the original capital used to set up the business. some are not interested at all with the business, while others might still see some value, but will value it at 1/2 the original capital or even 1/3 or lower.", "There are some basic financial ratios that is present in any businesses, and you will be well advised to take a look at these ratios and hope that they are healthy for you to even consider buying them. In the next exploration, you’ll start to unravel these ratios."], descImage: ["1-lesson", "2-lesson", ""], challengeDesc: "Find the number of equity by looking for these words:\n\nEquity attributable to owners of the parent\n\nin this case : the equity is USD 4.180.792.000", stringSearch: "Modal ditempatkan dan disetor\npenuh - 5.470.982.941 saham", valueSearch: 5470982941, isLock: false),
            
            Lesson(id: 1, code: "lesson_1", name: "Issued & Fully Paid Share", image: "1-lesson", desc1: ["Fully paid shares are shares issued for which no more money is required to be paid to the company by shareholders on the value of the shares."], desc2: ["It’s better to have a company that does not keep issuing new shares because that means the existing shares are diluted."], descImage: ["1-lesson", "2-lesson", ""], challengeDesc: "Find the number of issued and fully paid shares in the quarterly earning report by looking for this key words Issued and fully paid", stringSearch: "Modal ditempatkan dan disetor\npenuh - 5.470.982.941 saham", valueSearch: 5470982941, isLock: true),
            
            Lesson(id: 2, code: "lesson_2", name: "Equity", image: "2-lesson", desc1: ["Hi Investors! Today, We are going to teach you about how to buy a business, in stock market, but to simplify the rationale behind, We will use a simple business for an easier understanding.", "Now if a business is doing well, it generates a lot of income, people are willing to buy it at 2-3 or even 5 times the original capital that is required to set up the business.", "Now you should have a better idea of what good business and what is a bad business."], desc2: ["So owning a share or stock, is actually owning a piece of the real business, Let me give you a real life example of a paper and pulp business , in this case, a paper company called INKP", "However if the business is not doing well, or even losing money, people are not willing to buy it at the original capital used to set up the business. some are not interested at all with the business, while others might still see some value, but will value it at 1/2 the original capital or even 1/3 or lower.", "There are some basic financial ratios that is present in any businesses, and you will be well advised to take a look at these ratios and hope that they are healthy for you to even consider buying them. In the next exploration, you’ll start to unravel these ratios."], descImage: ["1-lesson", "2-lesson", ""], challengeDesc: "Find the number of equity by looking for these words:\n\nEquity attributable to owners of the parent\n\nin this case : the equity is USD 4.180.792.000", stringSearch: "Ekuitas yang dapat diatribusikan kepada pemilik entitas induk", valueSearch: 4180792, isLock: true),
            
            Lesson(id: 3, code: "lesson_3", name: "Liability", image: "3-lesson", desc1: ["A liability is something a person or company owes, usually a sum of money. Liabilities are settled over time through the transfer of economic benefits including money, goods, or services. Recorded on the right side of the balance sheet, liabilities include loans, accounts payable, mortgages, deferred revenues, bonds, warranties, and accrued expenses."], desc2: ["Liability is Debt, and generally the lesser the debt, the better it is for companies, however for banking and construction, we do need high liability or Debt because that is how their business generate money."], descImage: ["1-lesson", "2-lesson"], challengeDesc: "", stringSearch: "", valueSearch: 4204955, isLock: true),
            
            Lesson(id: 4, code: "lesson_4", name: "Earning Per Share", image: "4-lesson", desc1: ["Earnings per share (EPS) is calculated as a company's profit divided by the outstanding shares of its common stock. The resulting number serves as an indicator of a company's profitability. The higher a company's EPS, the more profitable it is considered."], desc2: ["The higher the EPS, it means the better the business is performing."], descImage: ["1-lesson", "2-lesson"], challengeDesc: "", stringSearch: "", valueSearch: 179308, isLock: true),
            
            Lesson(id: 5, code: "lesson_5", name: "Return On Equity", image: "5-lesson", desc1: ["Return on equity (ROE) is a measure of financial performance calculated by dividing net income by shareholders' equity. Because shareholders' equity is equal to a company’s assets minus its debt, ROE is considered the return on net assets. ROE is considered a measure of how effectively management is using a company’s assets to create profits."], desc2: ["The higher the ROE , the better the business is performing."], descImage: ["1-lesson", "2-lesson"], challengeDesc: "", stringSearch: "", valueSearch: 0.03277, isLock: true),
            
            Lesson(id: 6, code: "lesson_6", name: "Price to Book Value", image: "6-lesson", desc1: ["Price to Book Value (PBV) is the value of each shares when you take the equity of the company and divide it by the number of issued and fully paid shares."], desc2: ["The smaller the PBV, the better the bigger the margin of safety is for investors. PBV 1 means you are buying a billion dollar company’s equity for a billion dollars, PBV 0.1 means you are buying a billion dollar company’s equity with only 100 million dollars."], descImage: ["1-lesson", "2-lesson"], challengeDesc: "", stringSearch: "", valueSearch: 0, isLock: true),
            
            Lesson(id: 7, code: "lesson_7", name: "Debt to Equity Ratio", image: "7-lesson", desc1: ["The Debt to Equity Ratio (DER) is calculated by dividing a company’s total liabilities by its shareholder equity. It is a measure of the degree to which a company is financing its operations through debt versus wholly-owned funds. More specifically, it reflects the ability of shareholder equity to cover all outstanding debts in the event of a business downturn."], desc2: ["DER of below 1, is usually a sign of a healthy company, apart from financial companies or contractor companies. but DER of 1 is acceptable some of the best companies has no debt at all they are so good at earning money that they do not need to take on debt to expand. however they still will take on debts for tax reducing purposes."], descImage: ["1-lesson", "2-lesson"], challengeDesc: "", stringSearch: "", valueSearch: 0, isLock: true),
            
            Lesson(id: 8, code: "lesson_8", name: "Margin of Safety", image: "8-lesson", desc1: ["Margin of safety (MOS) is a principle of investing in which an investor only purchases securities when their market price is significantly below their intrinsic value. In other words, when the market price of a security is significantly below your estimation of its intrinsic value, the difference is the margin of safety. Because investors may set a margin of safety in accordance with their own risk preferences, buying securities when this difference is present allows an investment to be made with minimal downside risk."], desc2: ["The higher the MOS, the safer an investor can feel when buying shares. it is like a safety buffer between the price paid by investors and the real intrinsic value of the shares."], descImage: ["1-lesson", "2-lesson"], challengeDesc: "", stringSearch: "", valueSearch: 0, isLock: true),
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
