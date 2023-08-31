import UIKit

class ToDoListViewController: UIViewController {
    
    // 선택된 ToDo 항목을 추적하는 프로퍼티
    var selectedToDo: ToDo?
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 뷰가 나타날 때 데이터 갱신 및 테이블 뷰 리로드
        reloadDataAndTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 뷰가 사라질 때 데이터 저장 및 테이블 뷰 리로드
        saveData()
        reloadDataAndTableView()
    }
    
    // 데이터 저장 메서드
    private func saveData() {
        ToDoManager.shared.saveToDos()
    }
    
    // 데이터 로드 및 테이블 뷰 갱신 메서드
    private func reloadDataAndTableView() {
        ToDoManager.shared.loadToDos()
        tableView?.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰의 delegate와 dataSource 설정
        tableView?.delegate = self
        tableView?.dataSource = self
        
        // UserDefaults에서 데이터 로드
        if let savedData = UserDefaults.standard.data(forKey: "toDos") {
            let decoder = JSONDecoder()
            do {
                let loadedToDos = try decoder.decode([ToDo].self, from: savedData)
                print(loadedToDos) // 로드된 데이터 출력
            } catch {
                print("toDos 디코딩 실패: \(error)")
            }
        } else {
            print("UserDefaults에서 데이터 찾을 수 없음")
        }
        
        // 데이터 로드 및 테이블 뷰 갱신
        reloadDataAndTableView()
    }

    // Segue 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? ToDoListTableViewCell else { return }
        if segue.identifier == "detail" {
            if let vc = segue.destination as? ToDoDetailViewController {
                vc.toDo = cell.toDo
            }
        }
    }
}

// 테이블 뷰의 데이터 소스 관련 extension
extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = ToDoManager.shared.uniqueCategories()[section]
        let toDosInSection = ToDoManager.shared.toDos(inCategory: category)
        return toDosInSection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoListTableViewCell
        let category = ToDoManager.shared.uniqueCategories()[indexPath.section]
        let toDosInSection = ToDoManager.shared.toDos(inCategory: category).sorted(by: { $0.priority < $1.priority })

        if indexPath.row < toDosInSection.count {
            cell.setToDo(toDosInSection[indexPath.row])
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ToDoManager.shared.uniqueCategories().count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedCategories = ToDoManager.shared.uniqueCategories().sorted() // 카테고리를 알파벳 순으로 정렬
        return sortedCategories[section]
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let category = ToDoManager.shared.uniqueCategories()[section]
        let footerLabel = UILabel()
        footerLabel.text = "총 \(ToDoManager.shared.toDos(inCategory: category).count)개의 항목이 있습니다."
        footerLabel.textAlignment = .center
        footerLabel.textColor = .gray
        return footerLabel
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
}

// 테이블 뷰의 델리게이트 관련 extension
extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
