//
//  MainViewController.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/07.
//

import ReactorKit
import RxSwift
import Then
import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<SectionReactor, CellReactor>
typealias Snapshot = NSDiffableDataSourceSnapshot<SectionReactor, CellReactor>

final class MainViewController: UIViewController, View {
  var disposeBag = DisposeBag()
//  private lazy var dataSource = configureDataSource()

  private var dataSource: DataSource?
  private var currentSnapshot = Snapshot()

  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    navigationItem.title = "HorizontalScroll-Test"
    view.backgroundColor = UIColor(named: "CollectionViewBackground")
    configureCollectionView()
//    registerCollectionViewInSubviews()
//    applySnapshot(animatingDifferrences: false)
    configureDataSource()
  }

  func bind(reactor: MainViewReactor) {
    reactor.state.map { $0.sectionReactors }
      .distinctUntilChanged()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.applySnapshot(animatingDifferrences: false)
      })
      .disposed(by: disposeBag)
  }
  func configureCollectionView() {
    collectionView.delegate = self
    view.addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  func applySnapshot(animatingDifferrences: Bool = true, completion: (() -> Void)? = nil) {
    print("applySnapshot :")
    guard let reactor else { return }

    self.currentSnapshot = Snapshot()
    reactor.currentState.sectionReactors.forEach {
      let collection = $0
      self.currentSnapshot.appendSections([collection])
      if !collection.currentState.cellReactors.isEmpty {
        self.currentSnapshot.appendItems(collection.currentState.cellReactors)
      }
    }

    self.dataSource?.apply(self.currentSnapshot,
                           animatingDifferences: animatingDifferrences,
                           completion: completion)
  }

  func createLayout() -> UICollectionViewLayout {
    func createItem() -> NSCollectionLayoutItem {
      let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                            heightDimension: .absolute(72))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      return item
    }

    func createGroup(at sectionIndex: Int,
                     with item: NSCollectionLayoutItem,
                     snapshot: Snapshot) -> NSCollectionLayoutGroup {
      let groupSize: NSCollectionLayoutSize
      if let sectionReactor = snapshot.sectionIdentifiers[safe: sectionIndex],
         sectionReactor.currentState.cellReactors.isEmpty {
        groupSize = NSCollectionLayoutSize(widthDimension: .absolute(0),
                                           heightDimension: .absolute(0))
      } else {
        groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1200),
                                           heightDimension: .absolute(72))
      }

      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      return group
    }

    func createSection(at sectionIndex: Int,
                       with group: NSCollectionLayoutGroup,
                       snapshot: Snapshot,
                       view: UIView) -> NSCollectionLayoutSection {
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
      if let sectionReactor = snapshot.sectionIdentifiers[safe: sectionIndex],
         !sectionReactor.currentState.cellReactors.isEmpty {
        section.interGroupSpacing = 8

        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 12,
                                                        bottom: 12,
                                                        trailing: 12)
      }

      let titleSize = NSCollectionLayoutSize(widthDimension: .absolute(view.frame.width),
                                             heightDimension: .absolute(48))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: titleSize,
        elementKind: SectionHeaderReusableView.elementKind,
        alignment: .top)

      sectionHeader.pinToVisibleBounds = true
      sectionHeader.zIndex = 2

      if snapshot.numberOfSections - 1 == sectionIndex {
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .absolute(88)),
            elementKind: EditSectionsReusableView.elementKind,
            alignment: .bottom)
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        return section
      }

      section.boundarySupplementaryItems = [sectionHeader]
      return section
    }

    let sectionProvider = { [weak self] (sectionIndex: Int, _: NSCollectionLayoutEnvironment)
      -> NSCollectionLayoutSection? in
      guard let self else { return nil }

      let item = createItem()
      let group = createGroup(at: sectionIndex,
                              with: item,
                              snapshot: self.currentSnapshot)
      let section = createSection(at: sectionIndex,
                                  with: group,
                                  snapshot: self.currentSnapshot,
                                  view: self.view)
      return section
    }

    let config = UICollectionViewCompositionalLayoutConfiguration()
    let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
    return layout
  }
}

// MARK: - UICollectionViewDataSource
extension MainViewController {
  func configureDataSource() {
    typealias ImageTextCellRegistration = UICollectionView.CellRegistration<ImageTextCollectionViewCell, CellReactor>
    let cellRegistration = ImageTextCellRegistration { cell, _, cellReactor in
      cell.bind(reactor: cellReactor)
    }

    dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, cellModel -> UICollectionViewCell? in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: cellModel)
    }

    typealias SectionHeaderReusableViewRegistration = UICollectionView.SupplementaryRegistration<SectionHeaderReusableView>
    let supplementaryRegistration = SectionHeaderReusableViewRegistration(elementKind: SectionHeaderReusableView.elementKind) { [weak self] supplementaryView, _, indexPath in
      if let self {
        let sectionReactor = self.currentSnapshot.sectionIdentifiers[indexPath.section]
        supplementaryView.bind(reactor: sectionReactor)

        supplementaryView.plusButtonTap
          .subscribe(onNext: { [weak self] _ in
            self?.showAlert(sectionReactor: sectionReactor, sectionIndex: indexPath.section)
          })
          .disposed(by: supplementaryView.disposeBag)
      }
    }

    typealias EditSectionsReusableViewRegistration = UICollectionView.SupplementaryRegistration<EditSectionsReusableView>
    let editSectionsRegistration = EditSectionsReusableViewRegistration(elementKind: EditSectionsReusableView.elementKind) { [weak self] supplementaryView, _, _ in
      if let self {
        supplementaryView.plusButtonTap
          .subscribe(onNext: { [weak self] _ in
            print("supplementaryView.plusButtonTap")
//            self?.showAlert(sectionReactor: sectiosnReactor, sectionIndex: indexPath.section)
          })
          .disposed(by: supplementaryView.disposeBag)
      }
    }

    dataSource?.supplementaryViewProvider = { [weak self] collectionView, elementKind, indexPath in
      if elementKind == SectionHeaderReusableView.elementKind {
        return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
      } else if let snapshotNumberOfSections = self?.currentSnapshot.numberOfSections, snapshotNumberOfSections - 1 == indexPath.section {
        return collectionView.dequeueConfiguredReusableSupplementary(using: editSectionsRegistration, for: indexPath)
      }

      return nil
    }

    applySnapshot()
  }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(#function)
  }
}

extension MainViewController {
  private func showAlert(sectionReactor: SectionHeaderReusableViewReactor, sectionIndex: Int) {
    let alert = UIAlertController(title: "", message: "insert", preferredStyle: .alert)
    alert.addTextField()
    alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
    alert.addAction(UIAlertAction(title: "done", style: .default, handler: { _ in
      if let text = alert.textFields?.first?.text {
        sectionReactor.action.onNext(.append(CellModel(title: text)))
        self.applySnapshot { [weak self] in
          self?.scrollToLastCell(at: sectionIndex)
        }
      }
    }))
    present(alert, animated: true)
  }

  private func scrollToLastCell(at sectionIndex: Int) {
    if sectionIndex < self.collectionView.numberOfSections {
      let item = self.collectionView.numberOfItems(inSection: sectionIndex) - 1
      let indexPath = IndexPath(item: item, section: sectionIndex)
      print("indexPath : \(indexPath)")

      collectionView.scrollToItem(
        at: indexPath,
        at: [.right],
        animated: true
      )
    }
  }
}
