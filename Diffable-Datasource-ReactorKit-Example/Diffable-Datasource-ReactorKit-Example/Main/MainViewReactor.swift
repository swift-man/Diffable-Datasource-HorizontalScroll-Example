//
//  MainViewReactor.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/09.
//

import Foundation
import ReactorKit

typealias SectionReactor = SectionHeaderReusableViewReactor
typealias CellReactor = ImageTextCollectionViewCellReactor

final class MainViewReactor: Reactor {
  let initialState = State()

  enum Action {
  }

  enum Mutation {
  }
  struct State {
    var sectionReactors = MainViewReactor.allSectionReactors
  }

  func mutate(action: Action) -> Observable<Mutation> {
    return .empty()
  }

  func reduce(state: State, mutation: Mutation) -> State {
   return state
  }
}

extension MainViewReactor {
  static var allSectionReactors: [SectionHeaderReusableViewReactor] = [
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "SwiftUI"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "SwiftUI")),
      CellReactor(cellModel: CellModel(title: "SwiftUI1")),
      CellReactor(cellModel: CellModel(title: nil)),
      CellReactor(cellModel: CellModel(title: "SwiftUI3")),
      CellReactor(cellModel: CellModel(title: "SwiftUI4")),
      CellReactor(cellModel: CellModel(title: "SwiftUI5")),
      CellReactor(cellModel: CellModel(title: "SwiftUI6")),
      CellReactor(cellModel: CellModel(title: "SwiftUI7")),
      CellReactor(cellModel: CellModel(title: "SwiftUI8")),
      CellReactor(cellModel: CellModel(title: "SwiftUI9")),
      CellReactor(cellModel: CellModel(title: "SwiftUI10"))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "UIKit"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "Demystifying", count: 26)),
      CellReactor(cellModel: CellModel(title: "Controls", count: 31))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "Frameworks"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "iOS", count: 44)),
      CellReactor(cellModel: CellModel(title: "Beginning", count: 3))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "EmptySection"), cellReactors: []),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "Miscellaneous"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "Structures", count: 2)),
      CellReactor(cellModel: CellModel(title: "Beginning", count: 4)),
      CellReactor(cellModel: CellModel(title: "Machine", count: 1)),
      CellReactor(cellModel: CellModel(title: "Push", count: 3))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "SwiftUI"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "SwiftUI")),
      CellReactor(cellModel: CellModel(title: "")),
      CellReactor(cellModel: CellModel(title: "SwiftUI2")),
      CellReactor(cellModel: CellModel(title: "SwiftUI3")),
      CellReactor(cellModel: CellModel(title: "SwiftUI4")),
      CellReactor(cellModel: CellModel(title: "SwiftUI5")),
      CellReactor(cellModel: CellModel(title: "SwiftUI6")),
      CellReactor(cellModel: CellModel(title: "SwiftUI7")),
      CellReactor(cellModel: CellModel(title: "SwiftUI8")),
      CellReactor(cellModel: CellModel(title: "SwiftUI9")),
      CellReactor(cellModel: CellModel(title: "SwiftUI10"))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "UIKit"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "Views", count: 26)),
      CellReactor(cellModel: CellModel(title: "Popular", count: 31))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "Frameworks"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "for", count: 44)),
      CellReactor(cellModel: CellModel(title: "RxSwift", count: 3))
    ]),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "EmptySection"), cellReactors: []),
    SectionHeaderReusableViewReactor(sectionModel: SectionModel(title: "Miscellaneous"), cellReactors: [
      CellReactor(cellModel: CellModel(title: "Data", count: 2)),
      CellReactor(cellModel: CellModel(title: "ARKit", count: 4)),
      CellReactor(cellModel: CellModel(title: "Learning", count: 1)),
      CellReactor(cellModel: CellModel(title: "Push", count: 3))
    ])
  ]
}
