//
//  TransformationPageViewController.swift
//  Test
//
//  Created by Sergiy on 9/25/19.
//  Copyright © 2019 Sergiy. All rights reserved.
//

import UIKit

class TransformationPageViewController: UIViewController {

    @IBOutlet weak var btn_next: UIButton!
    
    @IBOutlet weak var img_massgain: UIImageView!
    var isCheckMassgain:Bool = true
    
    @IBOutlet weak var img_maintant: UIImageView!
    var isCheckMaintant:Bool = true
    
    @IBOutlet weak var img_fatloss: UIImageView!
    var isCheckFatloss:Bool = true
    
    @IBOutlet weak var img_pregancy: UIImageView!
    var isCheckPregnancy:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isCheckMassgain = false
        isCheckMaintant = false
        isCheckFatloss = false
        isCheckPregnancy = false
        
        btn_next.isHidden = true
    }

    @IBAction func click_btnMassgain(_ sender: Any) {
        isCheckMassgain = !isCheckMassgain
        
        if(isCheckMassgain == true){
            
            img_massgain.image = UIImage(named: "icon_sel_massgain")
            
            img_massgain.layer.cornerRadius = img_massgain.frame.size.height/2
            img_massgain.layer.borderColor = UIColor().MygetColorFromHex("#32D3F5").cgColor
            img_massgain.layer.borderWidth = 1
         
        }
        else{
            img_massgain.image = UIImage(named: "icon_massgain")
            
            img_massgain.layer.cornerRadius = 0
            img_massgain.layer.borderWidth = 0
        }
        
        if(isCheckMassgain || isCheckMaintant || isCheckFatloss || isCheckPregnancy){
            btn_next.isHidden = false
        }
        else{
            btn_next.isHidden = true
        }
    }
    
    @IBAction func click_btnMaintance(_ sender: Any) {
        isCheckMaintant = !isCheckMaintant
        
        if(isCheckMaintant == true){
            img_maintant.layer.cornerRadius = img_maintant.frame.size.height/2
            img_maintant.layer.borderColor = UIColor().MygetColorFromHex("#32D3F5").cgColor
            img_maintant.layer.borderWidth = 1
            
            img_maintant.image = UIImage(named: "icon_sel_maintain")
        }
        else{
            img_maintant.layer.cornerRadius = 0
            img_maintant.layer.borderWidth = 0
            
            img_maintant.image = UIImage(named: "icon_maintain")
            
        }
        
        if(isCheckMassgain || isCheckMaintant || isCheckFatloss || isCheckPregnancy){
            btn_next.isHidden = false
        }
        else{
            btn_next.isHidden = true
        }
    }
    @IBAction func click_btnFatloss(_ sender: Any) {
        isCheckFatloss = !isCheckFatloss
        
        if(isCheckFatloss == true){
            img_fatloss.layer.cornerRadius = img_fatloss.frame.size.height/2
            img_fatloss.layer.borderColor = UIColor().MygetColorFromHex("#32D3F5").cgColor
            img_fatloss.layer.borderWidth = 1
            
            img_fatloss.image = UIImage(named: "icon_sel_fatloss")
        }
        else{
            img_fatloss.layer.cornerRadius = 0
            img_fatloss.layer.borderWidth = 0
            
            img_fatloss.image = UIImage(named: "icon_fatloss")
        }
        
        if(isCheckMassgain || isCheckMaintant || isCheckFatloss || isCheckPregnancy){
            btn_next.isHidden = false
        }
        else{
            btn_next.isHidden = true
        }
    }
    @IBAction func click_btnPregnancy(_ sender: Any) {
        isCheckPregnancy = !isCheckPregnancy
        
        if(isCheckPregnancy == true){
            img_pregancy.layer.cornerRadius = img_pregancy.frame.size.height/2
            img_pregancy.layer.borderColor = UIColor().MygetColorFromHex("#32D3F5").cgColor
            img_pregancy.layer.borderWidth = 1
            
            img_pregancy.image = UIImage(named: "icon_pregnancy")
        }
        else{
            img_pregancy.layer.cornerRadius = 0
            img_pregancy.layer.borderWidth = 0
            
            img_pregancy.image = UIImage(named: "icon_pregnancy")
        }
        
        if(isCheckMassgain || isCheckMaintant || isCheckFatloss || isCheckPregnancy){
            btn_next.isHidden = false
        }
        else{
            btn_next.isHidden = true
        }
    }
}
