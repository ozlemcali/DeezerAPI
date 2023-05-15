import UIKit

class FavoriteViewCell: UITableViewCell {

    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var favoriteSongImage: UIImageView!
    @IBOutlet var favoriteSongTime: UILabel!
    @IBOutlet var favoriteSongName: UILabel!
    var isClicked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        if isClicked {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        isClicked = !isClicked
    }
}
