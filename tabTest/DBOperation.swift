//
//  DBOperation.swift
//  tabTest
//
//  Created by john on 15/10/12.
//  Copyright © 2015年 test. All rights reserved.
//

import UIKit

// 表名
enum TableName_one: String {
    case HomePage = "home_page"
    case Artical = "article"
    case Question = "question"
    case Good = "good"
    
    func allField() -> Array<String> {
        switch self {
        case .HomePage:
            return TableName_one.field_HomePage()
        case .Artical:
            return TableName_one.field_Artical()
        case .Question:
            return TableName_one.field_Question()
        case .Good:
            return TableName_one.field_Good()
        }
    }
    
    func tableStruct() -> Array<Dictionary<String, String>> {
        switch self {
        case .HomePage:
            return TableName_one.table_HomePage
        case .Artical:
            return TableName_one.table_Artical
        case .Question:
            return TableName_one.table_Question
        case .Good:
            return TableName_one.table_Good
        }
    }
    
    // MARK: table structure
    private static let table_HomePage = [
        ["key": "id", "type": "text"],                  ["key": "strLastUpdateDate", "type": "text"],
        ["key": "strDayDiffer", "type": "text"],        ["key": "strHpId", "type": "text"],
        ["key": "strHpTitle", "type": "text"],          ["key": "strThumbnailUrl", "type": "text"],
        ["key": "strOriginalImgUrl", "type": "text"],   ["key": "strAuthor", "type": "text"],
        ["key": "strContent", "type": "text"],          ["key": "strMarketTime", "type": "text"],
        ["key": "sWebLk", "type": "text"],              ["key": "strPn", "type": "text"],
        ["key": "wImgUrl", "type": "text"]
    ]
    private static let table_Artical = [
        ["key": "id", "type": "text"],                  ["key": "strLastUpdateDate", "type": "text"],
        ["key": "strContent", "type": "text"],          ["key": "sWebLk", "type": "text"],
        ["key": "wImgUrl", "type": "text"],             ["key": "sRdNum", "type": "text"],
        ["key": "strPraiseNumber", "type": "text"],     ["key": "strContDayDiffer", "type": "text"],
        ["key": "strContentId", "type": "text"],        ["key": "strContTitle", "type": "text"],
        ["key": "strContAuthor", "type": "text"],       ["key": "strContAuthorIntroduce", "type": "text"],
        ["key": "strContMarketTime", "type": "text"],   ["key": "sGW", "type": "text"],
        ["key": "sAuth", "type": "text"],               ["key": "sWbN", "type": "text"],
        ["key": "subTitle", "type": "text"]
    ]
    private static let table_Question = [
        ["key": "id", "type": "text"],                  ["key": "strLastUpdateDate", "type": "text"],
        ["key": "strDayDiffer", "type": "text"],        ["key": "sWebLk", "type": "text"],
        ["key": "strPraiseNumber", "type": "text"],     ["key": "strQuestionId", "type": "text"],
        ["key": "strQuestionTitle", "type": "text"],    ["key": "strQuestionContent", "type": "text"],
        ["key": "strAnswerTitle", "type": "text"],      ["key": "strAnswerContent", "type": "text"],
        ["key": "strQuestionMarketTime", "type": "text"], ["key": "sEditor", "type": "text"]
    ]
    private static let table_Good = [
        ["key": "id", "type": "text"],                  ["key": "strLastUpdateDate", "type": "text"],
        ["key": "strPn", "type": "text"],               ["key": "strBu", "type": "text"],
        ["key": "strTm", "type": "text"],               ["key": "strWu", "type": "text"],
        ["key": "strId", "type": "text"],               ["key": "strTt", "type": "text"],
        ["key": "strTc", "type": "text"]
    ]
    // MARK: table field array
    private static func field_HomePage() -> Array<String> {
        return TableName_one.table_HomePage.map({ (fieldDesc) -> String in
            return fieldDesc["key"]!
        })
    }
    
    private static func field_Artical() -> Array<String> {
        return table_Artical.map({ $0["key"]! })
    }
    
    private static func field_Question() -> Array<String> {
        return table_Question.map({ $0["key"]! })
    }
    
    private static func field_Good() -> Array<String> {
        return table_Good.map({ $0["key"]! })
    }
}

class DBOperation: NSObject {
    
    // 创建数据库
    class func createDB() -> Bool {
        if NSUserDefaults.standardUserDefaults().boolForKey("successCreateDB") {
            return true
        }
        
        let database = specialDB()
        
        if database == nil {
            return false
        }
        if !database.open() {
            print("Unable to open database")
            return false
        }
        
        if !createTable(database) {
            return false
        }
        
        database.close()
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "successCreateDB")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        return true
    }
    
    /** 插入记录
    @param table : 指定数据表
    @param pk : 主键
    @param record : 插入的记录数据
    @return bool : 插入成功返回true，记录已存在返回true，参数不合法或数据库事物错误返回false
    */
    class func insertRecord(table: TableName_one, pk: String, record: [String : AnyObject]) -> Bool {
        // check validate of record
        if pk.characters.count == 0 {
            print("invalid primary key")
            return false
        }
        var pRecord = record
        pRecord["id"] = pk
        for (key, _) in pRecord {
            if !table.allField().contains(key) {
                pRecord.removeValueForKey(key)
            }
        }
        if pRecord.count == 0 {
            print("invalid record")
            return false
        }

        // open database
        let database = specialDB()
        
        if database == nil {
            return false
        }
        if !database.open() {
            print("Unable to open database")
            return false
        }
        defer {
            database.close()
        }
        
        // 检查记录是否已经存在
        var recordExist = false
        if let rs = database.executeQuery("SELECT * FROM \(table.rawValue) WHERE id = ?", withArgumentsInArray: [pk]) {
            while rs.next() {
                recordExist = true
                break
            }
        } else {
            print("select failed: \(database.lastErrorMessage())")
            return false
        }
        
        if recordExist {
            print("record alread exsit")
            return true
        }
        
        // 插入记录
        var sql = "INSERT INTO \(table.rawValue)"
        var valist1 = "("
        var valist2 = "("
        for (filed, _) in pRecord {
            valist1 += "\(filed), "
            valist2 += ":\(filed), "
        }
        // 去掉多余的逗号
        if valist1.characters.count > 2 {
            valist1.removeRange(Range(start: valist1.endIndex.advancedBy(Int(-2)), end: valist1.endIndex))
        }
        valist1 += ")"
        if valist2.characters.count > 2 {
            valist2.removeRange(Range(start: valist2.endIndex.advancedBy(Int(-2)), end: valist2.endIndex))
        }
        valist2 += ")"

        sql += "\(valist1) VALUES \(valist2)"
        
        /** 下面这个地方要注意。执行insert语句时，如果不指定插入元素，默认插入所有列，列的排序是表结构的排序。而Dictionary是无序的，居然不是按照名字排列。
        * 具体解释下遇到的bug。假设表AAA(a text, b text, c text),现在插入 insert into AAA values (:a, :b, :c) withParameterDictionary{a:1, b:2, c:3}，插入的结果不一定是1，2，3的记录。真是诡异。这个地方也是我的疏忽，没有指定插入列名
        * 那么改成 insert into AAA(a, b, c) values (:a, :b, :c) withParameterDictionary{a:1, b:2, c:3} 就是正确的。
        * 根据我的推测，当省略列名时，默认插入所有列，所有列按数据表结构排序。上面的bug究竟在哪里？在这，ParameterDictionary的顺序是指定values的，并不指定插入列，由于dictionary的无序，自动生成的sql语句可能是insert into AAA values (:c, :a, :b)，总之后面的参数顺序是无法确定的，而默认列的顺序就是按照表结构来的，插入的顺序就乱序了，一团糟
        */
        if database.executeUpdate(sql, withParameterDictionary: pRecord) {
            return true
        } else {
            print("insert failed: \(database.lastErrorMessage())")
            return false
        }
    }
    
    /** 查询记录
    @param table : 指定数据表
    @param pk : 主键
    @return 查询到则返回查询结果，其他返回nil
    */
    class func queryRecord(table: TableName_one, pk: String) -> [String : AnyObject]? {
        // open database
        let database = specialDB()
        
        if database == nil {
            return nil
        }
        if !database.open() {
            print("Unable to open database")
            return nil
        }
        defer {
            database.close()
        }
        
        // 查询记录
        if let rs = database.executeQuery("SELECT * FROM \(table.rawValue) WHERE id = ?", withArgumentsInArray: [pk]) {
            while rs.next() {
                if rs.resultDictionary() is [String: AnyObject] {
                    return (rs.resultDictionary() as! [String: AnyObject])
                } else {
                    return nil
                }
            }
            return nil
        } else {
            print("select failed: \(database.lastErrorMessage())")
            return nil
        }
    }
    
    // 数据库文件位置
    class private func specialDB() -> FMDatabase! {
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsFolder.stringByAppendingPathComponent("onedb.sqlite")
        return FMDatabase(path: path)
    }
    
    class private func DropSpecialDB() -> Bool {
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsFolder.stringByAppendingPathComponent("onedb.sqlite")
        do {
            try NSFileManager.defaultManager().removeItemAtPath(path)
            return true
        } catch {
            return false
        }
    }
    
    // 建表。四张表以 yyyyMMdd 为主键
    class private func createTable(db: FMDatabase) -> Bool {
        // create table
        func pCreateTable(table : TableName_one) -> Bool {
            var sql = "CREATE TABLE IF NOT EXISTS \(table.rawValue)("
            // combine all field
            for fieldDesc in table.tableStruct() {
                guard let key = fieldDesc["key"], let type = fieldDesc["type"] else {
                    print("data structure error")
                    continue
                }
                if key == "id" {
                    sql += "\(key) \(type) primary key, "
                } else {
                    sql += "\(key) \(type), "
                }
            }
            // cut the last comma & space
            if sql.characters.count > 2 {
                sql.removeRange(Range(start: sql.endIndex.advancedBy(Int(-2)), end: sql.endIndex))
            }
            sql += ")"
            
            if db.executeUpdate(sql, withArgumentsInArray: nil) {
                return true
            } else {
                print("create table failed: \(db.lastErrorMessage())")
                return false
            }
        }
        
        if !pCreateTable(TableName_one.HomePage) {
            return false
        }
        if !pCreateTable(TableName_one.Artical) {
            return false
        }
        if !pCreateTable(TableName_one.Question) {
            return false
        }
        if !pCreateTable(TableName_one.Good) {
            return false
        }
        return true
    }
    
}
