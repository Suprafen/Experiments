//
//  ViewController.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 10.10.22.
//

import UIKit
//import Darwin

class Canvas: UIView {
    override func draw(_ rect: CGRect) {
        // custom drawing
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(5)
        context.setBlendMode(.destinationAtop)
        context.setLineCap(.round)
        context.setShouldAntialias(true)
        context.setAllowsAntialiasing(true)
        context.setFlatness(100)
        context.setLineJoin(.round)
//        let startPoint = CGPoint(x: 100, y: 200)
//        let endPoint = CGPoint(x: 200, y: 500)
        
        lines.forEach { line in
            for (i,p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }

        context.strokePath()
    }
    
    var lines = [[CGPoint]]()
    var line = [CGPoint]()
    
    // Track the finger...
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currentPoint = touches.first?.location(in: nil) else { return }
//        print(currentPoint)
        
        guard var lastLine = lines.popLast() else { return }
        
        guard let currentLineLastPoint = lastLine.last else {
            lastLine.append(currentPoint)
            
            lines.append(lastLine)
            return
        }

//        var maxY = max(currentPoint.y, currentLineLastPoint.y)
//        var maxX = max(currentPoint.x, currentLineLastPoint.x)
//
//        var minY = min(currentPoint.y, currentLineLastPoint.y)
//        var minX = min(currentPoint.x, currentLineLastPoint.x)
//
//        for x in stride(from: minX, to: maxX, by: 1) {
//            var tempPoint = CGPoint(x: x, y: 0)
//            for y in stride(from: minY, to: maxY, by: 1) {
//                tempPoint.y = y
//
//                lastLine.append(tempPoint)
//            }
//        }
//
        let path: UIBezierPath = UIBezierPath()
        
        path.move(to: currentPoint)
//
        path.addQuadCurve(to: currentLineLastPoint, controlPoint: currentPoint)
        
        lastLine.append(currentPoint)
        
        
//        print("CurrentPoint: \(currentPoint); LastPoint: \(currentLineLastPoint)")
        lines.append(lastLine)
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 2.0
        shape.strokeColor = UIColor.black.cgColor
        
        self.layer.addSublayer(shape)
        setNeedsDisplay()
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        <#code#>
//    }
}

class ViewController: UIViewController {
    
    let canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.backgroundColor = .white
        canvas.frame = view.frame
    }
}



//class ViewController: UIViewController
//{
//    let stackView = UIStackView()
//
//    let hermiteScribbleView = HermiteScribbleView(title: "Hermite")
//    let simpleScribbleView = SimpleScribbleView(title: "Simple")
//
//    var touchOrigin: ScribbleView?
//
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//
//        view.addSubview(stackView)
//
//        stackView.addArrangedSubview(hermiteScribbleView)
//        stackView.addArrangedSubview(simpleScribbleView)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//        guard let
//                location = touches.first?.location(in: self.view) else
//        {
//            return
//        }
//
//        if(hermiteScribbleView.frame.contains(location))
//        {
//            touchOrigin = hermiteScribbleView
//        }
//        else if (simpleScribbleView.frame.contains(location))
//        {
//            touchOrigin = simpleScribbleView
//        }
//        else
//        {
//            touchOrigin = nil
//            return
//        }
//
//    if let adjustedLocationInView = touches.first?.location(in: touchOrigin)
//        {
//    hermiteScribbleView.beginScribble(point: adjustedLocationInView)
//    simpleScribbleView.beginScribble(point: adjustedLocationInView)
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//        guard let touch = touches.first,
//              let coalescedTouches = event?.coalescedTouches(for: touch),
//              let touchOrigin = touchOrigin else { return }
//
//        coalescedTouches.forEach
//            {
//            hermiteScribbleView.appendScribble(point: $0.location(in: touchOrigin))
//            simpleScribbleView.appendScribble(point: $0.location(in: touchOrigin))
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//        hermiteScribbleView.endScribble()
//        simpleScribbleView.endScribble()
//    }
//
//    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
//    {
//    if motion == UIEvent.EventSubtype.motionShake
//        {
//            hermiteScribbleView.clearScribble()
//            simpleScribbleView.clearScribble()
//        }
//    }
//
//    override func viewDidLayoutSubviews() {
//        stackView.frame = CGRect(x: 0,
//            y: topLayoutGuide.length,
//            width: view.frame.width,
//            height: view.frame.height - topLayoutGuide.length).insetBy(dx: 10, dy: 10)
//
//        stackView.axis = view.frame.width > view.frame.height
//    ? NSLayoutConstraint.Axis.horizontal
//    : NSLayoutConstraint.Axis.vertical
//
//        stackView.spacing = 10
//
//    stackView.distribution = UIStackView.Distribution.fillEqually
//    }
//}
//
