
/// This view will autolayout its height, even when used as a tableHeaderView or tableFooterView.

open class TableHeaderFooterView: UIView {

    fileprivate var tableView: UITableView? {
        return superview as? UITableView
    }

    fileprivate var status: Status {
        return self == tableView?.tableHeaderView ? .header :
            self == tableView?.tableFooterView ? .footer :
            .none
    }

    fileprivate enum Status {
        case header // is set as tableHeaderView
        case footer // is set as tableFooterView
        case none // is used as normal view elsewhere
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        switch status {
        case .header: defer { tableView?.tableHeaderView = self }
        case .footer: defer { tableView?.tableFooterView = self }
        case .none: return
        }

        var frame = self.frame
        let height = systemLayoutSizeFitting(CGSize(width: frame.width, height: UILayoutFittingCompressedSize.height), withHorizontalFittingPriority: 1000, verticalFittingPriority: 500).height

        frame.size.height = height
        self.frame = frame
    }
}
