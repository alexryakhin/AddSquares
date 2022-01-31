//
//  ViewController.swift
//  AddSquares
//
//  Created by Alexander Ryakhin on 1/31/22.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Buttons outlet collection
    @IBOutlet private var colorButtons: [UIButton]!
    
    private var selectedColor: UIColor = .black

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func colorButtonPressed(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        selectedColor = color
        updateSelectedButton(sender)
    }
    
    private func updateSelectedButton(_ button: UIButton) {
        colorButtons.forEach { $0.alpha = 1.0 }
        button.alpha = 0.8
    }

}

