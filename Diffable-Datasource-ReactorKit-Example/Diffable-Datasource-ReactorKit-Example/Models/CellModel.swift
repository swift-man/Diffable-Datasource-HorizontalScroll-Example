//
//  CellModel.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/07.
//

import UIKit

class CellModel: Hashable {
  let id = UUID()
  var title: String?
  var image: UIImage?
  var count: Int

  init(title: String?, count: Int = 1) {
    self.title = title
    self.count = count
    switch count {
    case 1:
      self.image = UIImage(systemName: "01.square.fill")
    case 2:
      self.image = UIImage(systemName: "02.square.fill")
    case 3:
      self.image = UIImage(systemName: "03.square.fill")
    case 4:
      self.image = UIImage(systemName: "04.square.fill")
    default:
      self.image = UIImage(systemName: "05.square.fill")
    }
  }

  static func == (lhs: CellModel, rhs: CellModel) -> Bool {
    lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
