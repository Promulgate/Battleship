//
//  BattleShipEngine.swift
//  Battleship
//
//  Created by Eric Chang on 9/17/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class BattleShipEngine {
  
  enum State {
    case Hittable
    case NotHittable
  }
  
  var grid = [State]()
  let numGrid: Int
  
  init(numGrid:Int){
    self.numGrid = numGrid
    setupShips()
  }
  
  
  /**
   * setupShips is called on load/reset
   * makeShip = math for random ship plot
   */
  
  let shipTypes = [2, 3, 3, 4, 5]
  var checkOverlap = [Int]()
  
  func setupShips() {
    grid = Array(repeating: .NotHittable, count: numGrid)
    checkOverlap = []
    for ship in shipTypes {
      makeShip(i: ship)
    }
  }
  
  func makeShip(i: Int) {
    var holdSpots = [Int]()
    var tempFirst = Int(arc4random() % UInt32(numGrid))
    holdSpots.append(tempFirst)
    
    let tempRandom = arc4random() % 2
    switch tempRandom {
    case 0:
      if tempFirst + (10 * i) > 99 {
        for _ in 1..<i {
          tempFirst -= 10
          holdSpots.append(tempFirst)
        }
      }
      else {
        for _ in 1..<i {
          tempFirst += 10
          holdSpots.append(tempFirst)
        }
      }
    default:
      if (tempFirst + (1 * i)) / 10 > tempFirst / 10 {
        for _ in 1..<i {
          tempFirst -= 1
          holdSpots.append(tempFirst)
        }
      }
      else {
        for _ in 1..<i {
          tempFirst += 1
          holdSpots.append(tempFirst)
        }
      }
    }
    
    for spot in holdSpots {
      if checkOverlap.contains(spot) {
        holdSpots = []
      }
    }
    for spot in holdSpots {
      checkOverlap.append(spot)
      grid[spot] = .Hittable
    }
    if holdSpots == [] {
      makeShip(i: i)
    }
  }
  
  
  /**
   * Hit or Miss:
   * grid[target] = true(hit) or false(miss)
   */
  
  func checkShip(_ target: Int) -> Bool{
    assert(target < grid.count)  //helps with debugging
    return grid[target] == .Hittable
  }
  
}
