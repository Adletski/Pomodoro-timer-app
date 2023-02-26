//
//  ViewController.swift
//  Pomodoro timer app
//
//  Created by Adlet Zhantassov on 26.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    let foregroundProgressLayer = CAShapeLayer()
    let backgroundProgressLayer = CAShapeLayer()
    let animationOfProgressLayer = CABasicAnimation(keyPath: "strokeEnd")
    
    var timer = Timer()
    var isTimerStarted = false
    var isAnimationStarted = false
    var time = 25
    
    private lazy var workModeButton: UIButton = {
        let workModeButton = UIButton()
        workModeButton.setTitle("Work mode", for: .normal)
        workModeButton.setTitleColor(.black, for: .normal)
        workModeButton.layer.borderWidth = 1
        workModeButton.layer.cornerRadius = 10
        workModeButton.backgroundColor = .gray
        workModeButton.layer.borderColor = CGColor(red: 127, green: 0, blue: 255, alpha: 1.0)
        workModeButton.addTarget(self, action: #selector(workModeButtonTapped), for: .touchUpInside)
        return workModeButton
    }()
    private lazy var restModeButton: UIButton = {
        let restModeButton = UIButton()
        restModeButton.setTitle("Rest mode", for: .normal)
        restModeButton.setTitleColor(.black, for: .normal)
        restModeButton.layer.borderWidth = 1
        restModeButton.layer.cornerRadius = 10
        restModeButton.layer.borderColor = CGColor(red: 127, green: 0, blue: 255, alpha: 1.0)
        restModeButton.addTarget(self, action: #selector(restModeButtonTapped), for: .touchUpInside)
        return restModeButton
    }()
    private lazy var appLabel: UILabel = {
       let appLabel = UILabel()
        appLabel.text = "Pomodoro timer app"
        appLabel.textColor = .black
        appLabel.font = UIFont(name: "Marker Felt", size: 30)
        return appLabel
    }()
    private lazy var timerLabel: UILabel = {
       let timerLabel = UILabel()
        timerLabel.text = formatTime()
        timerLabel.textColor = .black
        timerLabel.font = UIFont(name: "Times New Roman", size: 30)
        return timerLabel
    }()
    private lazy var restartButton: UIButton = {
       let restartButton = UIButton()
        restartButton.setTitle("Restart", for: .normal)
        restartButton.setTitleColor(.black, for: .normal)
        restartButton.titleLabel?.font = UIFont(name: "Times New Roman", size: 30)
//        restModeButton.backgroundColor = .blue
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        return restartButton
    }()
    private lazy var startButton: UIButton = {
       let startButton = UIButton()
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont(name: "Times New Roman", size: 30)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return startButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        drawBackgroundLayer()
    }
    
    @objc private func startButtonTapped() {
        if !isTimerStarted {
            drawForegroundLayer()
            startResumeAnimation()
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(.orange, for: .normal)
        } else {
            pauseAnimation()
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(.green, for: .normal)
        }
    }
    @objc private func restartButtonTapped() {
        stopAnimation()
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.green, for: .normal)
        timer.invalidate()
        workModeButton.backgroundColor = .gray
        restModeButton.backgroundColor = .white
        time = 25
        isTimerStarted = false
        timerLabel.text = formatTime()
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if time < 1 {
            startButton.setTitle("Start", for: .normal)
            startButton.setTitleColor(.green, for: .normal)
            timer.invalidate()
            time = 25
            workModeButton.backgroundColor = .gray
            restModeButton.backgroundColor = .white
            isTimerStarted = false
            timerLabel.text = formatTime()
        } else {
            time -= 1
            timerLabel.text = formatTime()
        }
    }
    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    func drawBackgroundLayer() {
        backgroundProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 150, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        backgroundProgressLayer.strokeColor = UIColor.black.cgColor
        backgroundProgressLayer.fillColor = UIColor.clear.cgColor
        backgroundProgressLayer.lineWidth = 15
        view.layer.addSublayer(backgroundProgressLayer)
    }
    func drawForegroundLayer() {
        foregroundProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 150, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        foregroundProgressLayer.strokeColor = UIColor.red.cgColor
        foregroundProgressLayer.fillColor = UIColor.clear.cgColor
        foregroundProgressLayer.lineWidth = 15
        view.layer.addSublayer(foregroundProgressLayer)
    }
    
    func startResumeAnimation() {
        if !isAnimationStarted {
            startAnimation()
        } else {
            resumeAnimation()
        }
    }
    
    func startAnimation() {
        resetAnimation()
        foregroundProgressLayer.strokeEnd = 0.0
        animationOfProgressLayer.keyPath = "strokeEnd"
        animationOfProgressLayer.fromValue = 0
        animationOfProgressLayer.toValue = 1
        animationOfProgressLayer.duration = CFTimeInterval(self.time)
        animationOfProgressLayer.delegate = self
        animationOfProgressLayer.isRemovedOnCompletion = false
        animationOfProgressLayer.isAdditive = true
        animationOfProgressLayer.fillMode = CAMediaTimingFillMode.forwards
        foregroundProgressLayer.add(animationOfProgressLayer, forKey: "strokeEnd")
        isAnimationStarted = true
    }
    func resetAnimation() {
        foregroundProgressLayer.speed = 1.0
        foregroundProgressLayer.timeOffset = 0.0
        foregroundProgressLayer.beginTime = 0.0
        foregroundProgressLayer.strokeEnd = 0.0
        isAnimationStarted = false
    }
    
    func pauseAnimation() {
        let pausedTime = foregroundProgressLayer.convertTime(CACurrentMediaTime(), from: nil)
        foregroundProgressLayer.speed = 0.0
        foregroundProgressLayer.timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        let pausedTime = foregroundProgressLayer.timeOffset
        foregroundProgressLayer.speed = 1.0
        foregroundProgressLayer.timeOffset = 0.0
        foregroundProgressLayer.beginTime = 0.0
        let timeSincePaused = foregroundProgressLayer.convertTime(CACurrentMediaTime(), to: nil) - pausedTime
        foregroundProgressLayer.beginTime = timeSincePaused
    }
    
    func stopAnimation() {
        foregroundProgressLayer.speed = 1.0
        foregroundProgressLayer.timeOffset = 0.0
        foregroundProgressLayer.beginTime = 0.0
        foregroundProgressLayer.strokeEnd = 0.0
        foregroundProgressLayer.removeAllAnimations()
        isAnimationStarted = false
    }
    @objc private func workModeButtonTapped() {
        time = 25
        workModeButton.backgroundColor = .gray
        restModeButton.backgroundColor = .white
        timerLabel.text = formatTime()
    }
    @objc private func restModeButtonTapped() {
        time = 5
        restModeButton.backgroundColor = .gray
        workModeButton.backgroundColor = .white
        timerLabel.text = formatTime()
    }
    
    private func setupHierarchy() {
        let views = [timerLabel,appLabel,restartButton,startButton,workModeButton,restModeButton]
        views.forEach { view.addSubview($0) }
    }
    private func setupLayout() {
        timerLabel.snp.makeConstraints { timerLabel in
            timerLabel.centerX.equalTo(view)
            timerLabel.centerY.equalTo(view)
        }
        appLabel.snp.makeConstraints { appLabel in
            appLabel.centerX.equalTo(view)
            appLabel.top.equalTo(view).offset(100)
        }
        restartButton.snp.makeConstraints { restartButton in
            restartButton.centerX.equalTo(view).offset(-100)
            restartButton.bottom.equalTo(view).inset(75)
        }
        startButton.snp.makeConstraints { startButton in
            startButton.centerX.equalTo(view).offset(100)
            startButton.bottom.equalTo(view).inset(75)
        }
        workModeButton.snp.makeConstraints { workModeButton in
            workModeButton.centerX.equalTo(view).offset(-85)
            workModeButton.top.equalTo(view).offset(170)
            workModeButton.width.equalTo(110)
        }
        restModeButton.snp.makeConstraints { restModeButton in
            restModeButton.centerX.equalTo(view).offset(85)
            restModeButton.top.equalTo(view).offset(170)
            restModeButton.width.equalTo(110)
        }
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stopAnimation()
    }
}

extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

