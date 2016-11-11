//
//  TimerViewController.swift
//  RioOlympicsGames2016
//
//  Created by Derexpan on 2016/11/11.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    @IBOutlet weak var timeShow: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //使用封装时间的类
        let comps = NSDateComponents()
        //设置日期
        comps.day = 5
        comps.month = 8
        comps.year = 2020
        
        //创建日历对象
        let calender = Calendar(identifier: Calendar.Identifier.gregorian)  //公历
        //获取2016-8-5的时间对象
        let destinationDate = calender.date(from: comps as DateComponents)
        //获取当前的NSDate时间对象
        let date = Date()
        //获取当前时间与2016-8-5的天数差
        let compsDiff = calender.dateComponents([Calendar.Component.day], from: date, to: destinationDate!)
        
        let daysDiff = compsDiff.day
        print(daysDiff!)
        self.timeShow.text = "\(daysDiff!)"
        
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
