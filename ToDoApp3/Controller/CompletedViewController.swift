import UIKit

class CompletedViewController: UIViewController {

    // 테이블 뷰 아울렛 연결
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 테이블 뷰 설정 초기화
        setupTableView()
    }

    // 테이블 뷰 설정 초기화 메서드
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        // 셀 등록
        tableView.register(CompletedListTableViewCell.self, forCellReuseIdentifier: "cell")

        // 테이블 뷰 리로드
        tableView.reloadData()
    }
}

// 테이블 뷰 데이터 소스 관련 extension
extension CompletedViewController: UITableViewDataSource {

    // 섹션별 ToDo 항목 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoManager.shared.getDoneToDos().count
    }

    // 셀 내용 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompletedListTableViewCell
        // 해당 위치의 완료된 ToDo 항목 설정
        cell.setToDo(ToDoManager.shared.getDoneToDos()[indexPath.row])
        return cell
    }
}

// 테이블 뷰 델리게이트 관련 extension
extension CompletedViewController: UITableViewDelegate {
    // 셀 선택 시 해제
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
