//
//  EventDetailView.swift
//  RioOlympicsGames2016
//
//  Created by Derexpan on 2016/11/9.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import UIKit

class EventDetailView: UIViewController {
    var event:Events!
    @IBOutlet weak var imgEventIcon: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var keyInfo: UITextView!
    @IBOutlet weak var basicInfo: UITextView!
    @IBOutlet weak var olympicsInfo: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgEventIcon.image = UIImage(named: self.event.EventIcon! as String)
        eventName.text = self.event.EventName! as String
        keyInfo.text = self.event.KeyInfo! as String
        basicInfo.text = self.event.BasicsInfo! as String
        olympicsInfo.text = self.event.OlympicInfo! as String
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
