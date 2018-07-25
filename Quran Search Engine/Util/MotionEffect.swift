//
//  MotionEffect.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 25.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func moveViaMotionEffect() {
        let min = CGFloat(-30)
        let max = CGFloat(30)
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        
        self.addMotionEffect(motionEffectGroup)
    }
    
}
