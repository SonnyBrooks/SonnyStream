//
//  ComposeViewController.swift
//  SonnyStream
//
//  Created by Andy Budziszek on 12/23/14.
//  Copyright (c) 2014 Andy Budziszek. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var SSTextView: UITextView! = UITextView()
    @IBOutlet var charRemainingLabel: UILabel! = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SSTextView.layer.borderColor = UIColor.blackColor().CGColor
        SSTextView.layer.borderWidth = 0.5
        SSTextView.layer.cornerRadius = 5
        SSTextView.delegate = self
        
        SSTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool{
            
            var rayLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
            var charRemaining:Int = 140 - rayLength
            
            charRemainingLabel.text = "\(charRemaining)"
            if charRemaining <= 15
            {
                charRemainingLabel.textColor = UIColor.redColor()
            } else {
                charRemainingLabel.textColor = UIColor.blackColor()
            }
            
            return (rayLength > 140) ? false : true
    }
    
    @IBAction func sendSS(sender: AnyObject) {
        var sonRay: PFObject = PFObject(className: "sonRays")
        
        sonRay["content"] = SSTextView.text
        sonRay["user"] = PFUser.currentUser()
        sonRay.saveInBackgroundWithTarget(nil, selector: nil)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
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
