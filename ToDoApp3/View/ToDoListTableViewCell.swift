import UIKit

// ToDo 항목을 보여주는 셀
class ToDoListTableViewCell: UITableViewCell {
    
    var toDo: ToDo?
    
    @IBOutlet weak var doneSwitch: UISwitch! // 완료 여부 스위치
    @IBOutlet weak var timeLabel: UILabel! // 생성 시간 레이블
    @IBOutlet weak var titleLabel: UILabel! // 제목 레이블
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 셀 초기화 코드
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 선택된 상태에 대한 뷰 구성
    }
    
    // ToDo 정보를 셀에 설정하는 메서드
    func setToDo(_ _toDo: ToDo) {
        toDo = _toDo
        updateCellContents()
    }
    
    // 셀 내용 업데이트 메서드
    private func updateCellContents() {
        guard let toDo = toDo else { return }
        
        // ToDo의 완료 여부에 따라 텍스트 스타일 변경
        titleLabel.attributedText = toDo.done ? toDo.title.cancelLine() : toDo.title.removeCancelLine()
        timeLabel.text = DateFormatter.formatTodoDate(date: toDo.createdAt)
        
        // 완료 여부에 따라 스위치 색상 변경 및 상태 설정
        doneSwitch.onTintColor = toDo.done ? UIColor(hex: "#0E62B0") : nil
        doneSwitch.isOn = toDo.done
    }
    
    // 완료 여부 스위치 클릭 이벤트
    @IBAction func doneSwitchTapped(_ sender: Any) {
        guard let toDo = toDo else { return }
        
        let isDone = doneSwitch.isOn
        // 완료 여부에 따라 텍스트 스타일 변경
        titleLabel.attributedText = isDone ? toDo.title.cancelLine() : toDo.title.removeCancelLine()
        ToDoManager.shared.setDoneStatus(toDo: toDo, done: isDone) // 공유 인스턴스 사용
        // 완료 여부에 따라 스위치 색상 변경
        doneSwitch.onTintColor = isDone ? UIColor(hex: "#0E62B0") : nil
    }
}

// NSAttributedString 확장: 취소선 적용
extension String {
    func cancelLine() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: self.count)
        )
        return attributeString
    }
    
    // 취소선 제거
    func removeCancelLine() -> NSAttributedString {
        let attributedString = NSAttributedString(string: self)
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
        mutableAttributedString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, mutableAttributedString.length))
        return mutableAttributedString
    }
}

// DateFormatter 확장: ToDo 생성 시간 포맷 변경
extension DateFormatter {
    static func formatTodoDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd - HH:mm:ss"
        return formatter.string(from: date)
    }
}

// UIColor 확장: 16진수 색상 생성
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
