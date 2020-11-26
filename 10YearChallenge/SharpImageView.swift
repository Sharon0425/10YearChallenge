//
//  SharpImageView.swift
//  10YearChallenge
//
//  Created by Sharon on 2020/11/25.
//

import UIKit

class SharpImageView: UIImageView {

    override func layoutSubviews() {
       super.layoutSubviews()
       let path = UIBezierPath()
       path.move(to: CGPoint.zero)
       path.addLine(to: CGPoint(x: bounds.width, y: 0))
       path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
       path.addLine(to: CGPoint(x: 0, y: bounds.height * 0.9))
       path.close()
       let shapeLayer = CAShapeLayer()
       shapeLayer.path = path.cgPath
       layer.mask = shapeLayer
    }
}
