//
//  DBHelper.swift
//  RioOlympicsGames2016
//
//  Created by derex pan on 2016/11/5.
//  Copyright © 2016年 derex pan. All rights reserved.
//

import Foundation

struct DBHelper {
    
    static var db: OpaquePointer? = nil
    
    
    //获得沙箱目录Document全路径，返回C语言的字符串
    static func applicationDocumentDirectoryFile(fileName:String) -> [CChar]? {
        let documentDirectory: Array = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = documentDirectory[0].appending(fileName)
        let cPath = path.cString(using: String.Encoding.utf8)
        
        NSLog("沙箱目录链接为: %@",path)
        
        return cPath
    }
    //获得数据库版本号方法
    static func dbVersionNumber() -> Int {
        var versionNumber = -1
        let dbFilePath = self.applicationDocumentDirectoryFile(fileName: DB_FILE_NAME)
        if sqlite3_open(dbFilePath, &db) == SQLITE_OK {
            let sql = "CREATE TABLE IF NOT EXISTS DBVersionInfo(version_number Int)" as NSString
            let cSql = sql.cString(using: String.Encoding.utf8.rawValue)
            
            sqlite3_exec(db, cSql, nil, nil, nil) //执行创建有版本号的表格
            
            //查询版本号
            let qsql = "SELECT version_number FROM DBVersionInfo)" as NSString
            let cqSql = qsql.cString(using: String.Encoding.utf8.rawValue)
            
            var statement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, cqSql, -1, &statement, nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_ROW {
                    NSLog("有数据")
                    versionNumber = Int(sqlite3_column_int(statement, 0))
                } else {
                    NSLog("无数据")
                    let insertSQL : NSString = "INSERT INTO DBVersionInfo(version_number) VALUES(-1)"
                    let cInsertSQL = insertSQL.cString(using: String.Encoding.utf8.rawValue)
                    
                    sqlite3_exec(db, cInsertSQL, nil, nil, nil)
                }
                sqlite3_finalize(statement)
                sqlite3_close(db)
            }
        }
        return versionNumber
    }
    
    //数据库初始化
    static func initDB() {
        //1.获取属性列表文件中数据库版本号
        let dbConfigPath = Bundle.main.path(forResource: "DBConfig", ofType: "plist")
        let dbConfigDictionary = NSDictionary(contentsOfFile: dbConfigPath!)
        var dbConfigVersion = dbConfigDictionary?.object(forKey: "DB_VERSION") as? NSNumber
        if dbConfigVersion == nil {
            dbConfigVersion = 0
        }
        print("初始化数据库")
        //2.获取数据库版本号
        let versionNumber = self.dbVersionNumber()
        
        //3.对比两个版本号是否一致
        if dbConfigVersion?.intValue != versionNumber {
            let dbFilePath = self.applicationDocumentDirectoryFile(fileName: DB_FILE_NAME)
            if sqlite3_open(dbFilePath, &db) == SQLITE_OK {
                //创建数据库
                let createDBPath = Bundle.main.path(forResource: "create_load", ofType: "sql")
                
                do {
                    let createSql = try NSString(contentsOfFile: createDBPath!, encoding: String.Encoding.utf8.rawValue)
                    let cSql = createSql.cString(using: String.Encoding.utf8.rawValue)
                    
                    sqlite3_exec(db, cSql!, nil, nil, nil)
                    
                    //用属性列表文件中的版本号替代数据库中的版本号
                    let uSql = NSString(format: "UPDATE DBVersionInfo SET version_number = %i", (dbConfigVersion?.intValue)!)
                    
                    let cUsql = uSql.cString(using: String.Encoding.utf8.rawValue)
                    
                    sqlite3_exec(db, cUsql!, nil, nil, nil) //执行更新版本号的sql语句
                    
                    sqlite3_close(db)
                } catch {
                    NSLog("读取sql创建数据库文件失败")
                }
            }
        }
    }
}
