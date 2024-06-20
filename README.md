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

## 🎯 What we focus on?
- [Tanya](https://github.com/seoyounghan) - Core Motion을 통해 센서 데이터를 받아서 앱을 만들어보기
- [Miles](https://github.com/by-h00n) - 실시간 데이터에 따라 변화하는 UI


## 💼 Use Case
**머리의 움직임으로 턱걸이 개수를 세어 주자**


## 🖼️ Prototype

|뷰|설명|
|------|---|
|![MainView](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M29-CoreMotion/assets/63441374/017033e4-e699-4b2b-98f6-90105e54fc21)|**MainView**<br><br>앱 시작 화면<br>start버튼을 통해 턱걸이 시작<br>우측 상단 버튼을 통해 기록 보기<br>목표 숫자 설정|
|![PullUpCountView](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M29-CoreMotion/assets/63441374/a587dd04-47e4-4c14-8909-704d2bfa0dca)|**PullUpCountView**<br><br>Count를 통해 풀업의 갯수를 보여줌<br>중앙 원들을 통해 목표에 얼마나 도달했는지 보여줌<br>stop버튼을 통해 결과 화면으로 이동|
|![ResultView](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M29-CoreMotion/assets/63441374/1ab28e43-9af3-45bf-ab60-149bef04133e)|**ResultView**<br><br>진행한 풀업의 갯수, 목표, 진행시간 보여주기|
|![ActivityView](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M29-CoreMotion/assets/63441374/0401dab1-da8a-45d6-9ba4-eb72cdb6e07d)|**ActivityView**<br><br>풀업의 기록들을 보여줌<br> 밀어서 삭제|


## 🛠️ About Code
**class PullUpCounter: ObservableObject** 에 대한 설명!!

- CMHeadphoneMotionManager()로 헤드폰 모션 메니저를 불러옴

```swift
var headphoneMotionManager = CMHeadphoneMotionManager()
```

- startUpdate()  → 헤드폰의 모션 정보를 받아오는 함수.
    - 디바이스에서 불러올 수 있는 경우 → 업데이트를 시작함
    - 헤드폰에서 데이터가 갱신되는 주기대로 업데이트를 통해 구문을 실행함
    - 지금은 가속도 받아오기 + 턱걸이 데이터 처리를 데이터 업데이트마다 하고 있습니다.

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

- 턱걸이 감지 부분
    - integralZ변수에 적분을 하는 값을 업데이트 합니다.(적분값은 속도 입니다.)
    - 적분 값의 최대값과 최솟값의 차이가 기준 값(threshold)를 초과하면 사용자가 올라가는 중일 때와 내려가는 중일 때 횟수를 0.5씩 증가시킵니다.
    - 내려가는 중에서 기준값을 넘긴다면, 최소 최댓값을 초기화해서 다음 카운팅을 준비합니다.

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
