//
//  HapticsManager.swift
//  ContinuityTransition
//
//  Created by Victor on 23/03/2024.
//

import Foundation
import UIKit
import SwiftUI


class HapticManager: ObservableObject {
    static let instance = HapticManager() //This is a singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
        
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

