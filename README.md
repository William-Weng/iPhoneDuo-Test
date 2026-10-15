# Duo 畫面切換測試

這個專案用來測試 iPhone 在直向／橫向切換時，如何顯示不同的 Duo 畫面版型。

主要透過 `DuoNavigationController` 統一觀察 interface orientation 與 horizontal size class 的變化，再通知目前顯示的 `DuoViewController` 切換對應的子畫面。

## 架構

```text
DuoNavigationController
└── DuoViewController（Container）
    ├── OutterPortraitViewController
    ├── OutterLandscapeViewController
    ├── InnerPortraitViewController
    └── InnerLandscapeViewController
```

- `DuoNavigationController`：負責偵測方向與 size class 變化，並保存最新的 `WWOrientationInformation`。
- `DuoViewController`：作為 Container，根據方向資訊切換不同的 child view controller。
- 各個子 VC：只負責自己的 XIB UI 與畫面互動。

## 畫面切換規則

| Horizontal Size Class | Orientation | 子畫面 |
| --- | --- | --- |
| Compact | Portrait | `OutterPortraitViewController` |
| Compact | Landscape | `OutterLandscapeViewController` |
| Regular | Portrait | `InnerPortraitViewController` |
| Regular | Landscape | `InnerLandscapeViewController` |

## 運作流程

1. `DuoNavigationController` 透過 `WWInterfaceOrientationCoordinator` 觀察方向與 size class 變化。
2. 變化發生時，將最新的 `WWOrientationInformation` 更新到 `orientationInformation`。
3. 透過 `callback` 通知目前顯示的 `DuoViewController`。
4. `DuoViewController` 依資訊選擇對應的 child view controller。
5. Container 移除舊的 child view controller，並加入新的 child view controller。

## 主要類別

### DuoNavigationController

負責協調方向變化：

```swift
final class DuoNavigationController: UINavigationController {
    var orientationInformation: WWOrientationInformation = .null
    var callback: ((WWOrientationInformation) -> Void)?
}
```

### DuoViewController

負責切換 Duo 子畫面：

```swift
final class DuoViewController: UIViewController {
    @IBOutlet private weak var containerView: UIView!
    
    private var currentViewController: DuoDelegate?
}
```

### DuoDelegate

所有可被 Container 顯示的子畫面都遵循此 protocol：

```swift
protocol DuoDelegate: UIViewController {
    func updateLabel(with text: String)
}
```

## 測試方式

1. 執行 App。
2. 旋轉 iPhone，觀察直向與橫向畫面的切換。
3. 在支援的裝置上測試 Split View、Slide Over 或不同視窗大小，確認 horizontal size class 變化時也能正確切換。
4. 觀察每個子畫面中的 label，確認方向變化後有收到最新的更新時間。