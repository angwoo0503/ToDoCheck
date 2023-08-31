import UIKit

class EditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - Properties
    
    var toDo: ToDo?
    
    // UI 요소들
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        return label
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        return label
    }()
    
    private var categoryPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal) // 버튼 텍스트 색상 설정
        button.backgroundColor = UIColor(hex: "#0E62B0") // 버튼 배경색 설정
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // 버튼 텍스트 폰트 및 크기 설정
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()
    
    // 예제 카테고리 리스트
    private let categories = ["Study", "Work", "Personal", "Others"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        setupUI()
        configureContent()
    }
    
    // MARK: - UI 설정
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(categoryLabel)
        view.addSubview(categoryPicker)
        view.addSubview(saveButton)
        
        // 레이아웃 제약 조건 설정 (필요하다면 오토 레이아웃 사용 가능)
        titleLabel.frame = CGRect(x: 20, y: 120, width: view.frame.size.width - 40, height: 20)
        titleTextField.frame = CGRect(x: 20, y: titleLabel.frame.maxY + 10, width: view.frame.size.width - 40, height: 40)
        categoryLabel.frame = CGRect(x: 20, y: titleTextField.frame.maxY + 20, width: view.frame.size.width - 40, height: 30)
        categoryPicker.frame = CGRect(x: 20, y: categoryLabel.frame.maxY + 10, width: view.frame.size.width - 40, height: 200)
        saveButton.frame = CGRect(x: 20, y: categoryPicker.frame.maxY + 20, width: view.frame.size.width - 40, height: 50)
        
        NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                
                titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                categoryLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
                categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                
                categoryPicker.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
                categoryPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                categoryPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                saveButton.topAnchor.constraint(equalTo: categoryPicker.bottomAnchor, constant: 20),
                saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                saveButton.widthAnchor.constraint(equalToConstant: 350), // 버튼 넓이 설정
                saveButton.heightAnchor.constraint(equalToConstant: 50) // 버튼 높이 설정
            ])
    }
    
    // 기존 데이터로 UI 요소 초기화
    private func configureContent() {
        titleTextField.text = toDo?.title
        
        if let toDoCategory = toDo?.category, let index = categories.firstIndex(of: toDoCategory) {
            categoryPicker.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapSaveButton() {
        guard let toDo = toDo, let newText = titleTextField.text, !newText.isEmpty else { return }
        let selectedCategory = categories[categoryPicker.selectedRow(inComponent: 0)]
        
        // ToDo 항목 업데이트
        ToDoManager.shared.update(toDo: toDo, title: newText, category: selectedCategory)

        // 선택한 뷰 컨트롤러로 돌아가기 (옵션)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UIPickerView 데이터 소스 및 델리게이트 메서드
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
}
