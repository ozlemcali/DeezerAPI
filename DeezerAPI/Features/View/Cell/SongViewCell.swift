import UIKit
import AlamofireImage
import CoreData
import AVKit

class SongViewCell: UITableViewCell {

    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var songTime: UILabel!
    @IBOutlet var songName: UILabel!
    @IBOutlet var songImage: UIImageView!
    var song: Song?
    var isClicked = false
    private var player: AVPlayer?

    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    private let randomImage: String = "https://picsum.photos/200/300"
    
    func playSong() {
        guard let song = song else {
            return
        }
        if let previewURL = URL(string: song.preview ?? "") {
            player = AVPlayer(url: previewURL)
            player?.play()

            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                self.player?.pause()
                self.player = nil
            }
        }
    }
    func saveModel(model: Song) {
        songName.text = model.title
        songImage.af.setImage(withURL: URL(string: model.album.cover ?? randomImage) ?? URL(string: randomImage)!)
        let formattedDuration = formatDuration(seconds: model.duration)
        songTime.text = formattedDuration

    }
    func formatDuration(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }

    @IBAction func favoriButtonTapped(_ sender: Any) {
        if isClicked{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let favoriteSong = NSEntityDescription.insertNewObject(forEntityName: "FavoriteSongs", into: context)
            favoriteSong.setValue(songName.text!, forKey: "name")
            favoriteSong.setValue(songTime.text!, forKey: "time")
            
            
            favoriteSong.setValue(UUID(), forKey: "id")
            
            let data = songImage.image!.jpegData(compressionQuality: 0.5)
            favoriteSong.setValue(data, forKey: "image")
            
            do {
                try context.save()
                print("success")
            } catch {
                print("error")
            }
            NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
       
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        isClicked = !isClicked
    }
}
