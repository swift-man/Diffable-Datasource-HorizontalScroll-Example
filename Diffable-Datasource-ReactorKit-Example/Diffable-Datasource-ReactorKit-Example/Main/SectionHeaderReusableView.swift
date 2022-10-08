//
//  SectionHeaderReusableView.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/07.
//

import ReactorKit
import RxCocoa
import RxSwift
import Then
import UIKit

final class SectionHeaderReusableView: UICollectionReusableView, View {
  static let elementKind = "SectionHeaderReusableView"

  var disposeBag = DisposeBag()

  private let titleLabel = UILabel().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 14)
    $0.textColor = UIColor(named: "Text-Dark")
  }

  private let subtitleLabel = UILabel().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 12)
    $0.textColor = UIColor(named: "Text-Red")
  }
  private let plusButton = UIButton(type: .custom).then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: "plus"), for: .normal)
  }

  private let lineView = UIView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = UIColor(named: "Text-Dark")
  }

  lazy var plusButtonTap = plusButton.rx.tap

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .systemBackground
    configureLabel()
    configureSubtitleLabel()
    configurePlusButton()
    configureLineView()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    preconditionFailure("init(coder:) has not been implemented")
  }

  func bind(reactor: SectionHeaderReusableViewReactor) {
    reactor.state.map { $0.sectionModel.title }
      .distinctUntilChanged()
      .bind(to: titleLabel.rx.text)
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
    addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  private func configureSubtitleLabel() {
    addSubview(subtitleLabel)

    NSLayoutConstraint.activate([
      subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
      subtitleLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
    ])
  }

  private func configurePlusButton() {
    addSubview(plusButton)
    NSLayoutConstraint.activate([
      plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      plusButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      plusButton.widthAnchor.constraint(equalToConstant: 23),
      plusButton.heightAnchor.constraint(equalToConstant: 23)
    ])
  }

  private func configureLineView() {
    addSubview(lineView)
    NSLayoutConstraint.activate([
      lineView.topAnchor.constraint(equalTo: topAnchor),
      lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
      lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
      lineView.heightAnchor.constraint(equalToConstant: 1)
    ])
  }
}
