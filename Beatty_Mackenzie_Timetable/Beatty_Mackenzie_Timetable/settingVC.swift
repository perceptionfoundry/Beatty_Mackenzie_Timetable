//
//  settingVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 06/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import UserNotifications


class settingVC: UIViewController {
    
    let Delegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var darkModeSwitch: UISwitch!
   
    var darkStatus : Bool?
    
    
    var StatusDelegate : darkModeStatus!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkModeSwitch.isOn = Delegate.darkMode
        darkStatus = Delegate.darkMode
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
        
        

        if let statusCheck = darkStatus{
          print("@@@@@@@@@@@@@@@@@@@@@@")
        let status = statusCheck
        print(status)
        print("@@@@@@@@@@@@@@@@@@@@@@")
        self.StatusDelegate.status(value: status)
            
            
            var notificationText : String

            if status == false{
                notificationText = " 'Deactivated' "
            }
            else{
                notificationText = " 'Activated' "
            }

            if Delegate.Navi_Enable == true{
            
            taskNotification(Text: notificationText , inSecond: 0.2) { (success) in
                
                if success {
                    print("YAHOO!!!!!")
                }
            }
            }
        
        dismiss(animated: true, completion: nil)
        }
    }


    func taskNotification (Text : String, inSecond : TimeInterval, completion : @escaping (_ Success : Bool) -> ()){
        
        
        let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: inSecond, repeats: false)
        
        let Content = UNMutableNotificationContent()
        
        Content.title = "Dark Mode:"
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
