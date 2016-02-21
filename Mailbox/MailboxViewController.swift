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
    @IBOutlet var underMsg: UIView!
    @IBOutlet var otherMsg: UIImageView!
    @IBOutlet var rightView: UIView!
    @IBOutlet var leftView: UIView!
    @IBOutlet var laterIcon: UIImageView!
    @IBOutlet var archiveIcon: UIImageView!
    @IBOutlet var listIcon: UIImageView!
    @IBOutlet var deleteIcon: UIImageView!
    @IBOutlet var rescheduleView: UIImageView!
    @IBOutlet var listView: UIImageView!
    @IBOutlet var inboxView: UIView!
    @IBOutlet var screenView: UIView!
    @IBOutlet var menu: UIImageView!
    
    
    var underMsgOriginalCenter: CGPoint!
    var msgOriginalCenter: CGPoint!
    var screenViewOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = imageView.image!.size
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPanMsg:")
        
        msgView.userInteractionEnabled = true
        msgView.addGestureRecognizer(panGestureRecognizer)
        
        screenViewOriginalCenter = screenView.center
        msgOriginalCenter = msgView.center
        underMsgOriginalCenter = underMsg.center
        
        //hide all the things
        rescheduleView.alpha = 0
        listView.alpha = 0
        laterIcon.alpha = 0
        listIcon.alpha = 0
        deleteIcon.alpha = 0
        archiveIcon.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onTapReschedule(sender: AnyObject) {
        self.rescheduleView.alpha = 0
        //self.msgView.center.x = 160
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.msgView.center.x = self.msgOriginalCenter.x
            print(self.msgView.center.x)
            })  { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
                    //moving other messages up
                    self.otherMsg.center.y -= 85
                    
                    }) { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.5, delay: 1, options: [], animations: { () -> Void in
                            //moving message back
                            self.otherMsg.center.y += 85
                            }, completion: { (Bool) -> Void in
                                
                        })
                }
        }
    }
    
    
    @IBAction func didTapList(sender: AnyObject) {
        self.listView.alpha = 0
        //self.msgView.center.x = 160
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.msgView.center.x = self.msgOriginalCenter.x
            print(self.msgView.center.x)
            })  { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
                    //moving other messages up
                    self.otherMsg.center.y -= 85
                    }) { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.5, delay: 1, options: [], animations: { () -> Void in
                            //moving message back
                            
                            self.otherMsg.center.y += 85
                            }, completion: { (Bool) -> Void in
                                
                        })
                }
        }
        
        
    }
    
    @IBAction func onTapMenu(sender: UITapGestureRecognizer) {
        self.menu.alpha = 0
        self.screenView.center = CGPoint(x:screenViewOriginalCenter.x, y:screenViewOriginalCenter.y)
        print("menu tapped")
    }
    @IBAction func didPanMsg(sender:
        UIPanGestureRecognizer) {
            
            let translation = sender.translationInView(msgView)
            
            //Changing under message background colors
            if translation.x <= -260 {
                underMsg.backgroundColor = UIColor(red: 216/255, green: 166/255, blue: 117/255, alpha: 1.0) /* #d8a675; brown */
            } else if translation.x <= -60 && translation.x > -260 {
                underMsg.backgroundColor = UIColor(red: 250/255, green: 211/255, blue: 51/255, alpha: 1.0) /* #fad333; orange */
                
            } else if translation.x > -60 && translation.x <= 60 {
                underMsg.backgroundColor = UIColor(red: 0.9098, green: 0.9098, blue: 0.9098, alpha: 1.0) /* #e8e8e8; grey */
            }
            else if translation.x > 60 && translation.x <= 260 {
                
                underMsg.backgroundColor = UIColor(red: 112/255, green: 217/255, blue: 98/255, alpha: 1.0) /* #70d962; green */
            } else if translation.x > 260 {
                underMsg.backgroundColor = UIColor(red: 235/255, green: 84/255, blue: 51/255, alpha: 1.0) /* #eb5433, red */
            }
            
            //handling icons
            
            // change and move icon
            print("translation pre: ")
            print(translation.x)
            if (translation.x <= -260.0) {
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 1
                self.deleteIcon.alpha = 0
                self.archiveIcon.alpha = 0
                self.rightView.center.x = 287.5 + 60 + translation.x
            } else if (translation.x > -260 && translation.x <= -60) {
                self.laterIcon.alpha = 1
                self.listIcon.alpha = 0
                self.deleteIcon.alpha = 0
                self.archiveIcon.alpha = 0
                self.rightView.center.x = 287.5 + 60 + translation.x
            } else if (translation.x > -60 && translation.x <= 60) {
                self.archiveIcon.alpha = (translation.x/60)
                self.laterIcon.alpha = -(translation.x/60)
                self.deleteIcon.alpha = 0
                self.listIcon.alpha = 0
            } else if (translation.x > 60 && translation.x <= 260) {
                self.deleteIcon.alpha = 0
                self.archiveIcon.alpha = 1
                self.laterIcon.alpha = 0
                self.leftView.center.x = 32.5 - 60 + translation.x
            } else if (translation.x > 260) {
                self.deleteIcon.alpha = 1
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 0
                self.archiveIcon.alpha = 0
                self.leftView.center.x = 32.5 - 60 + translation.x
            }

            
            if sender.state == UIGestureRecognizerState.Began {
                
                
            } else if sender.state == UIGestureRecognizerState.Changed {
                //print("Gesture changed at: \(point)")
                
                underMsg.center = CGPoint(x: self.underMsgOriginalCenter.x - translation.x, y: self.underMsgOriginalCenter.y)
                
                print(underMsgOriginalCenter.x)
                
                msgView.center = CGPoint(x: self.msgOriginalCenter.x + translation.x, y: self.msgOriginalCenter.y)
                
                UIView.animateWithDuration(0, delay: 0, options:[] , animations: { () -> Void in
                    self.msgView.center = CGPoint(x: self.msgOriginalCenter.x + translation.x, y: self.msgOriginalCenter.y)
                    self.underMsg.center = CGPoint(x: self.underMsgOriginalCenter.x - translation.x, y: self.underMsgOriginalCenter.y)
                    print(translation)
                    }, completion: { (Bool) -> Void in
                })
                
            } else if sender.state == UIGestureRecognizerState.Ended {
                
                self.underMsg.center = CGPoint(x: self.underMsgOriginalCenter.x, y: self.underMsgOriginalCenter.y)
                
                UIView.animateWithDuration(0.4, delay: 0.2,  options:[] , animations: { () -> Void in
                    self.msgView.center = CGPoint(x: self.msgOriginalCenter.x, y: self.msgOriginalCenter.y)
                    }, completion: { (Bool) in
                        self.underMsg.backgroundColor = UIColor(red: 0.8863, green: 0.8863, blue: 0.8863, alpha: 1.0)
                        
                })
                
                if (translation.x <= -260) {
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.msgView.center.x = -320
                        self.listView.alpha = 1.0
                    })
                } else if ((translation.x > -260) && (translation.x <= -60)) {
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.msgView.center.x = -320
                        self.rescheduleView.alpha = 1.0
                        self.listView.alpha = 0
                    })
                } else if ((translation.x > -60) && (translation.x <= 60)) {
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.msgView.center.x = 160
                    })
                } else if ((translation.x > 60) && (translation.x <= 260)) {
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.msgView.center.x = 500
                        })  { (finished: Bool) -> Void in
                            UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                                self.otherMsg.center.y -= 85
                                }) { (finished: Bool) -> Void in
                                    self.msgView.center.x = 160
                                    UIView.animateWithDuration(0.5, delay: 1, options: [], animations: { () -> Void in
                                        self.otherMsg.center.y += 85
                                        }) { (Bool) -> Void in
                                    }
                            }
                    }
                } else if (translation.x > 260) {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.msgView.center.x = 500
                        })  { (finished: Bool) -> Void in
                            UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                                self.otherMsg.center.y -= 85
                                }) { (finished: Bool) -> Void in
                                    self.msgView.center.x = 160
                                    UIView.animateWithDuration(0.5, delay: 1, options: [], animations: { () -> Void in
                                        self.otherMsg.center.y += 85
                                        }) { (Bool) -> Void in
                                    }
                            }
                    }
                }
                
                
                
                
            }
            
    }
    
    @IBAction func onPanInbox(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(screenView)
        menu.alpha = 1
        print("screenView.center.x: \(screenView.center.x)")
        if sender.state == UIGestureRecognizerState.Began {
            print("it began")
            print (screenView.center)
            self.screenView.center.x = 160
        } else if (sender.state == UIGestureRecognizerState.Changed && screenView.center.x >= 160) {
            print("it changed")
            
             screenView.center = CGPoint(x:screenViewOriginalCenter.x + translation.x, y:screenViewOriginalCenter.y)
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            print("it ended")
            if screenView.center.x >= 320 {
                print ("in > 320")
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.screenView.center.x = 480
                })
            }
            if screenView.center.x < 320 {
                print ("in <320")
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.screenView.center.x = 160
                })
            }
            
        }
    }
    
}


