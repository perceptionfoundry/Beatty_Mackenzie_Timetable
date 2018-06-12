//
//  CreateTackVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 06/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import UserNotifications

protocol FetchTime {
    func setTime(Time : String)
}


class CreateTackVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate, FetchTime{
 
    let Delegate = UIApplication.shared.delegate as! AppDelegate

    var delegate : TableUpdate!

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
    var ArrayOfData = [[String : String]]()
    
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

        
        if TitleLabel.text?.isEmpty != nil && dayTF.text?.isEmpty != nil && infoField.text.isEmpty != nil && timeButton.titleLabel?.text != "-- : --"{
            let userDefaultDictionary = ["Title": (self.taskTitle)!, "Time":(self.taskTime)!, "Description" : (self.taskInfo)!]
            
         
//            print(self.taskDay)
            
            
            //******************* SAVE VALUE INTO  USER **************************
            
            
            
            if let tempData = UserDefaults.standard.value(forKey: self.taskDay!) as? [[String : String]]{
                
                print(tempData)
                
                self.ArrayOfData = tempData
                
                
            }
            
            
            
            if ArrayOfData.isEmpty == false{

                
                    ArrayOfData.append(userDefaultDictionary)
                
                
                UserDefaults.standard.set(ArrayOfData, forKey: self.taskDay!)
                delegate.updateValue(value: userDefaultDictionary, Day: self.taskDay!)

            }
            
            else{
                
                ArrayOfData.append(userDefaultDictionary)

                UserDefaults.standard.set(ArrayOfData, forKey: self.taskDay!)
                delegate.updateValue(value: userDefaultDictionary, Day: self.taskDay!)

                
            }
            
        //*****************************************************************************
            
            if Delegate.Navi_Enable == true{
                
                taskNotification(Text: "New Task has been add into your record " , inSecond: 0.2) { (success) in
                    
                    if success {
                        print("YAHOO!!!!!")
                    }
                }
            }
            
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
    
    
    func taskNotification (Text : String, inSecond : TimeInterval, completion : @escaping (_ Success : Bool) -> ()){
        
        
        let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: inSecond, repeats: false)
        
        let Content = UNMutableNotificationContent()
        
        Content.title = "TASK CREATED:"
        Content.subtitle = Text
        
        
        
        let request = UNNotificationRequest(identifier: "Task_Notification", content: Content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            
            if error != nil{
                completion(false)
            }
            else{
                completion(true)
            }
        }
    }
}
