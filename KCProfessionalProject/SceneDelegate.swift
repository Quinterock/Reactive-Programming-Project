//
//  SceneDelegate.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 30/04/25.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appState: AppState = AppState() // ViewModel global de toda la app
    var cancellable: AnyCancellable?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Código que se cambia al login
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        appState.validateLogin()
        
        var nav: UINavigationController?
        
        self.cancellable = appState.$loginStatus
            .sink { state in
                switch state {
                case .none, .notValidated:
                    DispatchQueue.main.async {
                        print("login")
                        nav = UINavigationController(rootViewController: LoginViewController(appState: self.appState))
                        self.window?.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }
                case .success:
                    DispatchQueue.main.async {
                        print("Vamos a la home")
                        nav = UINavigationController(
                            rootViewController: HerosTableViewController(
                                appState: self.appState,
                                viewModel: HerosViewModel()
                            )
                        )
                        self.window?.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }
                case .error:
                    DispatchQueue.main.async {
                        print("error")
                        nav = UINavigationController(
                            rootViewController: ErrorViewController(
                                appState: self.appState,
                                error: NSLocalizedString("error-message", comment: "")
                            )
                        )
                        self.window?.rootViewController = nav
                        self.window!.makeKeyAndVisible()
                    }
                }
            }
    }
}

