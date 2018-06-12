//
//  naviSettingVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 06/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class naviSettingVC: UIViewController {

    let Delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var naviModeSwitch: UISwitch!
    
    var naviStatus : Bool?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviModeSwitch.isOn = Delegate.Navi_Enable
        naviStatus = Delegate.Navi_Enable
        print("*********************")

        
        print(naviModeSwitch.isOn)
        print(Delegate.Navi_Enable)
        
        print("*********************")
        
       
        
        
        
    }
    
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        print(sender.isOn)
        
        naviStatus =  sender.isOn
        
    }
    
    
 
    


    @IBAction func backButton(_ sender: Any) {
       
            Delegate.Navi_Enable = naviStatus!
            
            self.dismiss(animated: true, completion: nil)
    
        
        
    }
    
}
