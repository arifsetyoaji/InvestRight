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
    var searchedItem: PDFSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPdf()
        annotatePdf()
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
    }
    
    func annotatePdf() {
        let selections = pdfView?.document?.findString("valuing with PBV ROE method", withOptions: [.caseInsensitive])
        
        guard let pages = selections?.first?.pages else { return }
        
        pages.forEach { (page) in
            selections?.forEach({ selection in
                let highlight = PDFAnnotation(bounds: selection.bounds(for: page), forType: .highlight, withProperties: nil)
                highlight.endLineStyle = .square
                highlight.color = .yellow

                page.addAnnotation(highlight)
            })
        }
    }
    
}
