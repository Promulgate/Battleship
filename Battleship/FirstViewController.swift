//
//  FirstViewController.swift
//  Battleship
//
//  Created by Jason Gresh on 9/16/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  
  
  /**
   * MARK: Properties
   * MARK: Properties
   */
  
  @IBOutlet weak var WelcomeTitle: UILabel!
  @IBOutlet weak var GridContainer: UIView!
  
  let battleEngine: BattleShipEngine
  var loaded: Bool
  let resetTitle = "AGAIN!"
  let numGrid: Int
  var destroyedCount = 0
  
  required init?(coder aDecoder: NSCoder) {
    self.numGrid = 100
    self.loaded = false
    self.battleEngine = BattleShipEngine(numGrid: self.numGrid)
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    if !loaded {
      setUpGameButtons(v: GridContainer, totalButtons: self.numGrid, buttonsPerRow: 10)
      self.view.setNeedsDisplay()
      setUpResetButton()
    }
    loaded = true
  }
  
  
  /**
   * Reset Game:
   * Color - Reset call - Disable grid
   */
  
  func resetButtons() {
    for v in GridContainer.subviews {
      if let button = v as? UIButton {
        button.backgroundColor = UIColor(red: 0, green: 0.6706, blue: 0.9569, alpha: 1.0)
        button.isEnabled = true
      }
    }
    destroyedCount = 0
  }
  
  func handleReset() {
    resetButtons()
    battleEngine.setupShips()
  }
  
  func disableGrid() {
    for v in GridContainer.subviews {
      if let button = v as? UIButton {
        button.isEnabled = false
      }
    }
    WelcomeTitle.text = "YOU ARE VICTORIOUS! MAGGOT!"
  }
  
  
  /**
   * Setup Game:
   * Title - Battle grid - Reset
   */
  
  func setUpGameLabel () {
    WelcomeTitle.text = "WELCOME TO BATTLESHIP, MAGGOT!!"
  }
  
  func setUpGameButtons(v: UIView, totalButtons: Int, buttonsPerRow : Int) {
    for i in 1...numGrid {
      let y = ((i - 1) / buttonsPerRow)
      let x = ((i - 1) % buttonsPerRow)
      let side : CGFloat = (v.bounds.size.width / CGFloat(buttonsPerRow)) - 2.05
      let rect = CGRect(origin: CGPoint(x: side * CGFloat(x), y: (CGFloat(y) * side)), size: CGSize(width: side, height: side))
      let button = UIButton(frame: rect)
      button.tag = i
      button.backgroundColor = UIColor(red: 0, green: 0.6706, blue: 0.9569, alpha: 1.0)
      button.setTitle("BS", for: UIControlState())
      button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
      v.addSubview(button)
    }
    
    setUpGameLabel()
  }
  
  func setUpResetButton() {
    let resetRect = CGRect(x: 10, y: 500, width: 60, height: 40)
    let resetButton = UIButton(frame: resetRect)
    resetButton.setTitle(resetTitle, for: UIControlState())
    resetButton.backgroundColor = UIColor.darkGray
    resetButton.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
    view.addSubview(resetButton)
  }
  
  
  /**
   * View Actions:
   * Square on grid - Reset
   */
  
  func buttonTapped(_ sender: UIButton) {
    if battleEngine.checkShip(sender.tag - 1) {
      WelcomeTitle.text = "IT'S A HIT! GOOD JOB MAGGOT!"
      sender.backgroundColor = UIColor(red: 0.7098, green: 0, blue: 0, alpha: 1.0)
      sender.isEnabled = false
      destroyedCount += 1
      if destroyedCount == 17 {
        disableGrid()
      }
    }
    else {
      WelcomeTitle.text = "ARE YOU EVEN AIMING, MAGGOT?!"
      sender.backgroundColor = UIColor(red: 0.7176, green: 0.7176, blue: 0.7176, alpha: 1.0)
    }
  }
  
  @IBAction func resetTapped(_ sender: UIButton) {
    handleReset()
  }
  
}

