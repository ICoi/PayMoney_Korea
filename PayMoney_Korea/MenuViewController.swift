//
//  MenuViewController.swift
//  PayMoney_Korea
//
//  Created by 정다운 on 2019. 3. 10..
//  Copyright © 2019년 daunjoung. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PLAY_GAME_EASY_MODE" {
            
            let controller : ShopViewController? = segue.destination as? ShopViewController
            controller?.gameMode = GameMode.Payment_Easy
        } else if segue.identifier == "PLAY_GAME_NORMAL_MODE" {
            
            let controller : ShopViewController? = segue.destination as? ShopViewController
            controller?.gameMode = GameMode.Payment_Normal
            
            
        }
    }

}
