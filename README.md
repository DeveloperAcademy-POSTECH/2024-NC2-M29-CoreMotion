# 2024-NC2-M29-CoreMotion

![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M29-CoreMotion/assets/63441374/dece1c1e-78f8-40ff-b071-f5206836291a)      
      


> Team 100Mile의 풀업 세기 어플 만들기 프로젝트


## ⚾️ 100Mile      
- 디자인 - [Miles](https://github.com/by-h00n)
- 개발 - [Tanya](https://github.com/seoyounghan)

## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About Core Motion
- **기기내에서 물리적 데이터 센서를 이용할 수 있는 기술**
- 지원 센서(기기에 따라서 지원하는 센서 다름)
    - 가속도계
    - 자이로스코프
    - 자력계
    - 보수계 및 피트니스
    - 운동 장애 관리
    - 침수 센서
- [공식문서](https://developer.apple.com/documentation/coremotion)

## 🎯 What we focus on?
- [Tanya](https://github.com/seoyounghan) - Core Motion을 통해 센서 데이터를 받아서 앱을 만들어보기
- [Miles](https://github.com/by-h00n) - 실시간 데이터에 따라 변화하는 UI


## 💼 Use Case
**머리의 움직임으로 턱걸이 개수를 세어 주자**


## 🖼️ Prototype

|뷰|설명|
|------|---|
|![MainView](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M29-CoreMotion/assets/63441374/017033e4-e699-4b2b-98f6-90105e54fc21)|**MainView**<br><br>앱 시작 화면<br>start 버튼으로 턱걸이 시작<br>우측 상단 버튼으로 기록 보기<br>목표 숫자 설정|
|![PullUpCountView](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M29-CoreMotion/assets/63441374/a587dd04-47e4-4c14-8909-704d2bfa0dca)|**PullUpCountView**<br><br>Count로 풀업 갯수 표시<br>중앙 원들로 목표 달성도 표시<br>stop 버튼으로 결과 화면으로 이동|
|![ResultView](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M29-CoreMotion/assets/63441374/1ab28e43-9af3-45bf-ab60-149bef04133e)|**ResultView**<br><br>진행한 풀업 갯수, 목표, 진행 시간 표시|
|![ActivityView](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M29-CoreMotion/assets/63441374/0401dab1-da8a-45d6-9ba4-eb72cdb6e07d)|**ActivityView**<br><br>풀업 기록 표시<br> 밀어서 삭제|




## 🛠️ About Code

### PullUpCounter: ObservableObject 클래스 설명

#### 헤드폰 모션 매니저 초기화
CMHeadphoneMotionManager()를 사용하여 헤드폰 모션 매니저를 초기화합니다.

```swift
var headphoneMotionManager = CMHeadphoneMotionManager()
```

#### startUpdates() 함수
헤드폰 모션 정보를 받아오는 함수입니다.

- 디바이스에서 불러올 수 있는 경우 업데이트를 시작합니다.
- 헤드폰에서 데이터가 갱신되는 주기대로 업데이트를 통해 구문을 실행합니다.
- 현재는 가속도 데이터를 받아와서 턱걸이 데이터를 처리합니다.

```swift
func startUpdates() {
    if headphoneMotionManager.isDeviceMotionAvailable {
        headphoneMotionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let self = self, let motion = motion, error == nil else { return }

            self.accelData = motion.userAcceleration
            self.processAccelData(motion.userAcceleration)
            if headphoneMotionManager.isDeviceMotionActive {
                isHeadPhoneDetected = true
            }
        }
    } else {
        stopUpdates()
        print("not available")
    }
}
```

#### 턱걸이 감지 함수
턱걸이를 감지하는 로직입니다.

- `integralZ` 변수에 적분 값을 업데이트합니다. (적분 값은 속도)
- 적분 값의 최대값과 최솟값의 차이가 기준 값(threshold)을 초과하면, 사용자가 올라가거나 내려갈 때 횟수를 0.5씩 증가시킵니다.
- 내려갈 때 기준 값을 넘으면, 최소/최대 값을 초기화하여 다음 카운팅을 준비합니다.

```swift
private func processAccelData(_ acceleration: CMAcceleration) {
    let currentAccelZ = acceleration.z
    let dt = 0.04

    integralZ += ((currentAccelZ + lastAccelZ) * 0.5 * dt)
    lastAccelZ = currentAccelZ

    if integralZ > maxIntegralZ {
        maxIntegralZ = integralZ
    }

    if integralZ < minIntegralZ {
        minIntegralZ = integralZ
    }

    let goingUp = currentAccelZ > 0

    if (maxIntegralZ - minIntegralZ) > threshold {
        if !pullUpInProgress && goingUp {
            pullUpCount += 0.5
            print("Pull-Up Count: \(pullUpCount)")
            pullUpInProgress = true
        } else if pullUpInProgress && !goingUp {
            minIntegralZ = integralZ
            maxIntegralZ = integralZ
            pullUpInProgress = false
        }
    }
    lastIntegralZ = integralZ
}
```
