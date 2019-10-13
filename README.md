## 毛孩手帳 PetNote
[App Store 下載](https://apps.apple.com/tw/app/id1481393644) 

### 寵物切換功能 BaseSwitchPetViewController / SwitchPetView

<img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/switch_pet.jpg" width="200" alt="寵物切換條"/>

1. 設計 BaseSwitchPetViewController 控制寵物切換條的內容、點選，讓其他有使用到寵物切換功能的 VC 繼承
2. 使用 KVO 觀察目前選取到的寵物、寵物資料列表，即時得知選取寵物、使用者對寵物資料做的改變
3. 利用 typealias 擴充 SwitchPetViewControllerProtocol 的功能到繼承的 VC 上，讓其他 VC 可以對應寵物資料的改變顯示在畫面上

### 毛孩檔案 ProfileDetailViewController / ProfileDetailView

<img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/home.png" width="200" alt="首頁"/>

1. 用 containerView 顯示不同功能的畫面
2. 用自定義的 SelectionView 控制子功能畫面的切換
3. 設計 BaseContainerViewController 讓子功能 VC 繼承，方便傳遞寵物切換的資訊
4. 用 singleton 模式設計 StorageManager 管理 Coredata 的存取刪除
5. 拆分寵物的相關資料諸如基本資料、預防計畫、體重紀錄、症狀紀錄於不同的 entities 並利用 relationship 關聯彼此

#### 基本資料 BasicInfoViewController / ModifyBaseInfoViewController / AdjustPhotoViewController

1. 提供寵物資料的修改和刪除功能，透過 delegate 獲得使用者操作的結果

<img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/photo_resize.gif" width="200" alt="照片調整"/>

2. 提供大頭照的選取，並透過擷取使用者調整後的照片在 view 上顯示的範圍完成照片調整的功能
3. 透過 FileManager 將大頭照檔案存在 app 所在的資料夾下，core data 只儲存該照片的路徑

#### 添加預防計畫 ProtectPlanViewController / AddingProtectPlanViewController

<img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/protect_plan_cat.png" width="200" alt="預防計畫"/> <img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/protect_plan_dog.png" width="200" alt="預防計畫2"/>

1. 根據所選擇寵物的類別提供相對應的預防計畫選項
2. 客製化的提醒通知，提供通知頻率、時間日期及提醒內容文字的調整

#### 體重記錄 WeightRecordViewController

<img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/weight_record.png" width="200" alt="照片調整"/>

1. 藉由 Charts 套件列出視覺化的體重曲線
2. 用 sortedArray function 排列 core data 取出的資料

### 症狀記錄 RecordViewController / AddRecordViewController

<img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/daily_record.png" width="200" alt="症狀記錄"/>

1. 透過 FSCalendar 套件讓使用者用視覺化的方式選擇紀錄的時間、查找過往紀錄

### 醫院搜尋 SearchHospitalViewController / SearchHospitalResultViewController / MapViewController

<img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/hospital_list.png" width="200" alt="醫院搜尋"/> <img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/hospital_map.png" width="200" alt="醫院地圖"/>

1. 將台灣地區資料寫成 TaiwanArea.json 檔，下拉選單內容透過讀取 json 檔資料取得
2. 利用政府公開資料查詢指定區域的醫院
3. 用 CoreLocation 將地址轉成座標並用 Google Map SDK 將醫院顯示在地圖上
4. 自定義 InfoWindow 顯示醫院名字，管理 InfoWindow 點擊，導向地圖 app 進行路線規劃

<img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/hospital_navigation.png" height="400" alt="導航"/> <img src="https://github.com/angelcic/PetNote/blob/develop/petnote_screenshot/hospital_navigation_google.png" height="400" alt="估狗導航"/>

5. 判斷使用者手機中是否有 Google Map 或是 Apple Map 而選則跳轉至哪個 app 若兩者皆無則導向 Apple Store




