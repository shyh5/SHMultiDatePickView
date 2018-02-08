//
//  SHCalendarView.swift
//  Crabs_star
//
//  Created by SHyH5 on 2018/1/16.
//  Copyright © 2018年 com.newlandcomputer.app. All rights reserved.
//

import UIKit

enum TouchMode {
    case pass, next, center
}

typealias CalenderClick = ( _ starDate: String, _ starDate: String) -> ()
class SHCalendarView: UIView {
    
    ///点击状态
    var touchMode : TouchMode? = .center
    
    var calenderClick : CalenderClick?
    var pickMode : PickMode = .day {
        didSet {
            let array = SHCalendarManager.share.getYearMonthDay()
            if array.count > 2 {
                switch pickMode {
//                case .yesterday:
//                    let sel = "\(array[0]).\(array[1]).\(array[2])"
//                    self.selectDate = SHCalendarManager.share.getYesterDate(sel, pickMode: .day)
//                    self.dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//
                case .day:
                    self.selectDate = "\(array[0]).\(array[1]).\(array[2])"
                    self.dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                   
                case .week:
                    let string = "\(array[0]).\(array[1]).\(array[2])"
                    let date = SHCalendarManager.share.getFirstDayFromWeek(string)
                    self.selectDate = "\(date[0])-\(date[1])"
                    if IPHONE_WIDTH < 321 {
                        self.dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
                    }
                case .year:
                    self.selectDate = "\(array[0])"
                    self.dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    
                case .month:
                    self.selectDate = "\(array[0]).\(array[1])"
                    self.dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    
//                case .operate:
//                    self.dateBtn.setTitle("\(array[0]).\(array[1]).\(array[2])", for: .normal)
//                    self.dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//
                }
                
                self.currentDate = self.formateSelectDate(self.selectDate)
              
                
                if self.currentDate.count < 1 {
                    return
                }
                
                if let calenderClick = calenderClick {
                    calenderClick(self.currentDate[0],self.currentDate[1])
                }
            }
        }
    }
    
    /// 没有点击选择时的时间显示
    var currentDate =  [String](){
        didSet {
            if currentDate.count > 1 {
                let startdate = currentDate[0].replacingOccurrences(of: ".", with: "")
                let enddate = currentDate[1].replacingOccurrences(of: ".", with: "")
                currentDate[0] = startdate
                currentDate[1] = enddate
            }
        }
    }
    
    var selectDate : String = "" {
        didSet {
            
            switch self.pickMode {
            case .year:
               let date = selectDate + "年"
               self.dateBtn.setTitle(date, for: .normal)
            case .month:
                let array = selectDate.components(separatedBy: ".")
                if array.count > 1 {
                    let date = array[1] + "月"
                    self.dateBtn.setTitle(date, for: .normal)
                }
                
            case .week:
                self.dateBtn.setTitle(selectDate, for: .normal)
                
            case .day:
                self.dateBtn.setTitle(selectDate, for: .normal)
                
            }
            
            self.currentDate = self.formateSelectDate(self.selectDate)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        leftBtn.frame = CGRect.init(x: 5, y: 0, width: 25, height: frame.size.height)
        
        rightBtn.frame = CGRect.init(x: frame.size.width - 30, y: 0, width: 25, height: frame.height)
        
        dateBtn.frame = CGRect.init(x: 35 , y: 0, width: frame.size.width - 60, height: frame.size.height)
        
        self.addSubview(leftBtn)
        self.addSubview(rightBtn)
        self.addSubview(dateBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        configUI()
//    }
//
//    func configUI() {
//
//
//    }
    
    //
    @objc
    fileprivate func btnClick(_ sender : AnyObject ) {
        let btn = sender as? UIButton
        guard let tag =  btn?.tag else { return }
        
    
        switch tag {
        case 970: //中
            touchMode = .center
            SHMultiDateHUB.showPick(self.pickMode) { (date) in
                self.selectDate = date
              
                let array = self.formateSelectDate(self.selectDate)
                if array.count < 1 {
                    return
                }
                
                if let calenderClick = self.calenderClick {
                    let startdate = array[0].replacingOccurrences(of: ".", with: "")
                    let enddate = array[1].replacingOccurrences(of: ".", with: "")
                    calenderClick(startdate,enddate)
                }
            }
            return
        
        case 971://前
            touchMode = .pass
            let yester =  SHCalendarManager.share.getYesterDate(self.selectDate, pickMode: self.pickMode)
            self.selectDate = yester
            
            
        case 972: //后
            touchMode = .next

            let mon =  SHCalendarManager.share.getYesterDate(self.selectDate, pickMode: self.pickMode, isYester: false)
            self.selectDate = mon
          
            
        default:
            break
        }
        
        let array = self.formateSelectDate(self.selectDate)
        if array.count < 1 {
            return
        }
        
        if let calenderClick = calenderClick {
            let startdate = array[0].replacingOccurrences(of: ".", with: "")
            let enddate = array[1].replacingOccurrences(of: ".", with: "")
            calenderClick(startdate,enddate)
        }
        
    }
    

    
    func formateSelectDate(_ date: String) -> [String] {
        var dateArr = [String]()
        
        switch pickMode {
        case .day:
            dateArr.append(date)
            dateArr.append(date)
        case .week:
            let array = date.components(separatedBy: "-")
            dateArr.append(array[0])
            dateArr.append(array[1])
            break
        case .month:
            let date1 = date + ".01"
            dateArr.append(date1)
            let datenum = SHCalendarManager.share.getAllDaysWithCalender(date)
            let date2 = "\(date).\(datenum)"
            dateArr.append(date2)
           
        case .year:
            let date1 = date + ".01.01"
            dateArr.append(date1)
            let date2 = date + ".12.31"
            dateArr.append(date2)
            break
//        case .operate:
//            break
//        case .yesterday:
//            dateArr.append(date)
//            dateArr.append(date)
        }
        
        return dateArr
        
    }

    //MARK: --  layout --
    fileprivate
    lazy var dateBtn : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(kGaryLineColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.tag = 970
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    fileprivate
    lazy var leftBtn : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(kGaryLineColor, for: .normal)
        btn.setImage(UIImage.init(named: "icon-left"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.tag = 971
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate
    lazy var rightBtn : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(kGaryLineColor, for: .normal)
        btn.setImage(UIImage.init(named: "icon-right"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.tag = 972
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    
}
