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
    static var sharedInstance : EventsDAO {
        let instance = EventsDAO()
        return instance
    }
    
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
    //查询所有数据方法
    func findAll() -> NSMutableArray {
        
        let datas = NSMutableArray()
        
        if self.openDB() {
            let sql = "SELECT EventName, EventIcon, KeyInfo, BasicsInfo, OlympicInfo, EventID FROM Events"
            let cSQL = sql.cString(using: String.Encoding.utf8)
            
            //预处理sqlite3
            var statement : OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, cSQL, -1, &statement, nil) == SQLITE_OK {
                
                //使用sqlite3_step函数执行SQL语句，遍历结果集
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    let events = Events()
   
                    //使用sqlite3_column_text等函数提取字段数据
                    //char* -> String
                    
                    let cEventName = sqlite3_column_text(statement, 0)
                    events.EventName = String(cString: cEventName!) as NSString
                    
                    let cEventIcon = sqlite3_column_text(statement, 1)
                    events.EventIcon = String(cString: cEventIcon!) as NSString
                    
                    let cKeyInfo = sqlite3_column_text(statement, 2)
                    events.KeyInfo = String(cString: cKeyInfo!) as NSString
                    
                    let cBasicsInfo = sqlite3_column_text(statement, 3)
                    events.BasicsInfo = String(cString: cBasicsInfo!) as NSString
                    
                    let  cOlympicInfo = sqlite3_column_text(statement, 4)
                    events.OlympicInfo = String(cString: cOlympicInfo!) as NSString
                
                    events.EventID = Int(sqlite3_column_int(statement, 5))
                    
                    datas.add(events)
                }
            }
            
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return datas
    }
    
    //主键查询方法
    func findById(model:Events) -> Events? {
        
        if self.openDB() {
            var statement: OpaquePointer? = nil
            
            let sql = "SELECT EventName, EventIcon, KeyInfo, BasicsInfo, OlympicInfo, EventID FROM Event WHERE EventID = ?"
            let cSQL = sql.cString(using: String.Encoding.utf8)
            
            //预处理
            if sqlite3_prepare_v2(db, cSQL, -1, &statement, nil) == SQLITE_OK {
                
                while sqlite3_step(db) == SQLITE_ROW {
                    let event = Events()
                    
                    let cEventName = sqlite3_column_text(db, 0)
                    event.EventName = String(cString: cEventName!) as NSString
                    
                    let cEventIcon = sqlite3_column_text(db, 1)
                    event.EventIcon = String(cString: cEventIcon!) as NSString
                    
                    let cKeyInfo = sqlite3_column_text(db, 2)
                    event.KeyInfo = String(cString: cKeyInfo!) as NSString
                    
                    let cBasicsInfo = sqlite3_column_text(db, 3)
                    event.BasicsInfo = String(cString: cBasicsInfo!) as NSString
                    
                    let cOlympicInfo = sqlite3_column_text(db, 4)
                    event.OlympicInfo = String(cString: cOlympicInfo!) as NSString
                    
                    event.EventID = Int(sqlite3_column_int(db, 5))
              
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    
                    return event
                }
            }
            
            
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return nil
    }
    
    //数据修改
    func modify(model: Events) -> Int {
        if self.openDB() {
            let sql = "UPDATE Events SET EventName = ?, EventIcon = ?, KeyInfo = ?, BasicsInfo = ?, OlympicInfo = ? WHERE = EventID = ?"
            let cSQL = sql.cString(using: String.Encoding.utf8)
            
            //预处理SQL
            var statement : OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, cSQL, -1, &statement, nil) == SQLITE_OK {
                
                sqlite3_bind_text(db, 1, model.EventName!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_text(db, 2, model.EventIcon!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_text(db, 3, model.KeyInfo!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_text(db, 4, model.BasicsInfo!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_text(db, 5, model.OlympicInfo!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_int(db, 6, Int32(model.EventID))
                
                if sqlite3_step(db) != SQLITE_DONE {
                    assert(false, "修改Events数据失败")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    
    
    //数据删除
    func remove(model: Events) -> Int {
        //由于是多表删除，需要使用事务管理
        //先删除子表里的数据(Schedule)
        
        let sqlSchedule = NSString(format: "DELETE FROM SCHEDULE WHERE EventID = %i", model.EventID!)
        
        //开启事务
        sqlite3_exec(db, "Begin immediate transaction", nil, nil, nil)
        
        if sqlite3_exec(db, sqlSchedule.cString(using: String.Encoding.utf8.rawValue), nil, nil, nil) != SQLITE_OK{
            //回滚事务
            sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, nil)
            assert(false,"删除数据失败")
        }
        
        //删除主表(Events)数据
        let sqlEvents = NSString(format: "DELETE FROM EVENTS WHERE EventID = %i", model.EventID!)
        
        if sqlite3_exec(db, sqlEvents.cString(using: String.Encoding.utf8.rawValue), nil, nil, nil) != SQLITE_OK {
            //回滚事务
            sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, nil)
            assert(false,"删除数据Events表失败")
        }
        
        sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, nil)
        sqlite3_close(db)
        
        return 0
    }
    
}
