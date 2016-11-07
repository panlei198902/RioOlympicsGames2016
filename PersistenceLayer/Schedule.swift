//
//  Schedule.swift
//  RioOlympicsGames2016
//
//  Created by derex pan on 2016/11/5.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import UIKit

class Schedule: NSObject {
    var ScheduleID : Int?    //行程编号
    var GameDate : NSString? //比赛日期
    var GameTime : NSString? //比赛时间
    var GameInfo : NSString? //比赛信息
    var Event : Events?  //关联Events
}
