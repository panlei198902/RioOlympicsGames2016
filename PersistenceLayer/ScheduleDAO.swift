//
//  ScheduleDAO.swift
//  RioOlympicsGames2016
//
//  Created by derex pan on 2016/11/6.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import Foundation

class ScheduleDAO: baseDAO {
    //单例变量
    static let sharedInstance = ScheduleDAO()
    private override init() {}
    
    //插入方法
    func insert(model: Schedule) -> Int {
        
        if self.openDB() {
            let sql = "INSERT INTO Schedule(GameDate,GameTime,GameInfo,EventID) VALUES (?,?,?,?)"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            //使用sqlite3_prepare_v2函数预处理SQL语句
            var statement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, cSql, -1, nil, nil) == SQLITE_OK{
                sqlite3_bind_text(statement, 1, model.GameDate!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_text(statement, 2, model.GameTime!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_text(statement, 3, model.GameInfo!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_int(statement, 4, Int32(model.Event!.EventID))
                
                //4.使用sqlite3_step函数执行SQL语句，遍历结果集
                if sqlite3_step(statement) != SQLITE_DONE {
                    assert(false,"数据插入失败")
                }
            }
            
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    
    //删除方法
    func remove(model:Schedule) -> Int {
        
        if self.openDB() {
            let sql = "DELETE FROM Schedule WHERE ScheduleID = ?"
            let cSQL = sql.cString(using: String.Encoding.utf8)
            
            //预处理SQL语句
            var statement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, cSQL, -1, &statement, nil) == SQLITE_OK {
                
                //绑定参数
                sqlite3_bind_int(db, 1, Int32(model.ScheduleID!))
                
                //执行删除
                if sqlite3_step(statement) != SQLITE_DONE {
                    assert(false, "数据删除失败")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    
    //修改方法
    func modify(model:Schedule) -> Int {
        
        if self.openDB() {
            let sql = "UPDATE Schedule SET GameDate=?,GameTime=?,GameInfo=?,EventID=? where ScheduleID =?"
            let cSQL = sql.cString(using: String.Encoding.utf8)
            //使用sqlite3_prepare_v2预处理语句
            var statement : OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, cSQL, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, model.GameDate!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_text(statement, 2, model.GameTime!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_text(statement, 3, model.GameInfo!.cString(using: String.Encoding.utf8.rawValue), -1, nil)
                sqlite3_bind_int(statement, 4, Int32(model.Event!.EventID!))
                sqlite3_bind_int(statement, 5, Int32(model.ScheduleID!))
                
                if sqlite3_step(statement) != SQLITE_DONE {
                    assert(false,"修改Schedule数据失败")
                }
            }
            
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    //按主键进行查询
    func findByKey(model: Schedule) -> Schedule? {
        
        if self.openDB() {
            let sql = "select GameDate,GameTime,GameInfo,EventID, ScheduleID from Schedule Where ScheduleID = ? "
            let cSQL = sql.cString(using: String.Encoding.utf8)
            
            //预处理
            var statement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, cSQL, -1, &statement, nil) == SQLITE_OK {
                
                sqlite3_bind_int(db, 1, Int32(model.ScheduleID!))
                
                //使用sqlite_step函数执行SQL语句，遍历结果集
                while sqlite3_step(statement) == SQLITE_ROW {
                    let schedule = Schedule()
                    let event = Events()
                    
                    schedule.Event = event
                    
                    //提取字段数据，char* -> String
                    let cGameDate = sqlite3_column_text(db, 0)
                    schedule.GameDate = String(cString: cGameDate!) as NSString
                    
                    let cGameTime = sqlite3_column_text(db, 1)
                    schedule.GameTime = String(cString: cGameTime!) as NSString
                    
                    let cGameInfo = sqlite3_column_text(db, 2)
                    schedule.GameInfo = String(cString: cGameInfo!) as NSString
                    
                    schedule.Event!.EventID = Int(sqlite3_column_int(db, 3))
                    schedule.ScheduleID = Int(sqlite3_column_int(db, 4))
                    
                    
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    
                    return schedule
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return nil
    }
    
    //查询所有数据方法
    func findAll() -> NSMutableArray {
        
        var dates = NSMutableArray()
        
        if self.openDB() {
            let sql = "select GameDate,GameTime,GameInfo,EventID,ScheduleID from Schedule"
            let cSQL = sql.cString(using: String.Encoding.utf8)
            
            //sqlite3_v2预处理
            var statement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, cSQL, -1, &statement, nil) == SQLITE_OK {
                
                //使用sqlite3_step函数执行SQL语句，遍历结果集
                while sqlite3_step(statement) == SQLITE_ROW {
                
                    let schedule = Schedule()
                    let event = Events()
                    
                    schedule.Event = event
                    

                    
                    //使用sqlite3_column_text等函数提取字段数据
                    //char* -> String
                    let cGameDate = sqlite3_column_text(statement, 0)
                    schedule.GameDate = String(cString: cGameDate!) as NSString
                    
                    let cGameTime = sqlite3_column_text(statement, 1)
                    schedule.GameTime = String(cString: cGameTime!) as NSString
                    
                    let cGameInfo = sqlite3_column_text(statement, 2)
                    schedule.GameInfo = String(cString: cGameInfo!) as NSString
                    
                    schedule.Event!.EventID = Int(sqlite3_column_int(statement, 3))
                    
                    schedule.ScheduleID = Int(sqlite3_column_int(statement, 4))
                    
                    dates.add(schedule)
                }
            }
            
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return dates
    }
    
    
}
