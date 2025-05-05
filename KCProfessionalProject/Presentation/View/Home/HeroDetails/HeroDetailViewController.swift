//
//  HeroDetailViewController.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import UIKit
import Combine

class HeroDetailViewController: UIViewController {
    private var viewModel: HeroDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // Outlets
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescriptionLabel: UITextView!
    
    // Inits
    init(viewModel: HeroDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        Task {
            await viewModel.loadHeroDetails()
        }
    }
    
    // Observar cambios en el estado del ViewModel y actualizar la UI de manera reactiva
    private func setupBindings() {
        viewModel.$hero
            .receive(on: DispatchQueue.main) // Asegurar que las actualizaciones ocurran en el hilo principal
            .sink { [weak self] hero in
                guard let hero = hero else { return }
                self?.heroNameLabel.text = hero.name
                self?.heroDescriptionLabel.text = hero.description
                if let url = URL(string: hero.photo) {
                    self?.heroImageView.loadImageRemote(url: url)
                }
            }
            .store(in: &cancellables)
    }
}
