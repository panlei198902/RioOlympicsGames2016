//
//  ScheduleBL.swift
//  RioOlympicsGames2016
//
//  Created by Derexpan on 2016/11/7.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import UIKit

class ScheduleBL: NSObject {
    //查询所有数据
    func readData() -> NSMutableDictionary {
        
        let scheduleDAO = ScheduleDAO.sharedInstance  //创建ScheduleDAO单例
        let schedules = scheduleDAO.findAll()        //将查询到的ScheduleDAO中所有数据，放置到schedules中，类型为NSMutableArray
        let resDict = NSMutableDictionary()          //创建空的NSMutableDictionary
        
        let eventsDAO = EventsDAO.sharedInstance   //创建EventsDAO单例
        
        //遍历所有schedules中的数据,放到字典中
        for item in schedules {
            let schedule = item as! Schedule
            let event = eventsDAO.findById(model: schedule.Event!)
            schedule.Event = event
            
            
            //将NSMutableArray结构数据转化为NSMutableDictonary数据结构
            let allKey = resDict.allKeys as NSArray
            
            if allKey.contains(schedule.GameDate!) {  //判断是否包含比赛日期
                let values = resDict[schedule.GameDate!] as! NSMutableArray
                values.add(schedule)
            } else {
                let values = NSMutableArray()
                values.add(schedule)
                resDict.setObject(values, forKey: schedule.GameDate!)
            }
            NSLog(schedule.Event!.EventName! as String)
        }
        return resDict
    }
}
