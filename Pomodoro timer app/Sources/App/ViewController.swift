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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        let views = [timerLabel,appLabel]
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
    }


}

