//
//  CompactViewController.swift
//  CompactViewController
//
//  Created by Александр Горелкин on 13.09.2023.
//

import UIKit

enum Segments: Int, CaseIterable {
    case large
    case small
    
    var names: String {
        switch self {
        case .large:
            return "280pt"
        case .small:
            return "150pt"
        }
    }
    
    var size: CGSize {
        switch self {
        case .large:
            return CGSize(width: 300, height: 280)
        case .small:
            return CGSize(width: 300, height: 150)
        }
    }
    
}

final class CompactViewController: UIViewController {
    
    var currentSize: CGSize = Segments.large.size
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: Segments.allCases.map{ $0.names })
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addAction(UIAction(handler: { [weak self] _ in
            self?.changeSize()
        }), for: .valueChanged)
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = currentSize
        view.backgroundColor = .white
        
        view.addSubview(segmentControl)
        segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(dismissButton)
        dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        
    }
    
    func changeSize() {
        guard let newSize = Segments(rawValue: segmentControl.selectedSegmentIndex) else { return }
        preferredContentSize = newSize.size
    }
    
}
