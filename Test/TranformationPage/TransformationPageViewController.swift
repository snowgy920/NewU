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
    @IBOutlet weak var view_massgain: UIView!
    var isCheckMassgain:Bool = true
    
    @IBOutlet weak var img_maintant: UIImageView!
    @IBOutlet weak var view_maintant: UIView!
    var isCheckMaintant:Bool = true
    
    @IBOutlet weak var img_fatloss: UIImageView!
    @IBOutlet weak var view_fatloss: UIView!
    var isCheckFatloss:Bool = true
    
    @IBOutlet weak var img_pregancy: UIImageView!
    @IBOutlet weak var view_pregnancy: UIView!
    var isCheckPregnancy:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isCheckMassgain = false
        isCheckMaintant = false
        isCheckFatloss = false
        isCheckPregnancy = false
        
        btn_next.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func click_btnMassgain(_ sender: Any) {
        isCheckMassgain = !isCheckMassgain
        
        if(isCheckMassgain == true){
            
            img_massgain.image = UIImage(named: "icon_sel_massgain")
            
            view_massgain.layer.cornerRadius = view_massgain.frame.size.height/2
            view_massgain.layer.borderColor = UIColor().MygetColorFromHex("#32D3F5").cgColor
            view_massgain.layer.borderWidth = 1
         
        }
        else{
            img_massgain.image = UIImage(named: "icon_massgain")
            
            view_massgain.layer.cornerRadius = 0
            view_massgain.layer.borderWidth = 0
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
            view_maintant.layer.cornerRadius = view_maintant.frame.size.height/2
            view_maintant.layer.borderColor = UIColor().MygetColorFromHex("#32D3F5").cgColor
            view_maintant.layer.borderWidth = 1
            
            img_maintant.image = UIImage(named: "icon_sel_maintain")
        }
        else{
            view_maintant.layer.cornerRadius = 0
            view_maintant.layer.borderWidth = 0
            
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
            view_fatloss.layer.cornerRadius = view_fatloss.frame.size.height/2
            view_fatloss.layer.borderColor = UIColor().MygetColorFromHex("#32D3F5").cgColor
            view_fatloss.layer.borderWidth = 1
            
            img_fatloss.image = UIImage(named: "icon_sel_fatloss")
        }
        else{
            view_fatloss.layer.cornerRadius = 0
            view_fatloss.layer.borderWidth = 0
            
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
            view_pregnancy.layer.cornerRadius = view_pregnancy.frame.size.height/2
            view_pregnancy.layer.borderColor = UIColor().MygetColorFromHex("#32D3F5").cgColor
            view_pregnancy.layer.borderWidth = 1
            
            img_pregancy.image = UIImage(named: "icon_sel_pregnancy")
        }
        else{
            view_pregnancy.layer.cornerRadius = 0
            view_pregnancy.layer.borderWidth = 0
            
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
