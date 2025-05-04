//
//  ErrorViewController.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 30/04/25.
//

import UIKit
import Combine
import CombineCocoa

class ErrorViewController: UIViewController {

    private var appState: AppState?
    private var suscriptors = Set<AnyCancellable>()
    private var errorString: String

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorButton: UIButton!
    
    init(appState: AppState? = nil, error: String) {
        self.appState = appState
        self.errorString = error
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorLabel.text = self.errorString
        
        self.errorButton.tapPublisher
            .sink {
                self.appState?.loginStatus = .none
            }
            .store(in: &suscriptors)
    }


}
