//
//  ProgressView.swift
//  SmartPDFTools
//
//  Created by Zoha on 8/15/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit
import Lottie

class ProgressView: UIView {
  @IBOutlet weak var button: UIButton!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var progressTxt: UILabel!
  @IBOutlet weak var titleView: UILabel!
  @IBOutlet weak var animationView: AnimationView!

  var onCancelAction: (() -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    applyRadius()
  }

  func configureViews(withColor color: UIColor, animation lottiName: String) {
    button.applyButtonTransparent(withBackgroundColor: color)
    button.setTitle("Cancel", for: .normal)

    progressBar.setProgress(0, animated: false)
    progressTxt.text = "0%"
    animationView.animation = Animation.named(lottiName)
    animationView.loopMode = .loop
    animationView.play()
  }

  func setProgress(_ progress: Float) {
    let parcentage = Int(progress * 100.00)

    progressBar.setProgress(progress, animated: true)
    progressTxt.text = "\(parcentage)%"
  }

  @IBAction func cancelAction(_ sender: Any) {
    onCancelAction?()
  }
}
