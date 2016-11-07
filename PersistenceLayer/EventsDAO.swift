//
//  EventsDAO.swift
//  RioOlympicsGames2016
//
//  Created by derex pan on 2016/11/6.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import Foundation

class EventsDAO: baseDAO {
    
    //单例常量
    static let sharedInstance : EventsDAO = EventsDAO()
    private override init() {}
    
    //插入方法
    func insert(model: Events) -> Int {
        
        if self.openDB() {
            let sql = "INSERT INTO Events Events (EventName,EventIcon,KeyInfo,BasicsInfo,OlympicInfo) values (?,?,?,?)"
            let cSQL = sql.cString(using: String.Encoding.utf8)
            
            //预处理
            var statement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, cSQL, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, -1, model.EventName?.cString(using: String.Encoding.utf8.rawValue), 1, nil)
                sqlite3_bind_text(statement, -1, model.EventIcon?.cString(using: String.Encoding.utf8.rawValue), 2, nil)
                sqlite3_bind_text(statement, -1, model.KeyInfo?.cString(using: String.Encoding.utf8.rawValue), 3, nil)
                sqlite3_bind_text(statement, -1, model.BasicsInfo?.cString(using: String.Encoding.utf8.rawValue), 4, nil)
                sqlite3_bind_text(statement, -1, model.OlympicInfo?.cString(using: String.Encoding.utf8.rawValue), 5, nil)
                
                if sqlite3_step(statement) != SQLITE_DONE {
                    assert(false,"数据库插入失败")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    //数据删除
    
    
}
