//
//  DrawingView.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 14.10.22.
//

import Foundation
import UIKit

class DrawingView: BezierPathView {
    var points = [CGPoint]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first, shouldUseTouchEventForDrawing(touch) else { return }
        
        let point = touch.location(in: self)
        self.points.removeAll()
        self.points.append(point)
        
        self.drawingLayer.path = currentPath()!.cgPath
//        self.drawingLayer.path = tempPath!.cgPath
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first, shouldUseTouchEvenForDrawing(touch) else { return }
        
        let point = touch.location(in: self)
        self.points.append(point)
        
        if self.points.count == 4 {
            let middlePoint = CGPoint(x: (self.points[1].x + self.points[3].x) / 2.0,
                                      y: (self.points[1].y + self.points[3].y) / 2.0)
            
            
            
            currentPath()?.move(to: self.points[0])
            currentPath()?.addQuadCurve(to: middlePoint, controlPoint: self.points[1])
            
            tempPath = nil
            
            
            // replace points and get ready to handle the next segment
            let lastPoint = self.points[3]
            self.points.removeAll()
//            self.points.removeFirst(3)
            self.points.append(middlePoint)
            self.points.append(lastPoint)
            
            self.drawingLayer.path = currentPath()!.cgPath
            // This is not an optimal refresh algorithm. But it works well for short paths. And it's better than full screen refresh.
            
//            let refreshRect = currentPath()?.bounds.insetBy(dx: -self.lineWidth, dy: -self.lineWidth) ?? self.bounds

            setNeedsDisplay()
        }
//
//        if self.points.count == 2 {
//
//
//            let localPath = UIBezierPath()
//            localPath.move(to: points[0])
//
//            localPath.lineWidth = lineWidth
//            localPath.lineCapStyle = .round
//            localPath.lineJoinStyle = .round
//
//            tempPath = localPath
//            tempPath?.stroke()
//            tempPath?.addLine(to: points[1])
//            self.points.append(point)
//            self.drawingLayer.path = tempPath!.cgPath
//
//            setNeedsDisplay()
//        } else if self.points.count == 3 {
//
//
//            let localPath = UIBezierPath()
//            localPath.move(to: points[0])
//
//            localPath.lineWidth = lineWidth
//            localPath.lineCapStyle = .round
//            localPath.lineJoinStyle = .round
//
//            tempPath = localPath
//            tempPath?.stroke()
//            tempPath?.addQuadCurve(to: points[2], controlPoint: points[1])
//            self.points.append(point)
//            self.drawingLayer.path = tempPath!.cgPath
//
//            setNeedsDisplay()
//        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first, shouldUseTouchEvenForDrawing(touch) else { return }
        
        // Draw remaining points
//        if self.points.count == 1 {
//            // only one point acquired = user tapped on the screen
//            // draw "point"
//            currentPath()?.lineWidth = self.lineWidth / 2.0
//            currentPath()?.addArc(withCenter: self.points[0],
//                                  radius: lineWidth / 4.0,
//                                  startAngle: 0,
//                                  endAngle: .pi * 2.0,
//                                  clockwise: true)
//            
//            setNeedsDisplay(CGRect(x: self.points[0].x - self.lineWidth,
//                                   y: self.points[0].y - self.lineWidth,
//                                   width: self.lineWidth * 2.0,
//                                   height: self.lineWidth * 2.0))
//            
//        } else if self.points.count == 2 {
//            currentPath()?.move(to: self.points[0])
//            currentPath()?.addLine(to: self.points[1])
//            
//            setNeedsDisplay(
//                CGRect(p1: self.points[0],
//                       p2: self.points[1])
//                .insetBy(dx: -self.lineWidth,
//                         dy: -self.lineWidth))
//            
//            
//        } else if self.points.count == 3 {
//            currentPath()?.move(to: self.points[0])
//            currentPath()?
//                .addQuadCurve(to: self.points[2],
//                              controlPoint: self.points[1])
//            
//            setNeedsDisplay(
//                CGRect(p1: self.points[0],
//                       p2: self.points[2])
//                .insetBy(dx: -self.lineWidth,
//                         dy: -self.lineWidth))
//            
//            
//        }
        
        self.points.removeAll()
        
//        self.drawingLayer.path = tempPath!.cgPath
        
        if let backgroundPath = self.backgroundLayer.path {
            currentPath()?.append(UIBezierPath(cgPath: backgroundPath))
        }
        
        currentPath()?.removeAllPoints()
        
        self.drawingLayer.path = currentPath()!.cgPath
        
        super.touchesEnded(touches, with: event)
    }
    
    func shouldUseTouchEventForDrawing(_ touche: UITouch) -> Bool {
        return true
    }
}
