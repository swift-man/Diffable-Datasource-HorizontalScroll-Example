//
//  SectionModel.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/07.
//

import Foundation

class SectionModel: Hashable {
  let id = UUID()
  
  var title: String
  var cellModels: [CellModel]
  
  var subtitle: String {
    "\(cellModels.count)"
  }
  
  init(title: String, cellModels: [CellModel]) {
    self.title = title
    self.cellModels = cellModels
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
    lhs.id == rhs.id
  }
}

extension SectionModel {
  static var allSections: [SectionModel] = [
    SectionModel(title: "SwiftUI", cellModels: [
      CellModel(
        title: "SwiftUI"
      ),
      CellModel(
        title: "SwiftUI1"
      ),
      CellModel(
        title: "SwiftUI2"
      ),
      CellModel(
        title: "SwiftUI3"
      ),
      CellModel(
        title: "SwiftUI4"
      ),
      CellModel(
        title: "SwiftUI5"
      ),
      CellModel(
        title: "SwiftUI6"
      ),
      CellModel(
        title: "SwiftUI7"
      ),
      CellModel(
        title: "SwiftUI8"
      ),
      CellModel(
        title: "SwiftUI9"
      ),
      CellModel(
        title: "SwiftUI10"
      )
    ]),
    SectionModel(title: "UIKit", cellModels: [
      CellModel(
        title: "Demystifying",
        count: 26
      ),
      CellModel(
        title: "Controls",
        count: 31
      )
    ]),
    SectionModel(title: "Frameworks", cellModels: [
      CellModel(
        title: "iOS",
        count: 44
      ),
      CellModel(
        title: "Beginning",
        count: 3
      )
    ]),
    SectionModel(title: "EmptySection", cellModels: []),
    SectionModel(title: "Miscellaneous", cellModels: [
      CellModel(
        title: "Structures",
        count: 2
      ),
      CellModel(
        title: "Beginning",
        count: 4
      ),
      CellModel(
        title: "Machine",
        count: 1
      ),
      CellModel(
        title: "Push",
        count: 3
      ),
    ]),
    SectionModel(title: "SwiftUI", cellModels: [
      CellModel(
        title: "SwiftUI"
      ),
      CellModel(
        title: "SwiftUI1"
      ),
      CellModel(
        title: "SwiftUI2"
      ),
      CellModel(
        title: "SwiftUI3"
      ),
      CellModel(
        title: "SwiftUI4"
      ),
      CellModel(
        title: "SwiftUI5"
      ),
      CellModel(
        title: "SwiftUI6"
      ),
      CellModel(
        title: "SwiftUI7"
      ),
      CellModel(
        title: "SwiftUI8"
      ),
      CellModel(
        title: "SwiftUI9"
      ),
      CellModel(
        title: "SwiftUI10"
      )
    ]),
    SectionModel(title: "UIKit", cellModels: [
      CellModel(
        title: "Views",
        count: 26
      ),
      CellModel(
        title: "Popular",
        count: 31
      )
    ]),
    SectionModel(title: "Frameworks", cellModels: [
      CellModel(
        title: "for",
        count: 44
      ),
      CellModel(
        title: "RxSwift",
        count: 3
      )
    ]),
    SectionModel(title: "EmptySection", cellModels: []),
    SectionModel(title: "Miscellaneous", cellModels: [
      CellModel(
        title: "Data",
        count: 2
      ),
      CellModel(
        title: "ARKit",
        count: 4
      ),
      CellModel(
        title: "Learning",
        count: 1
      ),
      CellModel(
        title: "Push",
        count: 3
      ),
    ])
  ]
}
