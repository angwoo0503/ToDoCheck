import UIKit

class ToDoDetailViewController: UIViewController {

    // 선택된 ToDo 항목을 저장하는 프로퍼티
    var toDo: ToDo?

    // 아울렛 연결: ToDo 제목, 생성 시간 표시를 위한 레이블
    @IBOutlet weak var toDoTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // UI 업데이트
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(didTapRightButton))
//        navigationItem.title = "할 일"
        updateUI()
    }
//    @objc func didTapRightButton() {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "CreateViewController")
//        navigationController?.pushViewController(vc, animated: true)
//    }
    // UI 업데이트 메서드
    private func updateUI() {
        // ToDo 제목 표시
        toDoTitle.text = toDo?.title
        // ToDo 생성 시간 표시
        if let date = toDo?.createdAt {
            timeLabel.text = DateFormatter.formatTodoDate(date: date)
        }
    }

    // 삭제 버튼 터치 시 호출되는 액션 메서드
    @IBAction func deleteButtonTapped(_ sender: Any) {
        // 삭제 확인 팝업 표시
        displayDeleteAlert()
    }

    // 삭제 확인 팝업 표시 메서드
    private func displayDeleteAlert() {
        let alertController = UIAlertController(title: "삭제하기", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        
        // 확인 액션 생성
        let addAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self, let toDo = self.toDo else { return }
            // 선택된 ToDo 항목 삭제
            ToDoManager.shared.delete(toDo: toDo) // 공유된 인스턴스 사용
            // 이전 화면으로 돌아가기
            self.navigationController?.popViewController(animated: true)
        }
        
        // 취소 액션 생성
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        // 액션 추가
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        // 팝업 표시
        present(alertController, animated: true, completion: nil)
    }
    
    // 편집 화면으로의 세그 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit",
           let editVC = segue.destination as? EditViewController {
            // 선택된 ToDo 항목 전달
            editVC.toDo = self.toDo
        }
    }
}
