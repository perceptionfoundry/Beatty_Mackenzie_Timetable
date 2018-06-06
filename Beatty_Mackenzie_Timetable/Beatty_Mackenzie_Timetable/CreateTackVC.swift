//
//  CreateTackVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 06/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class CreateTackVC: UIViewController{

    @IBOutlet weak var TitleLabel: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var EndTime: UITextField!
    @IBOutlet weak var infoField: UITextView!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     

    }
    

    
    
    @IBAction func ConfirmButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
