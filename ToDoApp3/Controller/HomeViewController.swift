import UIKit

class HomeViewController: UIViewController {

    // 이미지를 표시하는 이미지 뷰 아울렛 연결
    @IBOutlet weak var imageLabel: UIImageView!
    
    // 화면이 로드되었을 때 호출되는 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 탭 바 아이템의 색상을 설정
        tabBarController?.tabBar.tintColor = UIColor(hex: "#0E62B0")
        
        // 네비게이션 바의 배경색을 설정
        UINavigationBar.appearance().barTintColor = UIColor.white

        // 이미지 URL 생성
        if let imageUrl = URL(string: "https://ifh.cc/g/K3akcB.png") {
            // 이미지를 다운로드하고 설정
            if let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                imageLabel.image = image
            }
        }
    }
}

