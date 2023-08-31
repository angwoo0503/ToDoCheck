import UIKit

class CompletedListTableViewCell: UITableViewCell {

    var toDo: ToDo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 셀 초기화 코드
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 선택 시 뷰 구성 설정
    }
    
    // ToDo 항목 설정
    func setToDo(_ _toDo: ToDo) {
        toDo = _toDo
        updateTextLabel()
    }

    // 텍스트 레이블 업데이트
    private func updateTextLabel() {
        guard let toDo = toDo else { return }
        
        if toDo.done {
            textLabel?.text = nil
            textLabel?.attributedText = toDo.title.cancelLine() // 완료된 항목은 취소선을 표시
        } else {
            textLabel?.attributedText = nil
            textLabel?.text = toDo.title // 미완료된 항목은 일반 텍스트로 표시
        }
    }
}
