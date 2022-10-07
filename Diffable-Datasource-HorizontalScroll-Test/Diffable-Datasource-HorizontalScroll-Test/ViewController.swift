//
//  ViewController.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/07.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<SectionModel, CellModel>
typealias Snapshot = NSDiffableDataSourceSnapshot<SectionModel, CellModel>

class ViewController: UIViewController {
  var sections = SectionModel.allSections
//  private lazy var dataSource = configureDataSource()
  static let titleElementKind = "title-element-kind"
  private var dataSource: DataSource!
  private var currentSnapshot: Snapshot!
  
  private var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    navigationItem.title = "HorizontalScroll-Test"
    
    configureHierarchy()
//    registerCollectionViewInSubviews()
//    applySnapshot(animatingDifferrences: false)
    configureDataSource()
  }
  
  func configureHierarchy() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  func applySnapshot(animatingDifferrences: Bool = true) {
    currentSnapshot = Snapshot()
    
    sections.forEach {
      let collection = $0
      currentSnapshot.appendSections([collection])
      if !collection.cellModels.isEmpty {
        currentSnapshot.appendItems(collection.cellModels)
      }
      
    }
    dataSource.apply(currentSnapshot, animatingDifferences: animatingDifferrences)
  }
  
  func createLayout() -> UICollectionViewLayout {
    let sectionProvider = { (sectionIndex: Int,
                             layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
//      item.edgeSpacing = .init(leading: .fixed(10), top: nil, trailing: .fixed(10), bottom: nil)
      // if we have the space, adapt and go 2-up + peeking 3rd item
      let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ?
                                         0.425 : 0.85)
      let groupSize: NSCollectionLayoutSize
      if let sectionModel = self.currentSnapshot.sectionIdentifiers[safe: sectionIndex], sectionModel.cellModels.isEmpty {
        groupSize = NSCollectionLayoutSize(widthDimension: .absolute(0),
                                           heightDimension: .absolute(0))
      } else {
        groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                           heightDimension: .absolute(72))
      }
      
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//      group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(10), top: nil, trailing: .fixed(10), bottom: nil)
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      if let sectionModel = self.currentSnapshot.sectionIdentifiers[safe: sectionIndex], !sectionModel.cellModels.isEmpty {
        section.interGroupSpacing = 8
      }
      
      section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
      
      
      
      let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .absolute(47))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: titleSize,
        elementKind: ViewController.titleElementKind,
        alignment: .top)
//      sectionHeader.pinToVisibleBounds = true
//      sectionHeader.zIndex = 2
      section.boundarySupplementaryItems = [sectionHeader]
      return section
    }
    
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 20
    
    let layout = UICollectionViewCompositionalLayout(
      sectionProvider: sectionProvider, configuration: config)
    return layout
  }
}

// MARK: - UICollectionViewDataSource
extension ViewController {
  func configureDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<CollectionViewCell, CellModel> { (cell, indexPath, cellModel) in
        // Populate the cell with our item description.
        cell.cellModel = cellModel
    }
    
    dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, cellModel) -> UICollectionViewCell? in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: cellModel)
    }
    
    let supplementaryRegistration = UICollectionView.SupplementaryRegistration<SectionHeaderReusableView>(elementKind: ViewController.titleElementKind) { supplementaryView, elementKind, indexPath in
      if let snapshot = self.currentSnapshot {
          // Populate the view with our section's description.
          let sectionModel = snapshot.sectionIdentifiers[indexPath.section]
          supplementaryView.sectionModel = sectionModel
      }
    }

    dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
      return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
    }
    
    applySnapshot()
  }
}


// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(#function)
  }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
