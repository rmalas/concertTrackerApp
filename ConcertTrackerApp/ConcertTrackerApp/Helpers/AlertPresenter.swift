//
//  AlertPresenter.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/10/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

protocol AlertPresenter {
    func showAlert(_ alert: ConcertTrackerAlertController)
}

extension AlertPresenter where Self: UIViewController {
    
    func showAlert(_ alert: ConcertTrackerAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
}
