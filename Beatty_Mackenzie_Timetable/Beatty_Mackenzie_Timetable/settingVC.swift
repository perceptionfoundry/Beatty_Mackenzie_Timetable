//
//  settingVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 06/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class settingVC: UIViewController {
    
    let Delegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var darkModeSwitch: UISwitch!
   
    var darkStatus : Bool?
    
    
    var StatusDelegate : darkModeStatus!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkModeSwitch.isOn = Delegate.darkMode

        print("*********************")

        
        print(darkModeSwitch.isOn)
        print(Delegate.darkMode)
        
        print("*********************")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector (Quit))
        view.addGestureRecognizer(tap)
        

        
    }
    @IBAction func switchAction(_ sender: UISwitch) {
        
        print(sender.isOn)
        
        darkStatus =  sender.isOn

    }
    

    @objc func Quit(){
        
        
          print("@@@@@@@@@@@@@@@@@@@@@@")
        let status = darkStatus!
        print(status)
        print("@@@@@@@@@@@@@@@@@@@@@@")
        self.StatusDelegate.status(value: status)

        
        dismiss(animated: true, completion: nil)
    }


}
