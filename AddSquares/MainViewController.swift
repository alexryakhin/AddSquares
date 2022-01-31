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
    @IBOutlet weak var undoButton: UIBarButtonItem!
    @IBOutlet weak var redoButton: UIBarButtonItem!
    
    // MARK: - Private properties
    private var selectedColor: UIColor?
    private var colorCount: [UIColor:Int] = [:]
    private var labels: [UILabel] = []
    private var removedLabels: [UILabel] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Color Game"
        updateButtonsState()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }

    // MARK: IBActions
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        selectedColor = color
        updateSelectedButton(sender)
    }
    
    @IBAction func undo(_ sender: Any) {
        let lastSquare = labels.removeLast()
        lastSquare.removeFromSuperview()
        guard let color = lastSquare.backgroundColor else { return }
        lastSquare.text = ""
        if let existingColorCount = colorCount[color] {
            colorCount[color] = existingColorCount - 1
        }
        removedLabels.append(lastSquare)
        updateButtonsState()
    }
    
    @IBAction func redo(_ sender: Any) {
        let lastSquare = removedLabels.removeLast()
        guard let color = lastSquare.backgroundColor else { return }
        if let existingColorCount = colorCount[color] {
            colorCount[color] = existingColorCount + 1
            lastSquare.text = String(existingColorCount + 1)
        }
        view.addSubview(lastSquare)
        labels.append(lastSquare)
        updateButtonsState()
    }
    
    // MARK: - Private methods
    private func updateSelectedButton(_ button: UIButton) {
        colorButtons.forEach { $0.alpha = 1.0 }
        button.alpha = 0.8
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        // sender has location CGPoint, so we can easily track user's taps
        addSquare(with: selectedColor, at: sender.location(in: view))
    }
    
    private func addSquare(with color: UIColor?, at location: CGPoint) {
        guard let color = color else { return }
        let squareView = UILabel(frame: CGRect(x: location.x, y: location.y, width: 50, height: 50))
        squareView.backgroundColor = color
        squareView.textAlignment = .center
        squareView.textColor = .white
        if let existingColorCount = colorCount[color] {
            colorCount[color] = existingColorCount + 1
            squareView.text = String(existingColorCount + 1)
        } else {
            squareView.text = "1"
            colorCount[color] = 1
        }
        view.addSubview(squareView)
        labels.append(squareView)
        updateButtonsState()
    }
    
    private func updateButtonsState() {
        undoButton.isEnabled = !labels.isEmpty
        redoButton.isEnabled = !removedLabels.isEmpty
    }
}
