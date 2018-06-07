//
//  ViewController.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 05/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol darkModeStatus {
    func status (value : Bool)
}

class MonVC: UIViewController, UITableViewDelegate, UITableViewDataSource, darkModeStatus {
   
    
    
    func status(value: Bool) {
        Delegate.darkMode = value
        
        print(value)
        
        backgroundView()
    }
    
    

    
    
    let Delegate = UIApplication.shared.delegate as! AppDelegate
   
    var sendData = [String : String]()
    var autoChildKey = [String]()
    var TodayTask = [[String : String]]()
    
    @IBOutlet weak var taskTable: UITableView!
    @IBOutlet weak var darkmodeView: UIView!
    var dbHandle : DatabaseHandle!
    var dbRef : DatabaseReference!
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView()
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Monday").observe(.childAdded, with: { (dataSnapShot) in
            
            
            var key = dataSnapShot.key as! String
            
            print(key)
            self.autoChildKey.append(key)
            
            let value = dataSnapShot.value as! [String : String]
            self.TodayTask.append(value)
            self.taskTable.reloadData()

        })
     

     taskTable.delegate = self
    taskTable.dataSource = self
        
        
    }
    
 
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodayTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! taskCell
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
      print(TodayTask)
        
        cell.taskTitle.text = TodayTask[indexPath.row]["Title"]
        cell.timeLabel.text = TodayTask[indexPath.row]["Time"]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.sendData = TodayTask[indexPath.row]
        
        performSegue(withIdentifier: "Detail_Segue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("Delete")
            
            
            print(self.autoChildKey[indexPath.row])
            dbRef.child("Monday").child(self.autoChildKey[indexPath.row]).removeValue()
            TodayTask.remove(at: indexPath.row)
            taskTable.reloadData()
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
            
            print(sendData)
            
            dest.Title = sendData["Title"]
            dest.Time = sendData["Time"]
            dest.Info = sendData["Description"]
        }
            
        else if segue.identifier == "Setting_Segue"{
            let dest = segue.destination as! settingVC
            
            dest.StatusDelegate = self
        }
    }
    

  
    @IBAction func settingButton(_ sender: Any) {
        
      let VC = storyboard?.instantiateViewController(withIdentifier: "Setting")
        self.present(VC!, animated: true, completion: nil)


    }
}

