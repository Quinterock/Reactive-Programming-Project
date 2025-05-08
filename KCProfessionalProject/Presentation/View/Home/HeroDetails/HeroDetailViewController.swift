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
    
    @IBOutlet weak var transformationCollectionView: UICollectionView!
    
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
        self.title = NSLocalizedString("hero-details", comment: "Detalles del Héroe")
        setupUI()
        setupBindings()
        Task {
            await viewModel.loadHeroDetails()
        }
    }
    
    // CollectionView
    private func setupUI() {
            // Configurar la UICollectionView
            let nib = UINib(nibName: "TransformationCollectionViewCell", bundle: nil)
            transformationCollectionView.register(nib, forCellWithReuseIdentifier: "TransformationCollectionViewCell")
            transformationCollectionView.dataSource = self
            transformationCollectionView.delegate = self
        }
    
    // Observar cambios en el estado del ViewModel y actualizar la UI de manera reactiva
    private func setupBindings() {
        viewModel.$hero
            .receive(on: DispatchQueue.main) // Asegurar que las actualizaciones ocurran en el hilo principal
            .sink { [weak self] hero in
                guard let hero = hero else { return }
                self?.heroNameLabel.text = hero.name
                self?.heroDescriptionLabel.text = hero.description
                if let url = URL(string: hero.photo ?? "") {
                    self?.heroImageView.loadImageRemote(url: url)
                }
            }
            .store(in: &cancellables)
        
        // Vincular transformaciones
                viewModel.$transformations
                    .receive(on: DispatchQueue.main) // Asegura que las actualizaciones ocurran en el hilo principal
                    .sink { [weak self] _ in
                        self?.transformationCollectionView.reloadData() // Recargar el collection view para reflejar cambios
                    }
                    .store(in: &cancellables)

                // Manejar errores
                viewModel.$errorMessage
                    .receive(on: DispatchQueue.main) // Asegura que las actualizaciones ocurran en el hilo principal
                    .sink { [weak self] errorMessage in
                        if let message = errorMessage {
                            self?.showErrorAlert(message: message)
                        }
                    }
                    .store(in: &cancellables)
    }
}

// MARK: - UICollectionView DataSource
extension HeroDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("---- Número de transformaciones: \(viewModel.transformations.count)")
        return viewModel.transformations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransformationCollectionViewCell", for: indexPath) as? TransformationCollectionViewCell else {
            return UICollectionViewCell()
        }
        let transformation = viewModel.transformations[indexPath.row]
        cell.configure(with: transformation)
        return cell
    }
}

extension HeroDetailViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
