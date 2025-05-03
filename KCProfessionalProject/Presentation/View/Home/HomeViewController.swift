//
//  HomeViewController.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 30/04/25.
//

import UIKit

class HomeViewController: UIViewController {
    private var appState: AppState?
    
    init(appState: AppState? = nil) {
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
