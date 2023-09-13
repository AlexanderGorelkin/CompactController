//
//  MainViewController.swift
//  CompactController
//
//  Created by Александр Горелкин on 13.09.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var presentButton: UIButton = {
        let button = UIButton()
        
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.openCompactController()
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        view.addSubview(presentButton)
        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
    func openCompactController() {
        let controller = CompactViewController()
        controller.modalPresentationStyle = .popover
        controller.popoverPresentationController?.sourceView = presentButton
        controller.popoverPresentationController?.permittedArrowDirections = [.up]
        controller.popoverPresentationController?.delegate = self
        present(controller, animated: true)
    }
    
}

extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        .none
    }
}
