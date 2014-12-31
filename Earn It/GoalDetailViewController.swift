//
//  GoalDetailViewController.swift
//  Earn It
//
//  Created by McCay on 12/26/14.
//  Copyright (c) 2014 Change5. All rights reserved.
//

import UIKit

class GoalDetailViewController: UIViewController {

    var detailGoalModel: GoalModel!
    
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var goalDescriptionTextField: UITextField!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var goalDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.goalTextField.text = detailGoalModel.goal
        self.goalDescriptionTextField.text = detailGoalModel.goaldescription
        self.goalDatePicker.date = detailGoalModel.date
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
      let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        detailGoalModel.goal = goalTextField.text
        detailGoalModel.goaldescription = goalDescriptionTextField.text
        detailGoalModel.date = goalDatePicker.date
        detailGoalModel.completed = detailGoalModel.completed
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
}
