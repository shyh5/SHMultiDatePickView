//
//  SHTabView.swift
//  Crabs_star
//
//  Created by SHyH5 on 2018/1/16.
//  Copyright © 2018年 com.newlandcomputer.app. All rights reserved.
//

import UIKit

protocol SHTabViewDelegate: NSObjectProtocol {
    
    ///点击代理
    func sh_scrolling(_ view: SHTabView, withIndex: NSInteger)
    
    ///分类代理
   // func sh_scrolling(_ view: SHTabView, withMode:SHTabViewMode)
}

class SHTabView: UIView {
    ///代理回调
    weak var delegate: SHTabViewDelegate?
    
    var btnArr : [UIButton] = {
        let array = Array<Any>()
        return array as! [UIButton]
    }()
    
    var lineView =  UIView()
    var selecteBtn = UIButton()
    
    //MARK: config ---- 相关参数配置 --
    var sh_mainColor : UIColor = kThemColor
    var sh_defaultColor : UIColor = kGaryLineColor
    
     init(frame: CGRect, titleArr: [String]) {
        super.init(frame: frame)
        
        let width = CGFloat(self.bounds.width) / CGFloat(titleArr.count)
        let height = self.bounds.height
        
        for i in 0..<titleArr.count {
            let button = UIButton()
            button.setTitleColor(sh_defaultColor, for: .normal)
            button.tag = i + 100
            button.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            button.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
            button.setTitle(titleArr[i], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.titleLabel?.sizeToFit()
            
            self.btnArr.append(button)
            self.addSubview(button)
            
            if i == 0 {
                let lineview = UIView()
                lineview.bounds = CGRect(x: 0, y: 0, width: 39, height: 2)
                lineview.backgroundColor = sh_mainColor
                lineview.center = CGPoint(x: button.center.x, y: height - 1)
                
                button.setTitleColor(sh_mainColor, for: .normal)
                self.selecteBtn = button
                self.lineView = lineview
                self.addSubview(lineview)
            }
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///按钮点击事件
    @objc
    fileprivate func btnClick(_ sender : AnyObject )  {
        let btn  = sender as! UIButton
       // btn.isEnabled = false
        scrollingIndex(btn.tag - 100)
        self.delegate?.sh_scrolling(self, withIndex: btn.tag - 100)
    }
    
    func scrollingIndex(_ index: NSInteger) {
        let selecBtn = self.btnArr[index]
        self.selecteBtn.setTitleColor(self.sh_defaultColor, for: .normal)
        self.selecteBtn = selecBtn
       
        
        UIView.animate(withDuration: 0.2, animations: {
             self.lineView.center = CGPoint.init(x: self.selecteBtn.center.x, y: self.bounds.height - 1)
        }) { (finish) in
             self.selecteBtn.setTitleColor(self.sh_mainColor, for: .normal)
        }
        

       
    }
    
    

}
