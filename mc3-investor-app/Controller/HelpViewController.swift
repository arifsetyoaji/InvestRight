//
//  HelpViewController.swift
//  mc3-investor-app
//
//  Created by Hafizul Ihsan Fadli on 29/07/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var HelpTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegate()
    }
    
    private func setupDelegate() {
        HelpTableView.delegate = self
        HelpTableView.dataSource = self
    }
}

extension HelpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath)
        
        return cell
    }
    
    
    
}

