//
//  SHMultiDateHUB.swift
//  SHMultiDatePickView
//
//  Created by SHyH5 on 2018/2/8.
//  Copyright © 2018年 SHyH5. All rights reserved.
//

import Foundation
import UIKit


typealias CarbsBtnClick = (_ tag: Int) -> ()
typealias PickClick = (_ selDate: String) -> ()

public class  SHMultiDateHUB {

    /// 时间选择器  -- 年月 | 年 | 年月周 --
    @discardableResult
    public class func showPick(_ pickMode: PickMode, result : @escaping (_ selDate : String) -> Void) -> UIWindow? {
        if let _ = UIApplication.shared.delegate?.window {
            return SHMultiDateView.showPickView(pickMode, result: { (seldate) in
                result(seldate)
            })
        }
        return nil
    }
    
    
    /// 文字显示
    @discardableResult
    public class func showContent(_ content: [String], result : @escaping (_ selDate : String) -> Void) -> UIWindow? {
        if let _ = UIApplication.shared.delegate?.window {
            return SHMultiDateView.showContent(content, result: { (seldate) in
                result(seldate)
            })
        }
        return nil
    }
    
}

class SHMultiDateView {
    
    static var sh_backgrandColor : UIColor = UIColor.colorWithHexString("#000000", alpha: 0.29)
    static var windows = Array<UIWindow!>()
    static let vc = UIApplication.shared.delegate?.window??.subviews.first as UIView!
    
    // ****************************************************************************
    
    //MARK :  时间选择器  -- 年月 | 年 | 年月周 --
    @discardableResult
    static fileprivate func showPickView(_ pickMode: PickMode, result: @escaping PickClick) -> UIWindow {
        let window = UIWindow()
        window.windowLevel = UIWindowLevelAlert
        window.backgroundColor = sh_backgrandColor
        window.rootViewController = UIViewController()
        window.frame = UIScreen.main.bounds
        window.isHidden = false
        
        
        //        /// add tapGesture
        //        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapHideGesture(gesture:)))
        //        tapGesture.numberOfTapsRequired = 1
        //        window.addGestureRecognizer(tapGesture)
        
        switch pickMode {

        case .day:
            let mainview = SHMultiSystemDatePickView.init(frame: CGRect.init(x: 0, y: IPHONE_HEIGHT - 250, width: IPHONE_WIDTH, height: 250) )
            mainview.backgroundColor = UIColor.white
            mainview.pick = .day
            window.addSubview(mainview)
            
            mainview.sh_basicClick =  { selDate in
                clear()
                if (selDate as NSString).length > 0 {
                    result(selDate)
                }
            }
            
            windows.append(window)
        
        case .month,.week,.year:
            let mainview = SHMultiCustomDatePickView.init(frame: CGRect.init(x: 0, y: IPHONE_HEIGHT - 250, width: IPHONE_WIDTH, height: 250))
            mainview.pickMode = pickMode
            mainview.backgroundColor = UIColor.white
            mainview.sh_basicClick =  { selDate in
                clear()
                
                if (selDate as NSString).length > 0 {
                    result(selDate)
                }
                
            }
            window.addSubview(mainview)
            windows.append(window)
            
            
        }
        return window
    }
    
    @discardableResult
    static fileprivate func showContent(_ content : [String], result: @escaping PickClick) -> UIWindow {
        let window = UIWindow()
        window.windowLevel = UIWindowLevelAlert
        window.backgroundColor = sh_backgrandColor
        window.rootViewController = UIViewController()
        window.frame = UIScreen.main.bounds
        window.isHidden = false
        
        // SHCustomDatePick
        let mainview = SHMultiContentDatePickView.init(frame: CGRect.init(x: 0, y: IPHONE_HEIGHT - 250, width: IPHONE_WIDTH, height: 250))
        mainview.backgroundColor = UIColor.white
        mainview.dataA = content
        mainview.sh_basicClick =  { selDate in
            clear()
            if (selDate as NSString).length > 0  {
                result(selDate)
            }
            
        }
        
        window.addSubview(mainview)
        windows.append(window)
        
    
        return window
    }
    
    
    /// tap Hide HUD
    @objc
    static func tapHideGesture(gesture: UITapGestureRecognizer) {
        clear()
    }
    
    static func clear() {
        windows.removeAll()
    }
}

