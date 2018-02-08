//
//  SHMultiCustomDatePickView.swift
//  SHMultiDatePickView
//
//  Created by SHyH5 on 2018/2/8.
//  Copyright © 2018年 SHyH5. All rights reserved.
//

import UIKit



class SHMultiCustomDatePickView: SHMultiBasicDatePickView {
    
    var pickMode : PickMode = .month {
        didSet {
            
            switch pickMode {
            case .day:
                break
            case .week:
                let str = selYear + ".01"
                selectDate = SHCalendarManager.share.getLastOrNextWeek(str, weekNum: 1)
            case .month:
                selectDate = selYear + ".01"
            case .year:
                selectDate = selYear

            }
            
            dataPick.reloadAllComponents()
        }
    }
    
    // var yearArray = [String]()
    var yearArray = [Int]()
    let monthArray = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    var weekArray = [Int]()
    
    var seletWeek : String = ""
    var selMonth : String = ""
    var selYear : String = ""
    
    
    override func configUI() {
        super.configUI()
        
        pickview.addSubview(dataPick)
        configDataSource()
        
    }
    
    //MARK: --  data formatter --
    func configDataSource() {
        let fmt = DateFormatter.init()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy-MM"
        let dateS = fmt.string(from: Date())
        
        let array =  dateS.components(separatedBy: "-")
        let currentY = array[0]
        let currentM = array[1]
        selYear = currentY
        selMonth = currentM
        seletWeek = "1"
        
        for year in 1970...Int(currentY)! + 50 {
            yearArray.append(year)
        }
        
        for (index,year) in yearArray.enumerated() {
            if Int(currentY)! == year {
                dataPick.selectRow(index, inComponent: 0, animated: false)
            }
        }
        
        for (index,month) in monthArray.enumerated() {
            if currentM == month {
                dataPick.selectRow(index, inComponent: 1, animated: false)
            }
        }
        
        self.getWeekArray(dateS)
        
    }
    
    func getWeekArray(_ dateS: String) {
        if weekArray.count > 0 {
            weekArray.removeAll()
        }
        
        let week = SHCalendarManager.share.getWeekNumOfMonth(dateS)
        for index  in 1...week {
            weekArray.append(index)
            
        }
        
        if pickMode == .week {
            dataPick.reloadComponent(2)
        }
    }
    
    //MARK: --  layout --
    fileprivate
    lazy var dataPick : UIPickerView = {
        let pic = UIPickerView()
        pic.frame = CGRect.init(x: 0, y: 0, width: self.pickview.frame.size.width, height: self.pickview.frame.size.height)
        pic.backgroundColor = kGaryBackColor
        pic.delegate = self
        pic.dataSource = self
        return pic
    }()

}


extension SHMultiCustomDatePickView : UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK : -- data source --
    //多少列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickMode {
        case .year:
            return 1
        case .month:
            return 2
        case .week:
            return 3
        case .day:
            return 1
        }
        
    }
    
    //多少行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return yearArray.count
        }
        
        if component == 1 {
            return monthArray.count
        }
        
        return weekArray.count
        
    }
    
    //MARK : -- delegate --
    //设置标题
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0  {
            return "\(yearArray[row])年"
        }
        
        if component == 1  {
            return "\(monthArray[row])月"
        }
        
        if component == 2  {
            return "第\(weekArray[row])周"
        }
        
        return "\(yearArray[row])年"
        
    }
    
    //选择的行数
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            let year =  yearArray[row]
            selYear = String(year)
            selectDate = selYear
            if pickMode == .month {
                selMonth = "01"
                selectDate = selYear + ".01"
                pickerView.selectRow(0, inComponent: 1, animated: true)
            }
            
            if pickMode == .week {
                
                let str = selYear + ".01"
                selectDate = SHCalendarManager.share.getLastOrNextWeek(str, weekNum: 1)
                pickerView.selectRow(0, inComponent: 1, animated: true)
                pickerView.selectRow(0, inComponent: 2, animated: true)
            }
            
        }
        
        if component == 1  {
            let month =  monthArray[row]
            selMonth = String(month)
            selectDate = selYear + "." + selMonth
            
            if pickMode == .week {
                let week = selYear + "." + selMonth
                self.getWeekArray(week)
                selectDate = SHCalendarManager.share.getLastOrNextWeek(week, weekNum: 1)
                pickerView.selectRow(0, inComponent: 2, animated: true)
            }
        }
        
        if component == 2  {
            let week =  weekArray[row]
            seletWeek = String(week)
            
            let str = selYear + "." + selMonth
            selectDate =  SHCalendarManager.share.getLastOrNextWeek(str, weekNum: week)
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label =  UILabel()
        label.textColor = UIColor.colorWithHexString("#585858")
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        
        return label
    }
    
}


