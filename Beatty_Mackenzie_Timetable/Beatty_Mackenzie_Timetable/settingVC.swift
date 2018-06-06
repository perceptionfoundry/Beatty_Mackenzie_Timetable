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

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector (Quit))
        view.addGestureRecognizer(tap)
//        appDelegate.darkMode = true
        
    }

    @objc func Quit(){
        
        dismiss(animated: true, completion: nil)
    }


}
