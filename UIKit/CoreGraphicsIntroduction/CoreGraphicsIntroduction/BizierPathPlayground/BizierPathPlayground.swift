//
//  BizierPathPlayground.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 13.10.22.
//

import Foundation
import UIKit

class BezierPathPlayground: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let subView = SubView()
        subView.frame = view.frame
        view.addSubview(subView)
    }
}


class SubView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setUpView() {
        let path: UIBezierPath = getPath()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
//        shape.lineWidth = 2
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shape)
    }
    
    func getPath() -> UIBezierPath {
        let curve = Curve.cubic
        
        switch curve {
            
        case .quad:
            ///QUAD CURVE
            let startPoint = CGPoint(x: 10, y: 200)
            let endPoint = CGPoint(x: 290, y: 200)
            let controlPoint = CGPoint(x: 50, y: 50)
            
            let curve = UIBezierPath()
            curve.move(to: startPoint)
            curve.addQuadCurve(to: endPoint, controlPoint: controlPoint)
            curve.lineWidth = 5.0
            UIColor.blue.setStroke()
            curve.stroke()
            
            curve.close()
            
            
            
            
            return curve
            /// CUBIC CURVE
        case .cubic:
            let startPoint = CGPoint(x: 10, y: 400)
            let endPoint = CGPoint(x: 290, y: 400)
            let controlPoint = CGPoint(x: 10, y: 250)
            let controlPoint2 = CGPoint(x: 200, y: 450)
            
            let curve = UIBezierPath()
            curve.move(to: startPoint)
            curve.addCurve(to: endPoint, controlPoint1: controlPoint, controlPoint2: controlPoint2)
            curve.lineWidth = 5.0
            UIColor.blue.setStroke()
            curve.stroke()
            
//            curve.close()
            
            
            
            
            return curve
        }
    }
}


enum Curve {
    case quad, cubic
}
