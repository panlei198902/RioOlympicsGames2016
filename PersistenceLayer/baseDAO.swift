//
//  baseDAO.swift
//  RioOlympicsGames2016
//
//  Created by derex pan on 2016/11/5.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import Foundation

let DB_FILE_NAME = "app.db"

class baseDAO: NSObject {
    
    var db : OpaquePointer? = nil
    let dbPath = DPHelper.applicationDocumentDirectoryFile(fileName: DB_FILE_NAME as NSString) //DBHelper

    
    
    //关闭数据库
    func closeDB() -> Bool {
        if db != nil {
            sqlite3_close(db)
        }
        return true
    }
    
    
    //打开数据库
    func openDB() -> Bool {
        if sqlite3_open(dbPath,&db) != SQLITE_OK {
            sqlite3_close(db)
            NSLog("打开数据库失败")
            return false
        }
        return true
    }
    
    //构造方法
    
    override init() {
        DPHelper.initDB()
    }
    
}
