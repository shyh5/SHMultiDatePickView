# SHMultiDatePickView
一个年月日的时间选择器


![gifdate.gif](http://upload-images.jianshu.io/upload_images/667152-0a9d68a6283fe967.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

一行代码调用时间选择器
如果需要上面的前后选择日历的控件只需要初始化一个SHCalendarView 即可，加载到父视图上。

![carbon (1).png](http://upload-images.jianshu.io/upload_images/667152-d024f1a4393d933d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
    fileprivate
    lazy var calenderV : SHCalendarView = {
        let v = SHCalendarView.init(frame: CGRect.init(x: 0.2 * IPHONE_WIDTH, y: 0, width: 0.6 * IPHONE_WIDTH, height: 40))
        v.pickMode = .day
        v.backgroundColor = UIColor.yellow
        return v
    }()
    
     override func viewDidLoad() {
         view.addSubview(calenderV)
     }
 ```   
 
 使用时间选择器的话，只需要设置一下枚举型即可：
 ![carbon.png](http://upload-images.jianshu.io/upload_images/667152-54015d7275d844cf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 
 ```
 public enum PickMode : Int {
    case day = 0, week, month, year
}


 SHMultiDateHUB.showPick(.week) { (date) in
               
 }
 ```
