//
//  SHMultiBasicDatePickView.swift
//  SHMultiDatePickView
//
//  Created by SHyH5 on 2018/2/8.
//  Copyright © 2018年 SHyH5. All rights reserved.
//

import UIKit


/// -- mode --
//public enum PickMode : Int {
//    case day = 0, yesterday, week, month, year, operate
//}

public enum PickMode : Int {
    case day = 0, week, month, year
}


typealias SBPBtnClick = (_ date : String) -> ()
class SHMultiBasicDatePickView: UIView {
    
    var sh_basicClick : SBPBtnClick?
    var selectDate : String = ""

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    func configUI() {
        self.addSubview(leftBtn)
        self.addSubview(rightBtn)
        self.addSubview(pickview)
    }
    
    //
    @objc
    fileprivate func btnClick(_ sender : AnyObject ) {
        let btn = sender as! UIButton
        if btn.tag == 871 { //点击取消
            selectDate = ""
        }
        
        sh_basicClick!(selectDate)
        
    }
    
    //MARK: --  layout --
    fileprivate
    lazy var leftBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.frame = CGRect.init(x: 15, y: 10, width: 100, height: 21)
        btn.contentHorizontalAlignment = .left
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.colorWithHexString("#0B88FF"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.tag = 871
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    fileprivate
    lazy var rightBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("确认", for: .normal)
        btn.frame = CGRect.init(x: IPHONE_WIDTH - 15 - 100, y: 10, width: 100, height: 21)
        btn.contentHorizontalAlignment = .right
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.colorWithHexString("#0B88FF"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.tag = 872
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var pickview : UIView = {
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 41, width: IPHONE_WIDTH, height: self.frame.size.height - 41)
        view.backgroundColor = kGaryBackColor
        return view
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


   

}
