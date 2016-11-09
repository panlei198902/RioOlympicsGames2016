//
//  EventDetailView.swift
//  RioOlympicsGames2016
//
//  Created by Derexpan on 2016/11/9.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import UIKit

class EventDetailView: EventsViewController {

    @IBOutlet weak var imgEventIcon: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var keyInfo: UILabel!

    @IBOutlet weak var basicsInfo: UILabel!
    @IBOutlet weak var olympicInfo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
