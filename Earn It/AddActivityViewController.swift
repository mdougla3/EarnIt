//
//  AddActivityViewController.swift
//  Earn It
//
//  Created by McCay on 12/30/14.
//  Copyright (c) 2014 Change5. All rights reserved.
//

import UIKit
import CoreData

class AddActivityViewController: UIViewController {

    @IBOutlet weak var activityTextField: UITextField!
    @IBOutlet weak var activityDescriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addActivityButtonPressed(sender: UIButton) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("ActivityModel", inManagedObjectContext: managedObjectContext!)
        let activity = ActivityModel(entity : entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        activity.activity = activityTextField.text
        activity.activitydescription = activityDescriptionTextField.text
        activity.date = datePicker.date
        activity.completed = false
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "ActivityModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    @IBAction func cancelButtonPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
