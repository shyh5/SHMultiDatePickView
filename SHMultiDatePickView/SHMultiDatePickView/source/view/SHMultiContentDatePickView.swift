//
//  SHMultiContentDatePickView.swift
//  SHMultiDatePickView
//
//  Created by SHyH5 on 2018/2/8.
//  Copyright © 2018年 SHyH5. All rights reserved.
//

import UIKit

class SHMultiContentDatePickView: SHMultiBasicDatePickView {
    
    var dataA: [String] = [] {
        didSet {
            selectDate = dataA[0]
            opePickView.reloadAllComponents()
        }
    }
    
    override func configUI() {
        super.configUI()
        
        pickview.addSubview(opePickView)
        
        
    }
    
    //MARK: --  layout --
    fileprivate
    lazy var opePickView : UIPickerView = {
        let pic = UIPickerView()
        pic.backgroundColor = kGaryBackColor
        pic.frame = CGRect.init(x: 0, y: 0, width: self.pickview.frame.size.width, height: self.pickview.frame.size.height)
        pic.delegate = self
        pic.dataSource = self
        return pic
    }()
    
}

extension SHMultiContentDatePickView : UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK : -- data source --
    //多少列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    //多少行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataA.count
        
    }
    
    //MARK : -- delegate --
    //设置标题
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataA[row]
        
    }
    
    //选择的行数
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectDate = dataA[row]
        
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
