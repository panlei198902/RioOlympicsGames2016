//
//  EventsBL.swift
//  RioOlympicsGames2016
//
//  Created by Derexpan on 2016/11/7.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import UIKit

class EventsBL: NSObject {
    
    //查询所有数据方法
    func readData() -> NSMutableArray {
        let dao = EventsDAO.sharedInstance
        var  list = dao.findAll()
        return list
    }
}
