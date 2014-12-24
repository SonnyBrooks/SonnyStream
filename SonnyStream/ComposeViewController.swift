//
//  ComposeViewController.swift
//  SonnyStream
//
//  Created by Andy Budziszek on 12/23/14.
//  Copyright (c) 2014 Andy Budziszek. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet var SSTextView: UITextView!
    @IBOutlet var charRemainingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendSS(sender: AnyObject) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
