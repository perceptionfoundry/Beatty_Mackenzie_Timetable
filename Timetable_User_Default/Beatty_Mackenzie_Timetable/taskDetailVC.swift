//
//  taskDetailVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 07/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class taskDetailVC: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    var Title : String?
    var Time : String?
    var Info : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("*********")
      TitleLabel.text = (Title)!
      timeLabel.text = (Time)!
      infoLabel.text = (Info)!
        print("*********")

    }


    @IBAction func backButtonAction(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    
   


}
