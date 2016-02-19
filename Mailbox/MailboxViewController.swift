//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Jenn Leung on 2/18/16.
//  Copyright © 2016 Jenn Leung. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet var msg: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var msgView: UIView!
    var msgOriginalCenter: CGPoint!
//    var msgOffset: CGFloat!
//    var msgLeft: CGPoint!
//    var msgRight: CGPoint!
    @IBOutlet var underMsg: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = imageView.image!.size
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPanMsg:")
        
        msgView.userInteractionEnabled = true
        msgView.addGestureRecognizer(panGestureRecognizer)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPanMsg(sender:
        UIPanGestureRecognizer) {
            
            var point = sender.locationInView(msgView)
            var velocity = sender.velocityInView(msgView)
            var translation = sender.translationInView(msgView)
            
            
            if sender.state == UIGestureRecognizerState.Began {
                msgOriginalCenter = msgView.center
                //print("Gesture began at: \(point)")
            } else if sender.state == UIGestureRecognizerState.Changed {
                //print("Gesture changed at: \(point)")
                if velocity.x < 0 {
                    self.msgView.addSubview(underMsg)
                    //self.msgView.bringSubviewToFront(msg)
                    
                    msgView.center = CGPoint(x: self.msgOriginalCenter.x + translation.x, y: self.msgOriginalCenter.y)
                    if translation.x <= -60 {
                        underMsg.backgroundColor = UIColor(red: 0.4392, green: 0.851, blue: 0.3843, alpha: 1.0)
                        
                    }
                    if translation.x <= -200 {
                        underMsg.backgroundColor = UIColor(red: 0.9216, green: 0.3294, blue: 0.2, alpha: 1.0)
                    }
                   
                    UIView.animateWithDuration(0, delay: 0, options:[] , animations: { () -> Void in
                            self.msgView.center = CGPoint(x: self.msgOriginalCenter.x + translation.x, y: self.msgOriginalCenter.y)
                            print(translation)
                        }, completion: { (Bool) -> Void in
                    })
                    print(underMsg.layer.zPosition)
                    print("Gesture went right")
                }
                if velocity.x > 0 {
                    print(underMsg.layer.zPosition)
                    print("Gesture went left")
                    
                    
                    UIView.animateWithDuration(0, delay: 0, options:[] , animations: { () -> Void in
                        self.msgView.center = CGPoint(x: self.msgOriginalCenter.x + translation.x, y: self.msgOriginalCenter.y)
                        print(translation)
                        }, completion: { (Bool) -> Void in
                    })
                    if translation.x >= 60 {
                        underMsg.backgroundColor = UIColor(red: 0.9804, green: 0.8275, blue: 0.2, alpha: 1.0)
                    }
                    if translation.x >= 200 {
                        underMsg.backgroundColor = UIColor(red: 0.8471, green: 0.651, blue: 0.4588, alpha: 1.0)
                    }

                    
                    
                }
               
                
            } else if sender.state == UIGestureRecognizerState.Ended {
                //print("Gesture ended at: \(point)")
                    msg.layer.zPosition = 1
                    UIView.animateWithDuration(0.4, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                        self.msgView.center = CGPoint(x: self.msgOriginalCenter.x, y: self.msgOriginalCenter.y)
                        }, completion: { (Bool) in
                            self.underMsg.backgroundColor = UIColor(red: 0.8863, green: 0.8863, blue: 0.8863, alpha: 1.0)
                    })
                
                
            
            }

    }


}
