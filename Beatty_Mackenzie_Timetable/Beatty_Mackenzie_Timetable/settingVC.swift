//
//  settingVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 06/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class settingVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var darkModeSwitch: UISwitch!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkModeSwitch.isOn = appDelegate.darkMode

        print("*********************")

        
        print(darkModeSwitch.isOn)
        print(appDelegate.darkMode)
        
        print("*********************")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector (Quit))
        view.addGestureRecognizer(tap)
        

        
    }
    @IBAction func switchAction(_ sender: UISwitch) {
        
        print(sender.isOn)
        
        if darkModeSwitch.isOn ==  true{
            
                        appDelegate.darkMode = false
            
                    }
            
                    else{
            
                        appDelegate.darkMode = true
            
                    }
    }
    

    @objc func Quit(){
        
        dismiss(animated: true, completion: nil)
    }


}
