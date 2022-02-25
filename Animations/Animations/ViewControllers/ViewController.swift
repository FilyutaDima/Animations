//
//  ViewController.swift
//  Animations
//
//  Created by Dmitry on 23.02.22.
//

import UIKit
import Spring
import SideMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSwipesAction()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBOutlet weak var animationNameLabel: UILabel!
    @IBOutlet weak var animationView: SpringView!
    @IBOutlet weak var forceSlider: UISlider!
    @IBOutlet weak var forceLabel: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var delaySlider: UISlider!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewWillAppear(_ animated: Bool) {
        initViews()
    }
    
    @IBAction func forceSliderAction(_ sender: UISlider) {
        forceLabel.text = String(format: "%.1f", sender.value)
    }
    @IBAction func durationSliderAction(_ sender: UISlider) {
        durationLabel.text = String(format: "%.1f", sender.value)
    }
    @IBAction func delaySliderAction(_ sender: UISlider) {
        delayLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func enterButtonAction(_ sender: Any) {
        
        guard let animationType = AnimationType.allCases.randomElement() else { return }
        animationView.animation = animationType.rawValue
        
        animationView.force = CGFloat(forceSlider.value)
        animationView.duration = CGFloat(durationSlider.value)
        animationView.delay = CGFloat(delaySlider.value)
        animationView.curve = Curve.allCases[pickerView.selectedRow(inComponent: 0)].rawValue
        
        animationView.animate()
        
        animationNameLabel.text = animationType.rawValue.uppercased()
    }
    
    private func initViews() {
        animationView.layer.cornerRadius = animationView.frame.size.width / 2
    }
    
    private func addSwipesAction() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right

        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                performSegue(withIdentifier: Constants.goToSideMenu, sender: self)
            default:
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.goToSideMenu {
            let navViewController = segue.destination as! UISideMenuNavigationController
            let sideMenuVC = navViewController.viewControllers.first as! SideMenuViewController
            sideMenuVC.forceValue = forceLabel.text
            sideMenuVC.durationValue = durationLabel.text
            sideMenuVC.delayValue = delayLabel.text
            sideMenuVC.curveLabel = Curve.allCases[pickerView.selectedRow(inComponent: 0)].rawValue
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
   
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        pickerLabel.font = UIFont(name: "System", size: 17)
        pickerLabel.textAlignment = .center
        pickerLabel.text = Curve.allCases[row].rawValue
        pickerLabel.textColor = .black
        
        return pickerLabel
    }
}

extension ViewController: SideMenuNavigationControllerDelegate {
    
}


