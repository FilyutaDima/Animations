//
//  SideMenuViewController.swift
//  Animations
//
//  Created by Dmitry on 25.02.22.
//

import UIKit

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    var forceValue: String?
    var durationValue: String?
    var delayValue: String?
    var curveLabel: String?
    
    @IBOutlet weak var forceValueLabel: UILabel!
    @IBOutlet weak var durationValueLabel: UILabel!
    @IBOutlet weak var delayValueLabel: UILabel!
    @IBOutlet weak var curveValueLabel: UILabel!
    
    private func initViews() {
        
        guard let forceValue = forceValue,
              let durationValue = durationValue,
              let delayValue = delayValue,
              let curveLabel = curveLabel else { return }

        forceValueLabel.text = forceValue
        durationValueLabel.text = durationValue
        delayValueLabel.text = delayValue
        curveValueLabel.text = curveLabel
    }
}
