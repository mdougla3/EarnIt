//
//  AddGoalViewController.swift
//  Earn It
//
//  Created by McCay on 12/29/14.
//  Copyright (c) 2014 Change5. All rights reserved.
//

import UIKit
import CoreData

class AddGoalViewController: UIViewController {

    
    @IBOutlet weak var addGoalTextField: UITextField!
    @IBOutlet weak var addDescriptionTextField: UITextField!
    @IBOutlet weak var addGoalDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addGoalButtonPressed(sender: UIButton) {
        
      let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("GoalModel", inManagedObjectContext: managedObjectContext!)
        let goal = GoalModel(entity : entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        goal.goal = addGoalTextField.text
        goal.goaldescription = addDescriptionTextField.text
        goal.date = addGoalDatePicker.date
        goal.completed = false
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "GoalModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
}
