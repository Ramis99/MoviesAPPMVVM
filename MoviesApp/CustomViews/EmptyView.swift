import UIKit

class EmptyView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.isHidden = true
        self.isUserInteractionEnabled = false
    }
    
    func show() {
        self.isHidden = false
        self.isUserInteractionEnabled = true
    }
    
    func hide() {
        self.isHidden = true
        self.isUserInteractionEnabled = false
    }
}
