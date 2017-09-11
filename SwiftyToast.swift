//
//  SwiftyToast.swift
//  E-Electrician_Swift
//
//  Created by 许鹏 on 2017/9/11.
//  Copyright © 2017年 FP. All rights reserved.
//

import UIKit

class SwiftyToast: NSObject {
    //显示位置
    enum Position: Int {
        case top
        case center
        case bottom
    }
    
    func showToast(text: String, pos: Position = .center, delay: TimeInterval = 2.0) {
        let container = UIView()
        container.backgroundColor = UIColor.clear
        let lableView = UILabel()
        lableView.font = UIFont.init(name: fontName, size: 15)
        lableView.textColor = UIColor.white
        lableView.text = text
        lableView.numberOfLines = 0
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.8)
        bgView.layer.cornerRadius = 10
        container.addSubview(bgView)
        container.addSubview(lableView)  //添加lableView
        
        let viewController = UIViewController.currentViewController()
        viewController?.view.addSubview(container)
        
        container.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        switch pos {
        case .bottom:
            lableView.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.width.lessThanOrEqualTo(280)
                make.bottom.equalToSuperview().offset(-30)
            })
            
            bgView.snp.makeConstraints({ (make) in
                make.left.top.equalTo(lableView).offset(-10)
                make.right.bottom.equalTo(lableView).offset(10)
            })
        case .center:
            lableView.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
                make.width.lessThanOrEqualTo(200)
            })
            
            bgView.snp.makeConstraints({ (make) in
                make.left.top.equalTo(lableView).offset(-10)
                make.right.bottom.equalTo(lableView).offset(10)
            })
        case .top:
            lableView.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.width.lessThanOrEqualTo(280)
                make.top.equalToSuperview().offset(30)
            })
            
            bgView.snp.makeConstraints({ (make) in
                make.left.top.equalTo(lableView).offset(-10)
                make.right.bottom.equalTo(lableView).offset(10)
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            container.removeFromSuperview()
        }
    }

}

extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
