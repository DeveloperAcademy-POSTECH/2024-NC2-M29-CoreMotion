//
//  MotionManager.swift
//  PullUpper
//
//  Created by hanseoyoung on 6/18/24.
//

import UIKit
import CoreMotion

class PullUpCounter: ObservableObject {
    var headphoneMotionManager = CMHeadphoneMotionManager()

    @Published var accelData = CMAcceleration()
    @Published var pullUpCount = 0.5
    @Published var isHeadPhoneDetected: Bool = false

    var pullUpCountInt: Int {
        return Int(pullUpCount)
    }

    private var integralZ: Double = 0.0
    private var lastAccelZ: Double = 0.0
    private var lastIntegralZ: Double = 0.0
    private var minIntegralZ: Double = 0.0
    private var maxIntegralZ: Double = 0.0
    private var pullUpInProgress = false
    private let threshold: Double = 0.07

    func startUpdates() {
        if headphoneMotionManager.isDeviceMotionAvailable {
            headphoneMotionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard let self = self, let motion = motion, error == nil else { return }

                self.accelData = motion.userAcceleration
                self.processAccelData(motion.userAcceleration)
                if headphoneMotionManager.isDeviceMotionActive {
                    isHeadPhoneDetected = true
                }
            }
        } else {
            stopUpdates()
            print("not available")
        }
    }

    func stopUpdates() {
        headphoneMotionManager.stopDeviceMotionUpdates()
    }

    private func processAccelData(_ acceleration: CMAcceleration) {
        let currentAccelZ = acceleration.z
        let dt = 0.04

        integralZ += ((currentAccelZ + lastAccelZ) * 0.5 * dt)
        lastAccelZ = currentAccelZ

        if integralZ > maxIntegralZ {
            maxIntegralZ = integralZ
        }

        if integralZ < minIntegralZ {
            minIntegralZ = integralZ
        }

        let goingUp = currentAccelZ > 0

        if (maxIntegralZ - minIntegralZ) > threshold {
            if !pullUpInProgress && goingUp {
                pullUpCount += 0.5
                print("Pull-Up Count: \(pullUpCount)")
                pullUpInProgress = true
            } else if pullUpInProgress && !goingUp {
                minIntegralZ = integralZ
                maxIntegralZ = integralZ
                pullUpInProgress = false
            }
        }
        lastIntegralZ = integralZ
    }
}

