### gifLoadView
一句话就可以为视图添加加载
``` swift
        let loadView = LWTGifLoadView(frame:self.view.frame, callback:{
            //网络请求
            print("重新请求")
        })
        self.view.addSubview(loadView)
```
加载数据后再做处理,请求完设置
``` swift
//请求失败
loadView.state = .failed

//请求回来没有数据
loadView.state = .NoData

//请求完成，移除加载视图
loadView.state = .finsh
```
