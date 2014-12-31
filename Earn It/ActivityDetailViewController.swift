//
//  ActivityDetailViewController.swift
//  Earn It
//
//  Created by McCay on 12/26/14.
//  Copyright (c) 2014 Change5. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    var detailActivityModel: ActivityModel!
    
    @IBOutlet weak var activityTextField: UITextField!
    @IBOutlet weak var activityDescriptionTextField: UITextField!
    @IBOutlet weak var activityDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityTextField.text = detailActivityModel.activity
        self.activityDescriptionTextField.text = detailActivityModel.activitydescription
        self.activityDatePicker.date = detailActivityModel.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
    
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        detailActivityModel.activity = activityTextField.text
        detailActivityModel.activitydescription = activityDescriptionTextField.text
        detailActivityModel.date = activityDatePicker.date
        detailActivityModel.completed = detailActivityModel.completed
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
}
