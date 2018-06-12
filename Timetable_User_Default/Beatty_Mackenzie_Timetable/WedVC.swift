//
//  WedVC.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 08/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//


import UIKit
import UserNotifications


class WedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, darkModeStatus,TableUpdate {
   
    
    func updateValue(value: [String : String], Day : String) {
        
        if Day == "Wednesday"{
            self.ArrayOfData.append(value)
            taskTable.reloadData()
            
        }
        
    }
    
    
 
    
    func status(value: Bool) {
        Delegate.darkMode = value
        
//        print(value)
        
        backgroundView()
    }
    
    
    
    
    
    let Delegate = UIApplication.shared.delegate as! AppDelegate
    
    var sendData = [String : String]()
    var autoChildKey = [String]()
    var TodayTask = [[String : String]]()
    var ArrayOfData = [[String : String]]()

    @IBOutlet weak var taskTable: UITableView!

    @IBOutlet weak var darkmodeView: UIView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        print(Delegate.darkMode)
        
        //permission local user notification
        
    
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if error != nil{
                print("Authorization Unsuccessful")
            }
            else{
                
                print("Authorization Success")
            }
        }
        
        
        self.backgroundView()
        
        
        
        
        if let tempData = UserDefaults.standard.value(forKey: "Wednesday") as? [[String : String]]{
            
            print(tempData)
            
            self.ArrayOfData = tempData
            
            taskTable.reloadData()
            
        }
        
        
        
        taskTable.delegate = self
        taskTable.dataSource = self
        
        taskTable.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundView()
        
        if let tempData = UserDefaults.standard.value(forKey: "Wednesday") as? [[String : String]]{
            
            print(tempData)
            
            self.ArrayOfData = tempData
            
            taskTable.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! taskCell
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        //      print(TodayTask)
        
        cell.taskTitle.text = ArrayOfData[indexPath.row]["Title"]
        cell.timeLabel.text = ArrayOfData[indexPath.row]["Time"]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.sendData = ArrayOfData[indexPath.row]
        
        performSegue(withIdentifier: "Detail_Segue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("Delete")
            
            
            
            ArrayOfData.remove(at: indexPath.row)
            
            UserDefaults.standard.set(ArrayOfData, forKey: "Wednesday")
            
            taskTable.reloadData()
            
            if Delegate.Navi_Enable == true{
                
                taskNotification(Text: "New Task has been add into your record " , inSecond: 0.2) { (success) in
                    
                    if success {
                        print("YAHOO!!!!!")
                    }
                }
            }
        }
    }
    func backgroundView(){
        
        if Delegate.darkMode == false{
            darkmodeView.isHidden = true
            
        }
            
        else{
            darkmodeView.isHidden = false
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail_Segue"{
            
            let dest = segue.destination as! taskDetailVC
            
            //            print(sendData)
            
            dest.Title = sendData["Title"]
            dest.Time = sendData["Time"]
            dest.Info = sendData["Description"]
        }
            
        else if segue.identifier == "Setting_Segue"{
            let dest = segue.destination as! settingVC
            
            dest.StatusDelegate = self
        }
        else if segue.identifier == "Create_Segue_Wednesday"{
            
            let dest = segue.destination as! CreateTackVC
            dest.delegate = self
            
        }
    }
    
    
    
    @IBAction func settingButton(_ sender: Any) {
        
        //      let VC = storyboard?.instantiateViewController(withIdentifier: "Setting")
        //        self.present(VC!, animated: true, completion: nil)
        
        // Check notification
        
        
        
    }
    
    func taskNotification (Text : String, inSecond : TimeInterval, completion : @escaping (_ Success : Bool) -> ()){
        
        
        let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: inSecond, repeats: false)
        
        let Content = UNMutableNotificationContent()
        
        Content.title = "TASK DELETED"
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

