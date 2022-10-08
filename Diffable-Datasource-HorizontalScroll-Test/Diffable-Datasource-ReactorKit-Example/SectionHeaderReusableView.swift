//
//  SectionHeaderReusableView.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/07.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class SectionHeaderReusableView: UICollectionReusableView, View {
  var disposeBag = DisposeBag()

  private let label = UILabel()
  private let subtitleLabel = UILabel()
  private let plusButton = UIButton(type: .custom)

  lazy var plusButtonTap = plusButton.rx.tap

  override init(frame: CGRect) {
    super.init(frame: frame)

    configureLabel()
    configureSubtitleLabel()
    configurePlusButton()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func bind(reactor: SectionHeaderReusableViewReactor) {
    reactor.state.map { $0.sectionModel.title }
      .distinctUntilChanged()
      .bind(to: label.rx.text)
      .disposed(by: disposeBag)

    reactor.state.map { $0.subtitle }
      .distinctUntilChanged()
      .bind(to: subtitleLabel.rx.text)
      .disposed(by: disposeBag)

    reactor.state.map { $0.cellReactors }
      .subscribe(onNext: { cellReactors in
        print("cellReactors.count: \(cellReactors.count)")
      })
      .disposed(by: disposeBag)
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    disposeBag = DisposeBag()
  }
}

extension SectionHeaderReusableView {
  private func configureLabel() {
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    //    label.adjustsFontForContentSizeCategory = true

    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.topAnchor.constraint(equalTo: topAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    //    label.font = UIFont.preferredFont(forTextStyle: .title3)
  }

  private func configureSubtitleLabel() {
    addSubview(subtitleLabel)
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

    subtitleLabel.textColor = .systemPink

    let inset = CGFloat(8)
    NSLayoutConstraint.activate([
      subtitleLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: inset),
      subtitleLabel.topAnchor.constraint(equalTo: topAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  private func configurePlusButton() {
    backgroundColor = .systemBackground
    plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
    plusButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(plusButton)
    NSLayoutConstraint.activate([
      plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
      plusButton.centerYAnchor.constraint(equalTo: label.centerYAnchor),
      plusButton.widthAnchor.constraint(equalToConstant: 44),
      plusButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}
