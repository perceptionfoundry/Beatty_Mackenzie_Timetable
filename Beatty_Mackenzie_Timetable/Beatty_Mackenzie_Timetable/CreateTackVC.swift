//
//  CreateTackVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 06/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol FetchTime {
    func setTime(Time : String)
}


class CreateTackVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate, FetchTime{
 
    
    var dbRef : DatabaseReference!
    

    @IBOutlet weak var TitleLabel: UITextField!
    @IBOutlet weak var dayTF: UITextField!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var infoField: UITextView!
    
    var PickerView = UIPickerView()
    var DaysName = [" 'Select Desire Day' ","Monday","Tuesday", "Wednesday","Thursday","Friday"]

    var taskTitle : String?
    var taskDay : String?
    var taskTime : String?
    var taskInfo: String?
    
    
    func setTime(Time: String) {
        taskTime = Time
        timeButton.titleLabel?.text = Time
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PickerView.dataSource = self
        PickerView.delegate = self
        dayTF.delegate = self
     
        

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // *** ENABLE PICKERVIEW FOR PROPERTY SELECTION **********
        if textField == self.dayTF {
            self.dayTF.inputView = self.PickerView
            self.PickerView.reloadAllComponents()
            
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.dayTF {
            self.dayTF.inputView = nil
            self.PickerView.reloadAllComponents()
        }
      
//        taskInfo = infoField.text
        
        
    }
    
   
    
    
    // ******** PICKERVIEW DELEGATE METHODS *********
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return DaysName.count
        
    }
    
    
    // *******  ASSIGN TITLE TO PICKERVIEW ****************
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return DaysName[row]
        
    }
    
    
    // *********** SELECT DESIRE VALUE  *********
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dayTF.text = DaysName[row]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Time_Segue"{
            
            let dest = segue.destination as! SetTimeVC
            
            dest.timeDelegate = self
        }
    }
    
    @IBAction func ConfirmButton(_ sender: Any) {
        
        self.taskTitle = TitleLabel.text!
        self.taskDay = dayTF.text!
        self.taskInfo = infoField.text!

        dbRef = Database.database().reference()
        
        if TitleLabel.text?.isEmpty != nil && dayTF.text?.isEmpty != nil && infoField.text.isEmpty != nil && timeButton.titleLabel?.text != "-- : --"{
            var firebaseDictionary = ["Title": (self.taskTitle)!, "Time":(self.taskTime)!, "Description" : (self.taskInfo)!]
            
            
            print("**********************")
            print((firebaseDictionary))
            print("******************")
            
            dbRef.child((self.taskDay)!).childByAutoId().setValue(firebaseDictionary)
            self.dismiss(animated: true, completion: nil)
            
        }
        else {
            
            let alertVC = UIAlertController(title: "Warning", message: "Some Data Missing", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(cancelButton)
            self.present(alertVC, animated: true, completion: nil)
        }
     
    }
    

    @IBAction func cancelActionButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
