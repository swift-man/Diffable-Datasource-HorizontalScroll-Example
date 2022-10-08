//
//  ImageTextCollectionViewCellReactor.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/09.
//

import Foundation
import ReactorKit

final class ImageTextCollectionViewCellReactor: Reactor {
  let initialState: State

  init(cellModel: CellModel) {
    initialState = State(cellModel: cellModel)
  }

  enum Action {
  }

  struct State: Hashable {
    let cellModel: CellModel
  }
}

extension ImageTextCollectionViewCellReactor: Hashable {
  static func == (lhs: ImageTextCollectionViewCellReactor, rhs: ImageTextCollectionViewCellReactor) -> Bool {
    lhs.currentState == rhs.currentState
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(currentState.cellModel.id)
  }
}
