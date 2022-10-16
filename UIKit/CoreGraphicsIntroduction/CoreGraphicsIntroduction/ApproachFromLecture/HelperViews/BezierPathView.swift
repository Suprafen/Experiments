//
//  BezierPathView.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 14.10.22.
//

import Foundation
import UIKit

class BezierPathView: UIView {
    
    let backgroundLayer = CAShapeLayer()
    let drawingLayer = CAShapeLayer()
    
    var currentPathIndex = -1
    var isPredictedTouches = false
    var isShowDrawRect = false
    var isStrokeTexture = false
    var linePattern: [CGFloat]?
    var lineWidth = CGFloat(2.0)
    var paths = [UIBezierPath]()
    
    var tempPath: UIBezierPath?
    
    var predictedPath: UIBezierPath? {
        didSet {
            let lineWidth = currentPath()?.lineWidth ?? self.lineWidth
            // Clear previous path area
            if oldValue != nil {
                setNeedsDisplay(oldValue!.bounds.insetBy(dx: -lineWidth, dy: -lineWidth))
            }
            // Update new path area
            if predictedPath != nil {
                setNeedsDisplay(predictedPath!.bounds.insetBy(dx: -lineWidth, dy: -lineWidth))
            }
        }
    }
    
    var userLineWidth = CGFloat(10.0)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.white
        self.isMultipleTouchEnabled = false
        
        backgroundLayer.strokeColor = UIColor.gray.cgColor
            backgroundLayer.fillColor = nil
            backgroundLayer.lineWidth = 10
        backgroundLayer.lineCap = .round
            drawingLayer.strokeColor = UIColor.black.cgColor
            drawingLayer.fillColor = nil
            drawingLayer.lineWidth = 10
        drawingLayer.lineCap = .round
            layer.addSublayer(backgroundLayer)
            layer.addSublayer(drawingLayer)
        
        layer.masksToBounds = true
    }
    
    //MARK: - Path management
    
    // MARK: Get current path
    func currentPath() -> UIBezierPath? {
        if self.currentPathIndex >= 0 && self.currentPathIndex < self.paths.count {
            return self.paths[self.currentPathIndex]
        } else {
            return nil
        }
    }
    // MARK: Add new path
    func newPath() -> UIBezierPath? {
        let path = UIBezierPath()
        path.lineWidth = self.lineWidth
        
        self.paths.append(path)
        
        self.currentPathIndex += 1
        
        return path
    }
    
    func addPath(_ path: UIBezierPath) {
        self.paths.append(path)
        self.currentPathIndex += 1
    }
    
    func removeAllPaths() {
        // Remove all paths
        self.paths.removeAll()
        self.currentPathIndex = -1
        
        setNeedsLayout()
    }
    
    func removeLastPath() {
        if self.paths.count > 0 {
            // Get the rect of the last path
            var refreshRect = self.bounds
            if let lastPath = self.paths.last {
                // Add lineWidth to the rect to include edges of the path
                refreshRect = lastPath.bounds.insetBy(dx: -self.lineWidth, dy: -self.lineWidth)
            }
            // Remove the path
            self.paths.removeLast()
            self.currentPathIndex -= 1
            
            // Refresh the rect of the screen where the last path was
            setNeedsDisplay(refreshRect)
        }
    }
    
    
    // MARK: - Drawing
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first, shouldUseTouchEvenForDrawing(touch) else { return }
        
        let point = touch.location(in: self)
        
        self.lineWidth = self.userLineWidth
        
        self.newPath()?.move(to: point)
        
        self.currentPath()?.lineWidth = self.lineWidth
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first, shouldUseTouchEvenForDrawing(touch) else { return }
        
        self.lineWidth = self.userLineWidth
        
        self.currentPath()?.lineWidth = self.lineWidth
        
        self.predictedPath = nil
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        // Discard any predicted path when touches have ended.
        self.predictedPath = nil
    }
    
    func shouldUseTouchEvenForDrawing(_ touch: UITouch) -> Bool {
        return true
    }
    
    override func draw(_ rect: CGRect) {
//         Show the rect that is being drawn
//        if self.isShowDrawRect {
//            if let context = UIGraphicsGetCurrentContext() {
//                context.setStrokeColor(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor)
//                context.stroke(rect)
//            }
//        }
        
//         MARK: TEXTURE
//        if self.isStrokeTexture {
//            self.texture.setStroke()
//        } else {
//            #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).setStroke()
//        }
//
        for path in self.paths {
            path.lineCapStyle = .round

            if let linePattern = self.linePattern {
                path.setLineDash(linePattern, count: linePattern.count, phase: 0.0)
            }
            path.stroke()
        }
      
//         Draw predicted path
//        if let predictedPath = self.predictedPath {
//            #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).setStroke()
//            predictedPath.lineCapStyle = .round
//            predictedPath.stroke()
//        }
    }
}
