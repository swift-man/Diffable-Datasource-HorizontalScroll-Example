//
//  SectionHeaderReusableView.swift
//  Diffable-Datasource-HorizontalScroll-Test
//
//  Created by SwiftMan on 2022/10/07.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
  private let label = UILabel()
  private let subtitleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var sectionModel: SectionModel? {
    didSet {
      label.text = sectionModel?.title
      subtitleLabel.text = sectionModel?.subtitle
    }
  }
}

extension SectionHeaderReusableView {
  func configure() {
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
//    label.adjustsFontForContentSizeCategory = true

    NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: leadingAnchor),
        label.topAnchor.constraint(equalTo: topAnchor),
        label.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
//    label.font = UIFont.preferredFont(forTextStyle: .title3)
    
    addSubview(subtitleLabel)
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    subtitleLabel.textColor = .systemPink
    
    let inset = CGFloat(8)
    NSLayoutConstraint.activate([
      subtitleLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: inset),
      subtitleLabel.topAnchor.constraint(equalTo: topAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    backgroundColor = .systemBackground
  }
}
