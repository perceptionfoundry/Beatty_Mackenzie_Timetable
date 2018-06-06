//
//  ViewController.swift
//  Beatty_Mackenzie_Timetable
//
//  Created by Syed ShahRukh Haider on 05/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Shift


class MonVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let Delegate = UIApplication.shared.delegate as! AppDelegate
    
    var dumpData = [["Task" : "PHYSIC HOME WORK", "Time" : "12:30"], ["Task" : "CHEMISTRY TEST", "Time" : "14:30"], ["Task" : "ENGLISH PRESENTATION", "Time" : "9:30"], ["Task" : "SOCIAL STUDIES", "Time" : "10:00"],]

    @IBOutlet weak var taskTable: UITableView!
    
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView()
        
        

     taskTable.delegate = self
    taskTable.dataSource = self
        
        
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dumpData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! taskCell
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
      
        
        cell.taskTitle.text = dumpData[indexPath.row]["Task"]
        cell.timeLabel.text = dumpData[indexPath.row]["Time"]
        
        return cell
    }
    
    func backgroundView(){
        
        let view = self.view as! ShiftView
        
        if Delegate.darkMode == false{
            
            
            view.setColors([
                UIColor.yellow,
                UIColor.orange,
                UIColor.brown,
                UIColor.blue,
                UIColor.purple,
                UIColor.green,
                UIColor.cyan,
                ])
            view.startTimedAnimation()
        }
            
            
            
            
        else{
            view.setColors([
                UIColor.black,
                UIColor.darkGray,
                UIColor.lightGray
                ])
            view.startTimedAnimation()
        }
        
    }

    @IBAction func settingButton(_ sender: Any) {
        

    }
}

