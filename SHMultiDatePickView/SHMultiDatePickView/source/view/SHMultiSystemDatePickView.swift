//
//  SHMultiSystemDatePickView.swift
//  SHMultiDatePickView
//
//  Created by SHyH5 on 2018/2/8.
//  Copyright © 2018年 SHyH5. All rights reserved.
//

import UIKit

class SHMultiSystemDatePickView: SHMultiBasicDatePickView {
    
    var pick: PickMode = .day {
        didSet{
            if pick == .day {
                dataPick.setDate(Date(), animated: true)
            } else { //昨天
                let calener = Calendar.init(identifier: .gregorian)
                var lastDateCom = DateComponents()
                lastDateCom.setValue(-1, for: .day)
                let date = calener.date(byAdding: lastDateCom, to:Date())
                dataPick.setDate(date!, animated: true)
                dataPick.maximumDate = date!
            }
            
        }
    }
    
    override func configUI() {
        super.configUI()
        pickview.addSubview(dataPick)
       
    }
    
    @objc
    fileprivate func dateChanged(_ sender : AnyObject) {
        let control = sender as! UIDatePicker
        let date = control.date
        let fmt = DateFormatter.init()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy.MM.dd"
        let dateS = fmt.string(from: date)
        selectDate = dateS
        
    }
    
    
    fileprivate
    lazy var dataPick : UIDatePicker = {
        let pic = UIDatePicker()
        pic.frame = CGRect.init(x: 0, y: 0, width: self.pickview.frame.size.width, height: self.pickview.frame.size.height)
        pic.backgroundColor = kLightGaryBackColor
        pic.datePickerMode = .date
        pic.locale = Locale(identifier: "zh_CN")
        pic.setDate(Date(), animated: true)
        pic.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        return pic
    }()


}
