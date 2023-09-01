# 프로젝트명
ToDo Check

# 프로젝트 설명
ToDo Check는 사용자가 할 일 목록을 관리하는 데 도움을 주는 애플리케이션입니다.  
  
사용자는 다양한 카테고리에 속하는 할 일을 추가, 수정, 삭제하고 완료 상태로 표시할 수 있습니다. 앱은 MVC 패턴을 따르며, 할 일 데이터를 관리하는 싱글톤 클래스, 할 일 목록을 표시하는 뷰 컨트롤러, 그리고 사용자 인터페이스를 담당하는 뷰로 구성되어 있습니다.

# 구조 설명
MVC Architecture

<p align="center"><img src="https://github.com/angwoo0503/ToDoCheck/assets/136118540/a657a825-25b8-4947-874d-906a51a1834b" width="400" height="300"/></p>

- Model: ToDoManager 클래스가 모델 역할을 합니다. 할 일 항목을 관리하고 데이터를 저장하고 로드합니다.
- View: 각각의 뷰 컨트롤러(ToDoListViewController, ToDoDetailViewController, CreateViewController, EditViewController, CompletedViewController)가 뷰 역할을 합니다. 사용자 인터페이스를 구성하고 데이터를 표시합니다.
- Controller: 각 뷰 컨트롤러가 컨트롤러 역할을 합니다. 사용자의 입력을 받고 모델 데이터를 업데이트하고 뷰에 표시될 데이터를 제공합니다.

# 프로젝트 Life Cycle 및 데이터 관리 설명


<p align="center"><img src="https://github.com/angwoo0503/ToDoCheck/assets/136118540/72e413f0-5b24-4adc-863b-e6060322d9a7" width="400" height="400"/></p>

## ToDo 앱의 라이프 사이클과 데이터 관리
앱의 Life Cycle과 데이터 관리는 사용자 경험을 향상시키기 위해 신중하게 설계되었습니다. 아래에서 앱의 주요 라이프 사이클 이벤트와 데이터 관리 방식에 대해 설명하겠습니다.

## ToDo 앱의 주요 라이프 사이클 이벤트
1. viewDidLoad: 각 뷰 컨트롤러가 처음 생성될 때 호출되는 메서드입니다. 이 메서드 내에서 초기화 및 설정 작업을 수행합니다. 예를 들어, 뷰 컨트롤러의 UI 요소를 설정하거나 초기 데이터를 불러오는 작업이 이루어집니다.

2. viewWillAppear: 뷰 컨트롤러가 화면에 나타나기 직전에 호출되는 메서드입니다. 이 메서드 내에서 뷰 컨트롤러의 데이터를 업데이트하거나 화면을 갱신하는 작업을 수행합니다. 예를 들어, 완료된 할 일 목록을 표시하는 경우, 이 메서드에서 데이터를 로드하고 테이블 뷰를 갱신합니다.

3. viewWillDisappear: 뷰 컨트롤러가 화면에서 사라지기 직전에 호출되는 메서드입니다. 이 메서드 내에서 변경된 데이터를 저장하거나 화면을 갱신하는 작업을 수행합니다. 예를 들어, 할 일을 추가하거나 수정한 후에는 이 메서드에서 데이터를 저장하여 변경 내용을 유지합니다.

## 데이터 관리 방식
앱의 데이터 관리는 ToDoManager 클래스를 통해 이루어집니다. 이 클래스는 싱글톤 패턴을 활용하여 앱 전역에서 사용되며, 할 일 항목의 추가, 수정, 삭제, 저장 및 로드를 담당합니다.

1. 할 일 추가: 사용자가 할 일을 추가할 때는 CreateViewController에서 입력한 내용을 받아와 ToDoManager의 addToDo 메서드를 호출하여 새로운 할 일을 추가합니다.

2. 할 일 수정: 사용자가 할 일을 수정할 때는 EditViewController에서 수정된 내용을 받아와 ToDoManager의 update 메서드를 호출하여 해당 할 일을 업데이트합니다.

3. 할 일 삭제: 사용자가 할 일을 삭제할 때는 ToDoDetailViewController에서 deleteButtonTapped 메서드를 호출하여 해당 할 일을 삭제합니다.

4. 데이터 저장 및 로드: 할 일 데이터는 앱의 라이프 사이클에 따라 UserDefaults를 활용하여 저장 및 로드됩니다. viewWillDisappear 메서드에서 데이터를 저장하고, viewWillAppear 메서드에서 데이터를 로드하여 화면에 반영합니다.

# 프로젝트 설치 및 실행 방법
1. 소스 코드를 다운로드하거나 복제합니다.
2. Xcode에서 프로젝트를 엽니다.
3. 시뮬레이터 또는 실제 기기에서 앱을 실행합니다.

# 프로젝트 사용 방법

1. 할 일 목록 화면에서 '추가' 버튼을 눌러 새로운 할 일을 추가합니다.
2. 제목을 작성하고 카테고리를 선택한 후 '추가하기' 버튼을 누릅니다.
3. 할 일 목록에서 할 일을 선택하면 상세 정보 화면으로 이동합니다.
4. 상세 정보 화면에서 할 일의 제목과 카테고리를 수정할 수 있습니다.
5. 상세 정보 화면에서 '삭제하기' 버튼을 누르면 할 일이 삭제됩니다.
6. 할 일 목록에서 완료된 할 일을 확인하려면 하단 탭바에서 '완료한 일' 탭을 선택합니다.

# 참고 자료

## 고양이 이미지 API
- The Cat API 홈페이지: https://thecatapi.com  
- The Cat API 문서: https://developers.thecatapi.com  
- 사용 API: https://api.thecatapi.com/v1/images/search  
## 강아지 이미지 API
- The Dog API 홈페이지: https://thedogapi.com  
- The Dog API 문서: https://developers.thedogapi.com  
- 사용 API: https://api.thedogapi.com/v1/images/search  

이 프로젝트는 Swift 언어와 UIKit 프레임워크를 사용하여 개발되었습니다.  
프로젝트의 구조와 사용법을 자세하게 설명하였습니다. 추가적인 질문이나 설명이 필요한 부분이 있다면 언제든지 문의해주세요!
