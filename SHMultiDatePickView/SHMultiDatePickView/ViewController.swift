//
//  ViewController.swift
//  SHMultiDatePickView
//
//  Created by SHyH5 on 2018/2/8.
//  Copyright © 2018年 SHyH5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let titleA : [String] = ["日","周","月","年"]
    var pickMode : PickMode = .day
    
    // MARK: - --
    fileprivate
    lazy var tabview : SHTabView = {
        let tab = SHTabView.init(frame: CGRect.init(x: 0, y: 64, width: IPHONE_WIDTH, height: 44), titleArr: self.titleA)
        tab.delegate = self
        tab.backgroundColor = UIColor.white
        return tab
    }()
    
    fileprivate
    lazy var calenderV : SHCalendarView = {
        let v = SHCalendarView.init(frame: CGRect.init(x: 0.2 * IPHONE_WIDTH, y: 0, width: 0.6 * IPHONE_WIDTH, height: 40))
        v.pickMode = .day
        v.backgroundColor = UIColor.yellow
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tabview)
        
        let headview = UIView()
        headview.frame = CGRect.init(x: 0, y: 118, width: IPHONE_WIDTH, height: 40)
        view.addSubview(headview)
        headview.addSubview(calenderV)
        
    
        let button = UIButton()
        button.frame = CGRect.init(x: (IPHONE_WIDTH - 200) * 0.5, y: 250, width: 200, height: 45)
        button.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor.blue
        button.setTitle("点击选择", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        
        view.addSubview(button)
        
    }
    
    ///按钮点击事件
    @objc
    fileprivate func btnClick(_ sender : AnyObject )  {
        let conten = ["春季","夏季","秋季","冬季"]
        let btn = sender as! UIButton
        SHMultiDateHUB.showContent(conten) { (date) in
            btn.setTitle(date, for: .normal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension ViewController : SHTabViewDelegate {
    func sh_scrolling(_ view: SHTabView, withIndex: NSInteger) {
        pickMode = PickMode(rawValue: withIndex)!
        calenderV.pickMode = pickMode
    }
}


