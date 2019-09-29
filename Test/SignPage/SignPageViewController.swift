//
//  SignPageViewController.swift
//  Test
//
//  Created by Sergiy on 9/25/19.
//  Copyright © 2019 Sergiy. All rights reserved.
//

import UIKit

class SignPageViewController: UIViewController {

    
    @IBOutlet weak var view_SignBack: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view_SignBack.backgroundColor = UIColor().MygetColorFromHex(backgroundColor[backgroundColor_type])
        // Do any additional setup after loading t  he view.
    }
    

}
