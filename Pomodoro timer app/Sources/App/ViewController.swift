//
//  ViewController.swift
//  Pomodoro timer app
//
//  Created by Adlet Zhantassov on 26.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 1500
    
    private lazy var appLabel: UILabel = {
       let appLabel = UILabel()
        appLabel.text = "Pomodoro timer app"
        appLabel.textColor = .black
        appLabel.font = UIFont(name: "Marker Felt", size: 30)
        return appLabel
    }()
    private lazy var timerLabel: UILabel = {
       let timerLabel = UILabel()
        timerLabel.text = "25:10"
        timerLabel.textColor = .black
        timerLabel.font = UIFont(name: "Times New Roman", size: 30)
        return timerLabel
    }()
    private lazy var restartButton: UIButton = {
       let restartButton = UIButton()
        restartButton.setTitle("Restart", for: .normal)
        restartButton.setTitleColor(.black, for: .normal)
        restartButton.titleLabel?.font = UIFont(name: "Times New Roman", size: 30)
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
    private lazy var buttonsSV: UIStackView = {
       let buttonsSV = UIStackView()
        buttonsSV.axis = .horizontal
        buttonsSV.spacing = 170
        buttonsSV.addArrangedSubview(restartButton)
        buttonsSV.addArrangedSubview(startButton)
        return buttonsSV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
    }
    
    @objc private func startButtonTapped() {
        if !isTimerStarted {
            startTimer()
            isTimerStarted = true
        } else {
            timer.invalidate()
            isTimerStarted = false
        }
    }
    @objc private func restartButtonTapped() {
        timer.invalidate()
        time = 1500
        isTimerStarted = false
        timerLabel.text = "25:10"
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        time -= 1
        timerLabel.text = formatTime()
    }
    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    private func setupHierarchy() {
        let views = [timerLabel,appLabel,buttonsSV]
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
        buttonsSV.snp.makeConstraints { buttonsSV in
            buttonsSV.centerX.equalTo(view)
            buttonsSV.bottom.equalTo(view).inset(75)
        }
        
    }


}

