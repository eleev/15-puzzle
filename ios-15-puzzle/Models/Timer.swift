//
//  Timer.swift
//  ios-15-puzzle
//
//  Created by Astemir Eleev on 16/02/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

class Timer {
    
    // MARK: - Typealiases
    
    typealias FeedbackClosure = (_ hours: Int, _ minutes: Int, _ seconds: Int) -> Void
    
    // MARK: - Properties
    
    private var timer: Foundation.Timer?
    private var timeInterval: TimeInterval
    private var seconds: TimeInterval = 0
    private var closure: FeedbackClosure = { _, _, _ in }
    
    // MARK: - Initializers
    
    init(timeInterval: TimeInterval = 1.0) {
        self.timeInterval = timeInterval
    }
    
    // MARK: - Methods
    
    func start(closure: @escaping FeedbackClosure) {
        self.closure = closure
        timer = Foundation.Timer.scheduledTimer(timeInterval: timeInterval,
                                                target: self,
                                                selector: (#selector(Timer.update)),
                                                userInfo: nil,
                                                repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        closure(0, 0, 0)
        seconds = 0
    }
    
    // MARK: - Private methods
    
    @objc private func update() {
        let hours = Int(self.seconds) / 3600
        let minutes = Int(self.seconds) / 60 % 60
        let seconds = Int(self.seconds) % 60
        
        closure(hours, minutes, seconds)
        self.seconds += timeInterval
    }
}
