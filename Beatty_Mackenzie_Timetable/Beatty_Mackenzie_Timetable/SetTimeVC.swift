//
//  EndTimeVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 06/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class SetTimeVC: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    var selectedTime : String?
    
    var timeDelegate : FetchTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(setTime), for: .valueChanged)
        //
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let time = formatter.string(from: self.timePicker.date)
        self.selectedTime = time
        
        
        
    }
    
    // ************  Extract selected time ************
    @objc func setTime(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let time = formatter.string(from: self.timePicker.date)
        print(time)
        self.selectedTime = time
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        
        timeDelegate.setTime(Time: self.selectedTime!)
        self.dismiss(animated: true, completion: nil)
    }
    
  

}
