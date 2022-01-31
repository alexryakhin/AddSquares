//
//  MainViewController.swift
//  AddSquares
//
//  Created by Alexander Ryakhin on 1/31/22.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var colorButtons: [UIButton]!
    
    // MARK: - Private properties
    private var selectedColor: UIColor = .black

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: IBActions
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        selectedColor = color
        updateSelectedButton(sender)
    }
    
    // MARK: - Private methods
    private func updateSelectedButton(_ button: UIButton) {
        colorButtons.forEach { $0.alpha = 1.0 }
        button.alpha = 0.8
    }

}

