
import UIKit
import Reusable
import PureLayout

class CustomCell: UITableViewCell, Reusable {
    
    //MARK: - Create UIElements -
    var cellContentView = CustomCellContentView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func height() -> CGFloat {
        return 80
    }
    
    func setup(item: Job) {
        cellContentView.titleLabel.text         = item.title
        cellContentView.companyLabel.text       = item.company
        cellContentView.descriptionLabel.text   = item.description
        cellContentView.infoLabel.text          = item.info
    }
}

//MARK: - CustomCellContentView
class CustomCellContentView: UIView {
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        addAllUIElements()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Privat Methods -
    private func addAllUIElements() {
        addSubview(thumbImageView)
        addSubview(titleLabel)
        addSubview(companyLabel)
//        addSubview(descriptionLabel)
        addSubview(infoLabel)

        setConstraints()
    }
    
    private func setConstraints() {
        let inset: CGFloat = 10
        let width: CGFloat = 40

        thumbImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        thumbImageView.autoPinEdge(toSuperviewEdge: .left, withInset: inset)
        thumbImageView.autoSetDimensions(to: CGSize(width: width, height: width))

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: inset)
        titleLabel.autoPinEdge(.left, to: .right, of: thumbImageView, withOffset: inset)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: inset)

        companyLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        companyLabel.autoPinEdge(.left, to: .right, of: thumbImageView, withOffset: inset)
        companyLabel.autoPinEdge(toSuperviewEdge: .right, withInset: inset)
        
//        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
//        descriptionLabel.autoPinEdge(.left, to: .right, of: thumbImageView, withOffset: inset)
//        descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: inset)
        
        infoLabel.autoPinEdge(.top, to: .bottom, of: companyLabel, withOffset: inset)
        infoLabel.autoPinEdge(.left, to: .right, of: thumbImageView, withOffset: inset)
        infoLabel.autoPinEdge(toSuperviewEdge: .right, withInset: inset)
        infoLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: inset)
    }
    
    //MARK: - Create UIElements -
    lazy var thumbImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.image = UIImage(named: "img_map")
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel.newAutoLayout()
        view.textAlignment = .center
        view.textColor = UIColor.blue
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textAlignment = .left
        view.numberOfLines = 1

        return view
    }()

    lazy var companyLabel: UILabel = {
        let view = UILabel.newAutoLayout()
        view.textAlignment = .center
        view.textColor = UIColor.gray
        view.font = UIFont.systemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 1

        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel.newAutoLayout()
        view.textAlignment = .center
        view.textColor = UIColor.gray
        view.font = UIFont.systemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 2

        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let view = UILabel.newAutoLayout()
        view.textAlignment = .center
        view.textColor = UIColor.red
        view.font = UIFont.systemFont(ofSize: 12)
        view.textAlignment = .right
        view.numberOfLines = 1

        return view
    }()
}
