//
//  ViewController.swift
//  GifLoadView
//
//  Created by liaowentao on 17/4/5.
//  Copyright © 2017年 Haochuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadView = LWTGifLoadView(frame:self.view.frame, callback:{
            print("重新请求")
        })
        self.view.addSubview(loadView)
        
        //请求失败
        _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (Timer) in
            loadView.state = .failed
        }
        
        //请求回来没有数据
        _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (Timer) in
            loadView.state = .NoData
        }
        
        //请求完成，移除加载视图
        _ = Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { (Timer) in
            loadView.state = .finsh
        }


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

