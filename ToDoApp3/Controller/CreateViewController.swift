import UIKit

class CreateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // 예제 카테고리 리스트
    private let categories = ["Study", "Work", "Personal", "Others"]
    
    // UI Elements
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        return label
    }()

    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        return label
    }()

    private var categoryPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()

    private var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가하기", for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        categoryPicker.dataSource = self
        categoryPicker.delegate = self
    }

    // UI 요소를 설정하고 레이아웃하는 메서드
    private func setupViews() {
        view.backgroundColor = .white

        // 뷰에 요소들 추가
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(categoryLabel)
        view.addSubview(categoryPicker)
        view.addSubview(addButton)

        // Auto Layout 설정
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false

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
            
            addButton.topAnchor.constraint(equalTo: categoryPicker.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 350), // 버튼 넓이 설정
            addButton.heightAnchor.constraint(equalToConstant: 50) // 버튼 높이 설정
        ])
        
        // "추가하기" 버튼 스타일 설정
        addButton.backgroundColor = UIColor(hex: "#0E62B0") // 배경색 설정
        addButton.setTitleColor(.white, for: .normal) // 글씨색 설정
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // 버튼 텍스트 폰트 및 크기 설정
    }

    // "추가하기" 버튼을 눌렀을 때 호출되는 메서드
    @objc func addButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "제목은 비어있을 수 없습니다.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
            return
        }

        let category = categories[categoryPicker.selectedRow(inComponent: 0)]
        ToDoManager.shared.addToDo(title: title, category: category)
        navigationController?.popViewController(animated: true)
    }

    // UIPickerView Data Source & Delegate 메서드
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
