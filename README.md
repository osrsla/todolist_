# NBC My Todo List App - Random Cat version

- 할일(Task)을 추가하고 관리하는 간단한 앱에 랜덤으로 고양이🐈 사진을 불러오는 페이지를 추가하였습니다.
- UserDefaults를 이용해 추가한 할일을 저장하고, UrlSession을 이용해 이미지 파일을 불러왔습니다.
- 앱 아이콘 및 런치스크린을 추가하였습니다.
- MVC 모델을 기반으로 모듈을 관리하고 뷰컨트롤러의 라이프사이클을 고려했습니다.

<img width="1440" alt="Screenshot 2023-09-01 at 1 01 23 PM" src="https://github.com/osrsla/todolist_/assets/139095139/9c4e4713-e393-4290-8f5e-de797234e532">



## 프로젝트 구조 - MVC 아키텍처

<img width="566" alt="Screenshot 2023-09-01 at 12 53 18 PM" src="https://github.com/osrsla/todolist_/assets/139095139/63d76ac6-995b-4cef-aca0-dbabc84fd9d0">

### AppDelegate.swift

- 앱의 라이프사이클을 처리하고 주 창을 초기화

### Utils

앱 전체에서 공통 기능을 제공하는 유틸리티 파일: 

- `NetworkError.swift`: 사용자 정의 네트워크 오류 유형을 정의
- `UIImageView+Extension.swift`: `UIImageView`를 확장하여 이미지 로딩 및 캐싱을 위한 메서드 추가

### Models

앱의 데이터 모델:

- `Task.swift`: `id`, `title`, `isCompleted`, `category`와 같은 속성 제공
- `TaskList.swift`: 작업 목록을 관리하며 작업의 생성, 업데이트 및 범주별 필터링을 처리

### Views

사용자 정의 UI 구성 요소:

- `TaskCell.swift`: 작업 정보를 표시하기 위한 사용자 정의 테이블 뷰 셀을 정의
- `TaskHeaderView.swift`: 테이블 뷰에서 작업 섹션에 대한 사용자 정의 헤더 뷰를 제공

### ViewControllers

뷰 컨트롤러:

- `HomeViewController.swift`: 앱의 홈 인터페이스를 표시
- `TaskViewController.swift`: tableView로 작업 나열, 완료 처리 또는 편집 옵션을 제공
- `DetailViewController.swift`: 선택한 작업에 대한 상세 정보를 표시
- `EditViewController.swift`: 작업 세부 정보를 편집하고 업데이트
- `DoneViewController.swift`: tableView로 완료된 작업 나열
- `CatViewController.swift`: 랜덤 고양이 사진 표시




## 뷰 컨트롤러 Life Cycle

각 뷰 컨트롤러의 생명주기 메서드로 데이터를 불러오고 관리

- viewDidLoad

뷰 컨트롤러가 처음으로 로드될 때 호출. 초기 설정 및 데이터 불러오기. 예를 들어, `HomeViewController`에서는 사용자의 작업 목록을 초기화하고 표시

- viewWillAppear

뷰 컨트롤러가 화면에 나타나기 직전에 호출. 화면이 갱신되기 전에 데이터를 업데이트하거나 리로드. 예를 들어, `TaskViewController`에서는 작업 목록이 화면에 나타날 때마다 최신 데이터로 갱신

- viewWillDisappear

`viewWillDisappear` 메서드는 뷰 컨트롤러가 화면에서 사라지기 직전에 호출. 변경된 데이터를 저장하거나 리소스를 해제. 예를 들어, `EditViewController`에서는 작업 세부 정보를 편집한 후 뷰가 사라질 때 변경 사항을 저장
