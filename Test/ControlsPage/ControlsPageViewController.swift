//
//  ControlsPageViewController.swift
//  Test
//
//  Created by Alex L. on 9/29/19.
//  Copyright © 2019 Sergiy. All rights reserved.
//

import UIKit

class ControlsPageViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var progress_Pie: AdvancedPieChartView!

    @IBOutlet weak var view4: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view1.MakeShadowRoundView(20)
        view2.MakeShadowRoundView(20)
        view3.MakeShadowRoundView(20)
        view4.MakeShadowRoundView(20)

        progress_Pie.slices = [
            Slice(percent: 0.77, color: UIColor(rgb: 0xff0000))
        ]
        progress_Pie.percent = 0.77
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progress_Pie.animateChart()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
