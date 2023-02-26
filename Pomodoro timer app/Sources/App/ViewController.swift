//
//  ViewController.swift
//  Pomodoro timer app
//
//  Created by Adlet Zhantassov on 26.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var appLabel: UILabel = {
       let appLabel = UILabel()
        appLabel.text = "Pomodoro timer app"
        appLabel.textColor = .black
        appLabel.font = UIFont(name: "Marker Felt", size: 30)
        return appLabel
    }()
    private lazy var timerLabel: UILabel = {
       let timerLabel = UILabel()
        timerLabel.text = "25:00"
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
        
    }
    @objc private func restartButtonTapped() {
        
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

