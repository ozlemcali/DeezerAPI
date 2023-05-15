import UIKit
import AVKit

protocol SongOutput {
    func changeLoading(isLoad: Bool)
    func saveSongs(songs: [Song])
}

class SongViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var songViewModel: SongViewModelProtocol = SongViewModel()
    private var songs: [Song] = []
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var player: AVPlayer?
    var song : Song?
    var albumID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        songViewModel.setDelegate(output: self)
        fetchSongs()
    }
    
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        title = "Songs"
        
    }
    func fetchSongs() {
            guard let albumID = albumID
        else {
                return
            }
        songViewModel.fetchSongsInAlbum(albumID: albumID)
        }
}

extension SongViewController: SongOutput {
   
    
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveSongs(songs: [Song]) {
        self.songs = songs
        tableView.reloadData()
    }
}

extension SongViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongViewCell
        cell.saveModel(model: songs[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? SongViewCell
               cell?.playSong()
    }
}

  

extension SongViewController {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
