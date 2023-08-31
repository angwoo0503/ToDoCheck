import UIKit

class PetViewController: UIViewController {
    
    // 이미지를 표시할 UIImageView 아울렛 연결
    @IBOutlet weak var imageLabel: UIImageView!
    
    // 플레이스홀더 이미지 선언
    let placeholderImage = UIImage(named: "placeholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 플레이스홀더 이미지 표시 및 무작위 이미지 표시 호출
        showPlaceholderImage()
        showRandomImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면이 나타날 때마다 무작위 이미지 표시 호출
        showRandomImage()
    }
    
    // "사진 변경" 버튼을 눌렀을 때 호출되는 메서드
    @IBAction func showRandomImageTapped(_ sender: UIButton) {
        showRandomImage()
    }
    
    // 주어진 URL에서 무작위 이미지를 가져오는 메서드
    func fetchRandomImage(from urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    // 이미지 가져오기 중 오류가 발생한 경우 오류 메시지 출력
                    print("이미지 가져오기 오류: \(error)")
                    return
                }
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let imageUrlString = json.first?["url"] as? String,
                   let imageUrl = URL(string: imageUrlString),
                   let imageData = try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        // 이미지가 성공적으로 가져와지면 메인 스레드에서 이미지 표시 업데이트
                        self?.imageLabel.image = image
                    }
                }
            }
            task.resume()
        }
    }
    
    // 플레이스홀더 이미지를 UIImageView에 표시하는 메서드
    func showPlaceholderImage() {
        imageLabel.image = placeholderImage
    }
    
    // 무작위 이미지를 표시하는 메서드
    func showRandomImage() {
        // 고양이 또는 개 이미지 API 중 하나의 URL을 무작위 선택
        let randomAPI = ["https://api.thecatapi.com/v1/images/search", "https://api.thedogapi.com/v1/images/search"].randomElement()
        
        // 이미지 표시 작업 시작 전에 Placeholder 이미지 출력
        showPlaceholderImage()
        
        // 선택한 API에서 무작위 이미지 가져옴
        fetchRandomImage(from: randomAPI ?? "")
    }
}
