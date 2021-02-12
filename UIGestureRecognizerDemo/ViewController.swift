//
//  ViewController.swift
//  UIGestureRecognizerDemo
//
//  Created by Trista on 2021/2/12.
//

import UIKit

class ViewController: UIViewController {

    //建立三個屬性
    var fullSize :CGSize!
    var myUIView :UIView!
    var anotherUIView :UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //取得螢幕的尺寸
        fullSize = UIScreen.main.bounds.size
        
        
        //雙指輕點 (雙指以上手勢只能用實機測試)
        let doubleFingers =
          UITapGestureRecognizer(
            target:self,
            action:#selector(ViewController.doubleTap))

        //點幾下才觸發 設置 1 時 則是點一下會觸發 依此類推
        doubleFingers.numberOfTapsRequired = 1

        //幾根指頭觸發
        doubleFingers.numberOfTouchesRequired = 2

        //為視圖加入監聽手勢
        self.view.addGestureRecognizer(doubleFingers)


        //單指輕點
        let singleFinger = UITapGestureRecognizer(
          target:self,
          action:#selector(ViewController.singleTap))

        //點幾下才觸發 設置 2 時 則是要點兩下才會觸發 依此類推
        singleFinger.numberOfTapsRequired = 2

        //幾根指頭觸發
        singleFinger.numberOfTouchesRequired = 1

        //雙指輕點沒有觸發時 才會檢測此手勢 以免手勢被蓋過
        singleFinger.require(toFail: doubleFingers)

        //為視圖加入監聽手勢
        self.view.addGestureRecognizer(singleFinger)
        
        
        //長按
        let longPress = UILongPressGestureRecognizer(
          target: self,
          action: #selector(ViewController.longPress))

        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(longPress)
        
        
        //上、左、下、右每個方向滑動都是獨立的手勢
        //先加一個可供移動的 UIView
        myUIView = UIView(frame: CGRect(
                            x: fullSize.width*0.3,
                            y: fullSize.height*0.3,
                            width: 100, height: 100))
        myUIView.backgroundColor = UIColor.systemGreen
        self.view.addSubview(myUIView)

        //向上滑動
        let swipeUp = UISwipeGestureRecognizer(
          target:self,
          action:#selector(ViewController.swipe))
        swipeUp.direction = .up

        //幾根指頭觸發 預設為 1
        swipeUp.numberOfTouchesRequired = 1

        //為視圖加入監聽手勢
        //手勢是加在self.view上，所以整個畫面上都可以滑動，而不是只點擊myUIView滑動
        self.view.addGestureRecognizer(swipeUp)


        //向左滑動
        let swipeLeft = UISwipeGestureRecognizer(
          target:self,
          action:#selector(ViewController.swipe))
        swipeLeft.direction = .left

        //為視圖加入監聽手勢
        //手勢是加在self.view上，所以整個畫面上都可以滑動，而不是只點擊myUIView滑動
        self.view.addGestureRecognizer(swipeLeft)


        //向下滑動
        let swipeDown = UISwipeGestureRecognizer(
          target:self,
          action:#selector(ViewController.swipe))
        swipeDown.direction = .down

        //為視圖加入監聽手勢
        //手勢是加在self.view上，所以整個畫面上都可以滑動，而不是只點擊myUIView滑動
        self.view.addGestureRecognizer(swipeDown)


        //向右滑動
        let swipeRight = UISwipeGestureRecognizer(
          target:self,
          action:#selector(ViewController.swipe))
        swipeRight.direction = .right

        //為視圖加入監聽手勢
        //手勢是加在self.view上，所以整個畫面上都可以滑動，而不是只點擊myUIView滑動
        self.view.addGestureRecognizer(swipeRight)
        
        
        //先加一個可供移動的 UIView
        anotherUIView = UIView(frame: CGRect(
                                x: fullSize.width * 0.5,
                                y: fullSize.height * 0.5,
                                width: 100, height: 100))
        anotherUIView.backgroundColor = UIColor.orange
        
        self.view.addSubview(anotherUIView)

        //拖曳手勢
        let pan = UIPanGestureRecognizer(
            target:self,
            action:#selector(ViewController.pan))

        //最少可以用幾指拖曳
        pan.minimumNumberOfTouches = 1

        //最多可以用幾指拖曳
        pan.maximumNumberOfTouches = 1

        //為這個可移動的 UIView 加上監聽手勢
        //手勢是加在anotherUIView 非self.view上，所以只能拖曳anotherUIView, 整個畫面不可拖曳
        anotherUIView.addGestureRecognizer(pan)
        
    }

    
    //觸發手勢後執行動作的方法
    //觸發雙指輕點一下手勢後執行的動作
    @objc func doubleTap(recognizer:UITapGestureRecognizer){
        print("雙指點一下時觸發")

        //取得每指的位置
        self.findFingersPositon(recognizer: recognizer)
    }
    
    //觸發單指輕點兩下手勢後 執行的動作
    @objc func singleTap(recognizer:UITapGestureRecognizer){
        print("單指連點兩下時觸發")

        //取得每指的位置
        self.findFingersPositon(recognizer: recognizer)
    }

    func findFingersPositon(recognizer:UITapGestureRecognizer) {
        //取得每指的位置
        let number = recognizer.numberOfTouches
        for i in 0..<number {
            //每指輕點時的位置(是一個點 CGPoint )
            let point = recognizer.location(
                ofTouch: i, in: recognizer.view)
            print(
                "第 \(i + 1) 指的位置：\(NSCoder.string(for: point))")
        }
    }
    
    
    //觸發長按手勢後執行的動作
    @objc func longPress(recognizer:UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            print("長按開始")
        } else if recognizer.state == .ended {
            print("長按結束")
        }

    }
    
    
    //觸發滑動手勢後執行的動作
    @objc func swipe(recognizer:UISwipeGestureRecognizer) {
        let point = myUIView.center

        //觸發四個方向滑動的手勢寫在同一個方法裡，用屬性direction來辨別是哪一個方向
        if recognizer.direction == .up {
            print("Go Up")
            
            //判斷是否會超出畫面，如果超出時就會改成移動到邊界，而不會真的超出去
            if point.y >= 150 {
                myUIView.center = CGPoint(
                  x: myUIView.center.x,
                  y: myUIView.center.y - 100)
            }
            else {
                myUIView.center = CGPoint(
                  x: myUIView.center.x, y: 50)
            }
        }
        else if recognizer.direction == .left {
            print("Go Left")
            
            //判斷是否會超出畫面，如果超出時就會改成移動到邊界，而不會真的超出去
            if point.x >= 150 {
                myUIView.center = CGPoint(
                  x: myUIView.center.x - 100,
                  y: myUIView.center.y)
            }
            else {
                myUIView.center = CGPoint(
                  x: 50, y: myUIView.center.y)
            }
        }
        else if recognizer.direction == .down {
            print("Go Down")
            
            //判斷是否會超出畫面，如果超出時就會改成移動到邊界，而不會真的超出去
            if point.y <= fullSize.height - 150 {
                myUIView.center = CGPoint(
                  x: myUIView.center.x,
                  y: myUIView.center.y + 100)
            }
            else {
                myUIView.center = CGPoint(
                  x: myUIView.center.x,
                  y: fullSize.height - 50)
            }
        }
        else if recognizer.direction == .right {
            print("Go Right")
            
            //判斷是否會超出畫面，如果超出時就會改成移動到邊界，而不會真的超出去
            if point.x <= fullSize.width - 150 {
                myUIView.center = CGPoint(
                  x: myUIView.center.x + 100,
                  y: myUIView.center.y)
            }
            else {
                myUIView.center = CGPoint(
                  x: fullSize.width - 50,
                  y: myUIView.center.y)
            }
        }
    }
    
    
    //觸發拖曳手勢後執行的動作
    @objc func pan(recognizer:UIPanGestureRecognizer) {
        //設置 UIView 新的位置
        let point = recognizer.location(in: self.view)
        anotherUIView.center = point
    }

}

