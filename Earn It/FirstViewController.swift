//
//  FirstViewController.swift
//  Earn It
//
//  Created by McCay on 12/26/14.
//  Copyright (c) 2014 Change5. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toGoalDetail" {
            let detailVC: GoalDetailViewController = segue.destinationViewController as GoalDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisGoal = fetchedResultsController.objectAtIndexPath(indexPath!) as GoalModel
            detailVC.detailGoalModel = thisGoal
        }
        else if segue.identifier == "toGoalAdd" {
            let addGoalVC: AddGoalViewController = segue.destinationViewController as AddGoalViewController
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
    }
    
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("toGoalAdd", sender: self)
        
    }
    

    // UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return fetchedResultsController.sections![section].numberOfObjects
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisGoal = fetchedResultsController.objectAtIndexPath(indexPath) as GoalModel
        
        var cell: GoalCell = tableView.dequeueReusableCellWithIdentifier("goalCell") as GoalCell
        
        cell.goalLabel.text = thisGoal.goal
        cell.goalDescriptionLabel.text = thisGoal.goaldescription
        cell.goalDateLabel.text = Date.toString(date: thisGoal.date)
        
        
        return cell
    }

    //UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("toGoalDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if fetchedResultsController.sections?.count == 1 {
            let fetchedObjects = fetchedResultsController.fetchedObjects!
            let testGoal:GoalModel = fetchedObjects[0] as GoalModel
            if testGoal.completed == true {
                return "Completed"
            }
            else {
                return "To do"
            }
        }
        else {
            if section == 0 {
                return "To do"
            }
            else {
                return "Completed"
            }
        }
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisGoal = fetchedResultsController.objectAtIndexPath(indexPath) as GoalModel
        
        if thisGoal.completed == true {
            thisGoal.completed = false
        } else {
            thisGoal.completed = true
        }
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    // NSFetchedResultsController
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    
    // Helpers
    
    func goalFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "GoalModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: goalFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        
        return fetchedResultsController
    }
    
    
    
    
}

