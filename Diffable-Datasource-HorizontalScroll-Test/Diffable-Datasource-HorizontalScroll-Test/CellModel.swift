//
//  CellModel.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/07.
//

import UIKit

class CellModel: Hashable {
  let id = UUID()
  var title: String?
  var image: UIImage?
  
  init(title: String?, count: Int = 1) {
    self.title = title
//    self.image = count
  }
  
  static func == (lhs: CellModel, rhs: CellModel) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
