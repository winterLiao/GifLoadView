//
//  LWTGifLoadView.swift
//  GifLoadView
//
//  Created by liaowentao on 17/4/5.
//  Copyright © 2017年 Haochuang. All rights reserved.
//

//加载状态
enum LoadState{
    case loading,finsh,failed,NoData
}

//视图位置
//enum LoadPosition{
//    case top,bottom,center
//}


import UIKit

class LWTGifLoadView: UIView {
    
    public typealias refrshCallBack = () -> Void

//    var position:LoadPosition!//加载的位置
    var stateLabel:UILabel!//加载状态标签
    var refrshButton:UIButton!//重新请求按钮
    var gifView:UIImageView!//加载动图
    var stateImages:[LoadState:AnyObject]!//所有状态对应的图片
    var stateStrings:[LoadState:String]!//所有状态对应的文字
    var refrshCallback:refrshCallBack!//刷新按钮点击事件回调
    
    
    //加载状态
    var state:LoadState?{
        willSet(newValue){
            self.state = newValue
            self.isHidden = false
            self.stateLabel.isHidden = false
            self.refrshButton.isHidden = true
            self.gifView.stopAnimating()
            
            //不同状态显示不一样的视图
            if state == LoadState.loading {
                let array = stateImages[LoadState.loading]
                self.gifView.animationImages = array as! [UIImage]?
                self.gifView.animationDuration = 0.5
                self.gifView.animationRepeatCount = 0
                self.gifView.startAnimating()
                self.stateLabel.text = self.stateStrings[LoadState.loading]
                let image:UIImage = array![0] as! UIImage
                self.gifView.frame.size = image.size
                self.stateLabel.frame.origin.y = gifView.frame.maxY + 5
            }
            else if state == .NoData{
                self.gifView.image = stateImages[LoadState.NoData] as? UIImage
                self.stateLabel.text = self.stateStrings[LoadState.NoData]
                self.gifView.frame.size = self.gifView.image!.size
                self.stateLabel.frame.origin.y = gifView.frame.maxY + 5
            }
            else if state == .finsh{
                self.hide(view: self)
            }
            else if state == .failed{
                self.gifView.image = stateImages[LoadState.failed] as? UIImage
                self.stateLabel.isHidden = true
                self.refrshButton.isHidden = false
                self.gifView.frame.size = self.gifView.image!.size
                self.stateLabel.frame.origin.y = gifView.frame.maxY + 5
                self.stateLabel.text = self.stateStrings[LoadState.failed]
            }
         }
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        self.frame = frame
        self.commonSet()
        self.buildUI()
    }
    
    convenience init(frame:CGRect,callback:@escaping refrshCallBack) {
        self.init(frame:frame)
        self.refrshCallback = callback
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //基础设置
    func commonSet() {
        self.clipsToBounds = true
//        self.position = .center
        
        let imageArray = NSMutableArray.init()
        
        for index in 1...9{
            let name = "icon_hud_\(index)"
            let image = UIImage(named: name)
            imageArray.add(image!)
        }
        
        self.stateImages = [LoadState:AnyObject]()
        self.stateStrings = [LoadState:String]()
        
        self.stateImages[LoadState.loading] = imageArray
        self.stateImages[LoadState.failed] = UIImage(named: "icon_error_coupon")
        self.stateImages[LoadState.NoData] = UIImage(named: "icon_no_record")
        
        self.stateStrings[LoadState.loading] = "加载中...."
        self.stateStrings[LoadState.failed] = "网络不太ok"
        self.stateStrings[LoadState.NoData] = "暂无数据"
    }

    //UI搭建
    func buildUI(){
        self.backgroundColor = UIColor.white
        let image = UIImage(named: "icon_error_coupon")
        gifView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height))
        gifView.contentMode = .scaleAspectFit
        gifView.center.x = self.center.x
        gifView.center.y = self.center.y - 30
        self.addSubview(gifView)
        
        self.stateLabel = UILabel.init(frame: CGRect(x: 0, y: gifView.frame.maxY + 5, width: 200, height:20))
        self.stateLabel.center.x = gifView.center.x
        self.stateLabel.textColor = UIColor.black
        self.stateLabel.font = UIFont.systemFont(ofSize: 16)
        self.stateLabel.textAlignment = .center
        self.addSubview(self.stateLabel)
        
        self.refrshButton = UIButton.init(frame: CGRect(x: 0, y:self.stateLabel.frame.maxY + 5 , width:100, height: 20))
        self.refrshButton.center.x = self.center.x
        self.refrshButton.setTitle("重新请求", for: .normal)
        self.refrshButton.setTitleColor(UIColor.black, for: .normal)
        self.refrshButton.isHidden = true
        self.refrshButton.addTarget(self, action: #selector(refreshed), for:.touchUpInside)
        self.addSubview(self.refrshButton)
        
        state = .loading
    }
    
    //按钮点击回调
    func refreshed(btn:UIButton){
        self.state = .loading
        if  self.refrshCallback != nil {
            self.refrshCallback();
        }
    }
    
    //隐藏视图
    func hide(view : UIView){
        view.isHidden = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
