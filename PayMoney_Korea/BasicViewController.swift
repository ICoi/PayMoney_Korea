//
//  BasicViewController.swift
//  PayMoney_Korea
//
//  Created by 정다운 on 2019. 3. 10..
//  Copyright © 2019년 daunjoung. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
