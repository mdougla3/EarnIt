//
//  SecondViewController.swift
//  Earn It
//
//  Created by McCay on 12/26/14.
//  Copyright (c) 2014 Change5. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
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
        
        if segue.identifier == "toActivityDetail" {
            let detailVC: ActivityDetailViewController = segue.destinationViewController as ActivityDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisActivity = fetchedResultsController.objectAtIndexPath(indexPath!) as ActivityModel
            detailVC.detailActivityModel = thisActivity
        }
        else if segue.identifier == "toActivityAdd" {
            let addActivityVC: AddActivityViewController = segue.destinationViewController as AddActivityViewController
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
    }
    
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("toActivityAdd", sender: self)
        
    }
    
    
    // UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections![section].numberOfObjects
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let thisActivity = fetchedResultsController.objectAtIndexPath(indexPath) as ActivityModel
        
        var cell: ActivityCell = tableView.dequeueReusableCellWithIdentifier("activityCell") as ActivityCell
        
        cell.activityLabel.text = thisActivity.activity
        cell.activityDescriptionLabel.text = thisActivity.activitydescription
        cell.activityDateLabel.text = Date.toString(date: thisActivity.date)
        
        
        return cell
    }
    
    //UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("toActivityDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        }
        else { return "Completed" }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisActivity = fetchedResultsController.objectAtIndexPath(indexPath) as ActivityModel
        
        if thisActivity.completed == true {
            thisActivity.completed = false
        } else {
            thisActivity.completed = true
        }
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    // NSFetchedResultsController
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    
    // Helpers
    
    func activityFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "ActivityModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: activityFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        
        return fetchedResultsController
    }
    
    
    
    
}

