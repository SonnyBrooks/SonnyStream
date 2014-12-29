//
//  TimelineTableViewController.swift
//  SonnyStream
//
//  Created by Andy Budziszek on 12/23/14.
//  Copyright (c) 2014 Andy Budziszek. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    var streamData = [PFObject]()

    override func viewDidAppear(animated: Bool) {
        self.loadData()
        
        if((PFUser.currentUser()) == nil)
        {
            var loginAlert:UIAlertController = UIAlertController(title: "Sign up / Login", message: "Please sign up or login", preferredStyle: UIAlertControllerStyle.Alert)
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Username"
            })
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Password"
                textfield.secureTextEntry = true
            })
            
            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textFields:NSArray = loginAlert.textFields as AnyObject! as NSArray
                let usernameTextField:UITextField = textFields.objectAtIndex(0) as UITextField
                let passwordTextField:UITextField = textFields.objectAtIndex(1) as UITextField
                
                PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text)
                {
                    (user:PFUser!, error:NSError!) -> Void in
                    if((user) != nil)
                    {
                        println("SUCCESS: User '\(usernameTextField.text)' logged in successfully!")
                    }
                    else
                    {
                        println("FAILURE: User '\(usernameTextField.text)' failed to login!")
                    }
                }
                
            }))
            
            loginAlert.addAction(UIAlertAction(title: "Sign up", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textFields:NSArray = loginAlert.textFields as AnyObject! as NSArray
                let usernameTextField:UITextField = textFields.objectAtIndex(0) as UITextField
                let passwordTextField:UITextField = textFields.objectAtIndex(1) as UITextField
                
                var user:PFUser = PFUser()
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackgroundWithBlock{
                    (success:Bool!, error:NSError!)-> Void in
                    if error == nil
                    {
                        println("SUCCESS: Sign up successful! - \(user.username)")
                    }
                    else
                    {
                        println("FAILURE: \(user.username) failed to sign up! - \(error)")
                    }
                }
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func loadData() {
        streamData.removeAll(keepCapacity: false)
        
        var getStreamData:PFQuery = PFQuery(className: "sonRays")
        getStreamData.findObjectsInBackgroundWithBlock
        {
            (objects:[AnyObject]!, error:NSError!)-> Void in
            if error == nil
            {
                self.streamData = objects.reverse() as [PFObject]
                println(objects)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return streamData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SSTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as SSTableViewCell

        let sonRay: PFObject = self.streamData[indexPath.row] as PFObject

        cell.sonRayTextView.alpha = 0
        cell.usernameLabel.alpha = 0
        cell.timestampLabel.alpha = 0
        
        cell.sonRayTextView.text = sonRay.objectForKey("content") as String
        
        var dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        cell.timestampLabel.text = dataFormatter.stringFromDate(sonRay.createdAt)
        
        var findUser: PFQuery = PFUser.query()
        findUser.whereKey("objectId", equalTo: sonRay.objectForKey("user").objectId)
        
        findUser.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]!, error:NSError!)-> Void in
            if error == nil
            {
                let user:PFUser = (objects as NSArray).lastObject as PFUser
                cell.usernameLabel.text = "@\(user.username)"
                
                UIView.animateWithDuration(0.5, animations: {
                    cell.sonRayTextView.alpha = 1
                    cell.usernameLabel.alpha = 1
                    cell.timestampLabel.alpha = 1
                })
            }
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
