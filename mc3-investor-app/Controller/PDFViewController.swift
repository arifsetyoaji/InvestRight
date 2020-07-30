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
    
    var pdfView: PDFView!
    var document: PDFDocument!
    var highlightedArea: PDFAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPdf()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(extractAnnotation(notification:)), name: .PDFViewAnnotationHit, object: nil)
    }
}

extension PDFViewController: PDFDocumentDelegate {
    
    func setupPdf() {
        pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfViewer.addSubview(pdfView)
        
        pdfView.autoScales = true
        
        let fileUrl = Bundle.main.url(forResource: "nasipadang", withExtension: "pdf")
        document = PDFDocument(url: fileUrl!)
        pdfView.document = document
        pdfView.document?.delegate = self
        
        annotatePdf()
    }
    
    func annotatePdf() {
        let selections = pdfView?.document?.findString("valuing with PBV ROE method", withOptions: [.caseInsensitive])
        
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
        dismiss(animated: true, completion: nil)
    }
}
