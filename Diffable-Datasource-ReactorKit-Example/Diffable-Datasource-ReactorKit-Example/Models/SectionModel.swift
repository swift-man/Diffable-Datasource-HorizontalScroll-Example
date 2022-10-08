//
//  SectionModel.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/07.
//

import Foundation

class SectionModel {
  let id = UUID()

  var title: String

  init(title: String) {
    self.title = title
  }
}

extension SectionModel: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
    lhs.id == rhs.id
  }
}
