# Send App Usage Permission

After WWDC 2019 Apple [updated](https://developer.apple.com/app-store/review/guidelines/#5.1) the App Store Guidelines 
> Guideline 5.1.1(i). Apps must get consent for data collection, even if the data is considered anonymous at the time of or immediately following collection.

> (ii) Permission Apps that collect user or usage data must secure user consent for the collection, **even if such data is considered to be anonymous** at the time of or immediately following collection.

Inspired [WWDC App](https://itunes.apple.com/app/wwdc/id640199958?mt=8) I made class to help developers & community save time and comply with the App Store Guidelines.

<img width="250" src="/screens/IMG_0855.PNG"> <img width="250" src="/screens/IMG_3825.PNG">

## Installation

Just drag and drop it to your project.

## Usage

### Display Alert

Put this code in viewDidAppear

```swift
  override func viewDidAppear(_ animated: Bool) {
        if !AppUsagePermission.isAsked(){
            AppUsagePermission.displayAlert(viewController: self, completionHandler: nil)
        }

    }
```

### сompletionHandler

```swift 
AppUsagePermission.displayAlert(viewController: self, completionHandler: { result in
                if (result == PermissionStatus.allowed){
                    print("User allowed data usage")
                } else if (result == PermissionStatus.denied){
                    print("User denied data usage")
                }
            })
```
### Get permission statuses

```swift
switch(AppUsagePermission.status()){
        case .allowed:
           print("Permission given")
        case .denied:
            print("Permission denied")
        case .notAsked:
             print("Data usage permission is not yet requested")
        case .undefined:
            print("Something went wrong")
        }
 ```
 
 ```swift
 enum PermissionStatus{
    case allowed
    case denied
    case notAsked
    case undefined
}
 ```
 
 ### Quck access functions
 ```swift 
  if AppUsagePermission.isAsked(){
    print("Dalogue has been already presented to user")
  }
```

```swift 
  if AppUsagePermission.isAllowed(){
    print("Send App Data Usage is allowed")
  }
```

 ### Reset saved value
  ```swift 
     AppUsagePermission.resetValue()
  ``` 
  
## Credits
[@kasabulatov](https://twitter.com/snake302)


## License

Fell free to use, share and modify
 
