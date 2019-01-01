//
//  FeedDetailItemCell.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/31.
//  Copyright © 2018 Brad. All rights reserved.
//

import SwifterSwift
import DateToolsSwift

class FeedDetailItemCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var channelTitleLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    var feedItem: FeedItemProtocol? {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateAppearance() {
        titleLabel.text = feedItem?.itemTitle
        descLabel.text = feedItem?.description
        tagLabel.text = feedItem?.pubDate?.timeAgoSinceNow
    }
    
    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    private func updateBackgroundColor() {
        backgroundColor = isSelected ? UIColor(hex: 0x3E2D1F) : .white
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let width = Preference.viewByType == .row ? SwifterSwift.screenWidth : SwifterSwift.screenWidth / 2.0
        let targetSize = CGSize(width: width, height: 0)
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
        autoLayoutAttributes.frame = autoLayoutFrame
        return autoLayoutAttributes
    }
}
