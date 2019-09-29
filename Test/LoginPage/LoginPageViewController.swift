//
//  LoginPageViewController.swift
//  Test
//
//  Created by Sergiy on 9/25/19.
//  Copyright © 2019 Sergiy. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class LoginPageViewController: UIViewController {

    @IBOutlet weak var text_ID: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var view_loginBack: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_loginBack.backgroundColor = UIColor().MygetColorFromHex(backgroundColor[backgroundColor_type])
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
