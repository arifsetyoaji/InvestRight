//
//  PDFViewController.swift
//  mc3-investor-app
//
//  Created by Adrian Renaldi on 28/07/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    @IBOutlet weak var pdfViewer: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var pdfView: PDFView!
    var document: PDFDocument!
    var highlightedArea: PDFAnnotation!
    var value: Int?
    var currentLesson: Lesson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPdf()
        
        if let lesson = currentLesson {
            instructionLabel.text = "Tap the \(lesson.name!)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(extractAnnotation(notification:)), name: .PDFViewAnnotationHit, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChallengeViewController {
            destination.valueTapped = sender as? Int
        }
    }
}

extension PDFViewController: PDFDocumentDelegate {
    
    func setupPdf() {
        pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfViewer.addSubview(pdfView)
        
        pdfView.autoScales = true
        
        let fileUrl = Bundle.main.url(forResource: "IKPP_Report", withExtension: "pdf")
        document = PDFDocument(url: fileUrl!)
        pdfView.document = document
        pdfView.document?.delegate = self
        
        annotatePdf()
    }
    
    func annotatePdf() {
        let selections = pdfView?.document?.findString("Modal ditempatkan dan disetor\npenuh - 5.470.982.941 saham", withOptions: [])
        value = 5470982941
        
        guard let pages = selections?.first?.pages else { return }
        
        pages.forEach { (page) in
            selections?.forEach({ selection in
                highlightedArea = PDFAnnotation(bounds: selection.bounds(for: page), forType: .highlight, withProperties: nil)
                highlightedArea.endLineStyle = .square
                highlightedArea.color = .yellow

                page.addAnnotation(highlightedArea)
            })
        }
    }
    
    @objc func extractAnnotation(notification: Notification) {
        performSegue(withIdentifier: "entityTappedSegue", sender: value)
    }
}
