import Foundation

// ToDo 항목을 관리하는 싱글톤 클래스
class ToDoManager {
    static let shared = ToDoManager() // ToDoManager의 싱글톤 인스턴스
    
    private init() {
        loadToDos() // 앱 시작 시 데이터 로드
    }
    
    private let userDefaultsKey = "toDos" // UserDefaults에서 사용할 키
    
    private var toDos: [ToDo] = [] // ToDo 항목을 담을 배열
    
    // MARK: - 데이터 조작
    
    /// UUID를 활용하여 고유한 ID 생성
    func generateUniqueID() -> Int {
        return Int(UUID().uuidString.hashValue)
    }
    
    /// 데이터 로드 메서드
    func loadToDos() {
        guard let savedToDos = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let loadedToDos = try decoder.decode([ToDo].self, from: savedToDos)
            toDos = loadedToDos // 로드한 데이터를 toDos 배열에 할당
        } catch {
            print("toDos 디코딩 실패: \(error)")
        }
    }
    
    /// 데이터 저장 메서드
    func saveToDos() {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(toDos)
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        } catch {
            print("toDos 인코딩 실패: \(error)")
        }
    }

    // MARK: - CRUD 작업
    
    /// ToDo 항목 추가
    func addToDo(title: String, category: String) {
        // 우선순위 계산
        let priority = toDos.isEmpty ? 1 : (toDos.max(by: { $0.priority < $1.priority })?.priority ?? 0) + 1
        // 새로운 ToDo 생성
        let newToDo = ToDo(priority: priority, id: generateUniqueID(), category: category, title: title, done: false, createdAt: Date())
        // 배열에 추가하고 저장
        toDos.append(newToDo)
        saveToDos()
    }

    /// ToDo 항목 업데이트
    func update(toDo: ToDo, title: String, category: String) {
        if let index = toDos.firstIndex(where: { $0.id == toDo.id }) {
            // 해당 ToDo 항목 수정
            toDos[index].title = title
            toDos[index].category = category
            toDos[index].createdAt = Date()
            saveToDos()
        }
    }

    /// ToDo 항목 삭제
    func delete(toDo: ToDo) {
        // 해당 ToDo 항목을 배열에서 제거하고 저장
        toDos.removeAll(where: { $0.id == toDo.id })
        saveToDos()
    }

    /// 완료 상태 설정
    func setDoneStatus(toDo: ToDo, done: Bool) {
        if let index = toDos.firstIndex(where: { $0.id == toDo.id }) {
            // 해당 ToDo 항목의 완료 상태 수정하고 저장
            toDos[index].done = done
            saveToDos()
        }
    }

    // MARK: - 쿼리 메서드
    
    /// 완료된 ToDo 항목 조회
    func getDoneToDos() -> [ToDo] {
        return toDos.filter { $0.done }
    }

    /// 고유한 카테고리 목록 조회
    func uniqueCategories() -> [String] {
//        let categories = toDos.map { $0.category }
        return ["Work", "Study", "Personal", "Others"]
    }

    /// 특정 카테고리의 ToDo 항목 조회
    func toDos(inCategory category: String) -> [ToDo] {
        return toDos.filter { $0.category == category }
    }
}
