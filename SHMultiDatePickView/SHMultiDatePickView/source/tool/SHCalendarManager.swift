//
//  SHCalendarManager.swift
//  Crabs_star
//
//  Created by SHyH5 on 2018/1/17.
//  Copyright © 2018年 com.newlandcomputer.app. All rights reserved.
//

import Foundation

class SHCalendarManager: NSObject {
    
    static let share = SHCalendarManager()
    private override init() {
        super.init()
    }

    //MARK: 计算出一周中的第一天,或周末第一天，或一月中第一天，一年中第一天
    func getFirstDayFromWeek(_ dateString : String) -> [String]{
        var dateArr = [String]()
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let date = dateFormatter.date(from: dateString)
        
        var calendar = Calendar.current
        //设置一周的第一天是周一
        calendar.firstWeekday = 2
        
        //获取本周的第一天
        var beginningOfWeek: Date = date ?? Date()
        var interval01:TimeInterval = 0
        let ok01 = calendar.dateInterval(of: .weekOfMonth, start: &beginningOfWeek, interval: &interval01, for: date!)
        
        //获取本周的最后一天
        let end = beginningOfWeek.addingTimeInterval(interval01 - 1)
        if ok01 == true{
            let thebeginningOfWeek = dateFormatter.string(from: beginningOfWeek)
           // let newBeginning = self.getYesterDate(thebeginningOfWeek, pickMode: .day, isYester: false)
            let endWeek = dateFormatter.string(from: end)
           // let newEnd = self.getYesterDate(endWeek, pickMode: .day, isYester: false)
            dateArr.append(thebeginningOfWeek)
            dateArr.append(endWeek)
           // print("thebeginningOfWeek : \(thebeginningOfWeek), end: \(endWeek)")
        }else{
            dateArr.append("")
            dateArr.append("")
            print("")
        }
        
        return dateArr
    }
    
    //MARK: 获取当月的天数
    func getAllDaysWithCalender(_ dateString : String) -> Int {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM"
        let date = dateFormatter.date(from: dateString)
        
        let calender = Calendar.init(identifier: .gregorian)
        
        let range =  calender.range(of: .day, in: .month, for: date ?? Date())
        return range!.count
    }
    
    
    //MARK: 指定的某一天是周几
    func getWeekWithDate(_ date : Date) -> Int {
        let calender = Calendar.init(identifier: .gregorian)
        let comps = calender.component(.weekday, from: date)
        return comps
        
    }
    
    
    //MARK: 指定的某一天在第几周
    func getWeekth(_ date : String) -> Int {
        let fmt = DateFormatter.init()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy-MM-dd"
        
        let dateS = fmt.date(from: date)
        
        let calender = Calendar.current
        let comps = calender.component(.weekdayOrdinal, from: dateS ?? Date())
        return comps
        
    }
    
    //MARK: 获取周
    func configCalendar() {
        let date = Date()
        let calender = Calendar.init(identifier: .gregorian)
        let componentsSet = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfMonth])
        let comps = calender.dateComponents(componentsSet, from: date)
         print("comps: ",comps)
        
    }
    
    //MARK: 获取今天的年月日
    func getYearMonthDay() -> [String]{
        let fmt = DateFormatter.init()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy.MM.dd"
        let dateS = fmt.string(from: Date())
        let array =  dateS.components(separatedBy: ".")
        return array
    }
    
    //MARK: 时间格式转化
    func dateFrom(_ string: String) -> Date {
        let fmt = DateFormatter.init()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy-MM-dd"
        let dateS = fmt.date(from: string)
        return dateS!
    }
    
    //MARK: 获取前一天，或者后一天 (日期和类型保持一致)
    // - Parameters:
    //  _ current: 当前日期  这里传进来的格式是 - yyyy.MM.dd
    //  _ isYester: 是：前一天； 否： 后一天
    //  _ pickMode:类型 年，月，日 ，周
    
    func getYesterDate(_ current: String, pickMode: PickMode, isYester: Bool = true) -> String {

        let fmt = DateFormatter.init()
        fmt.locale = Locale(identifier: "zh_CN")
        
        let calener = Calendar.init(identifier: .gregorian)
        var lastDateCom = DateComponents()
        
        switch pickMode {
        case .day:
            fmt.dateFormat = "yyyy-MM-dd"
            if isYester {
                lastDateCom.setValue(-1, for: .day)
            } else {
                lastDateCom.setValue(1, for: .day)
            }
            
            let dateS = fmt.date(from: current)
            let date = calener.date(byAdding: lastDateCom, to: dateS ?? Date())
            fmt.dateFormat = "yyyy.MM.dd"
            let lastDate = fmt.string(from: date ?? Date())
            
            return lastDate
        
        case .week:
            let currentArr = current.components(separatedBy: "-")
            let lastDate = self.getTouchLastOrNextWeek(currentArr, isYester: isYester)
            return lastDate
           
        case .month:
            fmt.dateFormat = "yyyy-MM"
            if isYester {
                lastDateCom.setValue(-1, for: .month)
            } else {
                lastDateCom.setValue(1, for: .month)
            }
            
            let dateS = fmt.date(from: current)
            let date = calener.date(byAdding: lastDateCom, to: dateS ?? Date())
            fmt.dateFormat = "yyyy.MM"
            let lastDate = fmt.string(from: date ?? Date())
            
            return lastDate
           
        case .year:
            fmt.dateFormat = "yyyy"
            if isYester {
                lastDateCom.setValue(-1, for: .year)
            } else {
                lastDateCom.setValue(1, for: .year)
            }
            
            let dateS = fmt.date(from: current)
            let date = calener.date(byAdding: lastDateCom, to: dateS ?? Date())
            let lastDate = fmt.string(from: date ?? Date())
            
            return lastDate
            
        
//        case .yesterday:
//            fmt.dateFormat = "yyyy-MM-dd"
//            if isYester {
//                lastDateCom.setValue(-1, for: .day)
//            } else {
//                lastDateCom.setValue(1, for: .day)
//            }
//
//            let dateS = fmt.date(from: current)
//            let date = calener.date(byAdding: lastDateCom, to: dateS ?? Date())
//            fmt.dateFormat = "yyyy.MM.dd"
//            let lastDate = fmt.string(from: date ?? Date())
//
//            return lastDate
        }
        
    }
    

    //MARK : pickview 获取上一周的日期区间或者下一周的日期区间
    // currentDate 当前周的年月
    func getLastOrNextWeek(_ currentDate: String, weekNum : Int) -> String {
        var selectDate = ""
        switch weekNum {
        case 1 :
            let str = currentDate + ".01"
            let array = SHCalendarManager.share.getFirstDayFromWeek(str)
            selectDate = array[0] + "-" + array[1]
        case 2 :
            let str = currentDate + ".08"
            let array = SHCalendarManager.share.getFirstDayFromWeek(str)
            selectDate = array[0] + "-" + array[1]
        case 3 :
            let str = currentDate + ".15"
            let array = SHCalendarManager.share.getFirstDayFromWeek(str)
            selectDate = array[0] + "-" + array[1]
        case 4 :
            let str = currentDate + ".22"
            let array = SHCalendarManager.share.getFirstDayFromWeek(str)
            selectDate = array[0] + "-" + array[1]
        case 5 :
            let daynum = self.getAllDaysWithCalender(currentDate)
            
            let str = daynum > 28 ? currentDate + ".29" : currentDate + ".28"
            let array = SHCalendarManager.share.getFirstDayFromWeek(str)
            selectDate = array[0] + "-" + array[1]
        case 6 :
            let daynum = self.getAllDaysWithCalender(currentDate)
            let str = daynum > 30 ?  currentDate + ".31" : currentDate + ".30"
            let array = SHCalendarManager.share.getFirstDayFromWeek(str)
            selectDate = array[0] + "-" + array[1]
        default:
            break
        }
        
        return selectDate
    }
    
    //MARK: 点击选择上一个，下一个周区间
    func getTouchLastOrNextWeek(_ dateArr: [String], isYester : Bool) -> String {
        let dateString = isYester ? dateArr[0] : dateArr[1]
        let array = self.getFirstDayFromWeek(dateString)
        //获取当月所以天数
        let monthDay = self.getAllDaysWithCalender(dateString)
        if array.count < 1 {
            return ""
        }
        
        if isYester { //上一周
            let firstDay = array[0]
            let strA = firstDay.components(separatedBy:".")
            if "\(strA[2])" == "01" || "\(strA[2])" == "1" { //01正好是周一的情况
                if "\(strA[1])" == "01" || "\(strA[1])" == "1"  { //0101正好是周一的情况
                    let newDays = "\(Int(strA[0])! - 1)" + ".12.28"
                    let newArr = self.getFirstDayFromWeek(newDays)
                    return "\(newArr[0])-\(newArr[1])"
                }
                    let newDays = strA[0] + ".\(Int(strA[1])! - 1)" + ".28"
                    let newArr = self.getFirstDayFromWeek(newDays)
                    return "\(newArr[0])-\(newArr[1])"
               
            }
            
            let newDay =  Int(strA[2])! - 1
            let newDays = strA[0] + "." + strA[1] + "." + "\(newDay)"
            let newArr = self.getFirstDayFromWeek(newDays)
            return "\(newArr[0])-\(newArr[1])"
            
        }
        
        //下一周
        let firstDay = array[1]
        let strA = firstDay.components(separatedBy:".")
        if "\(strA[2])" == String(monthDay) || "\(strA[2])" > String(monthDay)  { //等于最后一天
            if "\(strA[1])" == "12" { //是不是最后一个月
                let newDay =  Int(strA[0])! + 1
                let newDays = String(newDay) + ".01.01"
                let newArr = self.getFirstDayFromWeek(newDays)
                return "\(newArr[0])-\(newArr[1])"
            }
            
            let newDays = strA[0] + ".\(Int(strA[1])! + 1).01"
            let newArr = self.getFirstDayFromWeek(newDays)
            return "\(newArr[0])-\(newArr[1])"
            
        }
        
        let newDay =  Int(strA[2])! + 1
        let newDays = strA[0] + "." + strA[1] + "." + "\(newDay)"
        let newArr = self.getFirstDayFromWeek(newDays)
        return "\(newArr[0])-\(newArr[1])"
        
    }
    
    //MARK: 一个月有多少周：从星期一开始， 星期天结束
    func getWeekNumOfMonth(_ dateStr: String) -> Int {
        let dateFirst = dateStr + ".01"
        //如果第一天是星期六，且天数大于三十天 ，六周；如果第一天是星期天，且天数等于31 ，六周
        let fmt = DateFormatter.init()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy.MM.dd"
        let weekdate = fmt.date(from: dateFirst)
        let num = weekdate?.weeksInMonth(firstWeekday: .monday)

        return num ?? 5
    }
    

//MARK: ********************************  暂时没用到的方法 *********************************************
    
    /**
     *  获取当月中所有天数是周几
     */
    func getAllDaysWeek(_ dateString: String) -> [Int] {
        let dayCount = self.getAllDaysWithCalender(dateString)
        
        let fmt = DateFormatter.init()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy-MM-dd"
        let dateS = fmt.date(from: dateString)
        
        fmt.dateFormat = "yyyy-MM"
        let str1 = fmt.string(from: dateS ?? Date())
        
        fmt.dateFormat = "yyyy-MM-dd"
        var allDate = [Int]()
        
        for index in 1...dayCount {
            let string  = str1 + "-\(index)"
            let date = fmt.date(from: string)
            let some = self.getWeekWithDate(date ?? Date())
            allDate.append(some)
        }
        
        print("allDate- ",allDate)
        return allDate
        
    }
    
    
    
    
    
}
