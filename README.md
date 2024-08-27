# Bluearchive Daily quest

일퀘해주는놈

adb & .bat 연습용

<br>

## 목차
 - [준비물](#준비물)
 - [사용법](#사용법)
 - [기능](#기능)
    - [미지원 기능(추후 추가될수도)](#미지원-기능)
 - [TODO](#todo)
 - [띵킹중인것들](#매우몹시생각고려중)
 - [개발일지](#개발일지)
 - [마지막](#last)

<br>

## 준비물

 - 이 프로그램 zip [(릴리즈 예정)](https://github.com/taeseong14/blue_dq/releases/latest)
   - 포함: js 폴더, node_modules 폴더(13개 하위 폴더), auto_dq.bat, init_device.bat, ... (추가예정)
 - adb [(설치 링크)](https://developer.android.com/tools/releases/platform-tools?hl=ko)
 - node.js [(설치 링크)](https://nodejs.org/en/download/package-manager/current)

<br>

## 사용법

### [최초 사용]

> 설치

 - [준비물들](#준비물) 깔기
 - adb 폴더 안에 zip파일 압축해제 (`platform-tools > b_a > ~.bat` 파일이 있도록)

> 기기 페어링 (최초)

 - 핸드폰의 `개발자 옵션 > 무선 디버깅` 기능을 키고 `init_device.bat` 실행
 - 핸드폰에서 `페어링 코드로 기기 페어링` 버튼을 누르고 `IP 주소 및 포트` 부분에 나오는 `?.?.?.?:nnnnn` 부분에서 ?.?.?.?(ip)를 입력, nnnnn(port)를 입력 후 페어링 코드를 입력

> 사용자 맞춤

 - [!] 개발중
 - 스샷 찍어서 화면크기 들고오면 될듯


### 그 후 사용

 - `auto_dq.bat` 실행

<br>

## 기능


> 완성된 기능

테스트 끝난 기능들.

 - (1) 카페 ap 받기 ~~(ap 꽉차는걸 고려해야하나?)~~
 - (3) 서클 출석 (이미 돼있을경우 고려 v)
 - (5) 상점 구매 (미션위해 회색보고서만, 꼬우면 커스텀 ㄱ)
 - (6) 현상수배 (3중랜덤?)


> 개발중인 기능

 - [ ] (2) 카페 학생 터치 (터치 아이콘이 움직여서 픽셀 rgb 유사도 비교해야할듯...)
 - [X] (4) 제조 수령, 1개? (빠른 제조 -> 설명서같은곳에 적어놔야)
 - [X] (7) 학원교류회 (3중랜덤) - 완성, 내가 게헨나 빼고 D스테를 안깨서 임시로 게헨나 고정
 - [ ] ~~(8) 전술 대회 보상받기?~~ (<- 커스텀으로), 1회 돌기 (스킵 켜져있는지 확인 필요, sharp.js로)
 - [ ] (9) 미션 -> 모두 받기 (임무 x, 오전 -> 8개 [두번 받아야함])
 - [ ] (10) 우편 전부 받기 (ap 넘칠거 고려)
 - [ ] ~~(11) ap 어떤식이라도 소비하기~~ 생각고려중

 - [ ] (!) ap 받을때마다 넘치는거 생각고려


> 미지원/개발예정 기능

 - 사용자 맞춤 기능에 들어갈거
   - 상점 구매 항목 (일반 / 전술대회 상점)
   - 임무 (하드, 이벤?..) // 이벤은 업무 -> 좌상단에서 들갈거지만 여러개 있음 오류날수도
   - ap 충전
   - 밝기 낮추기 / 소리 끄기?
   - 스케쥴 학생 선택
 - 귀차니즘 모드같은거에 들어갈거
   - 스케쥴 랜덤?




## TODO:
 - [X] adb 연결
    - [X] init_device - pair
    - [X] auto_dq - auto connect
    - [ ] 마지막에 disconnect
 - [X] 앱 켜기
 - [X] 스크린 사이즈 들고오기
 - [X] 메인화면 들가기
 - [X] 출석보상, 메모리얼 스킵, 공지 x표, 공월/ap 수령, 아이템 만료 알림 치우기
 - [ ] [기능들](#기능)
 - [ ] 사용자 맞춤 (later)
    - [ ] 스크린 사이즈 조정
    - [ ] 딜레이(겜시작, 메인화면, 로딩) 조정
    - [ ] 임무 뭐돌릴지
    - [ ] ap 충전
    - [ ] 상점 구매 커스텀 (+전술대회 상점-ap)
    - [ ] 스케쥴 학생 선택
<br><br>

---
<br><br>

## 매우몹시생각고려중))

1. 전술대회....... 미션용 1회 입장만 하고 (sharp로 전투스킵 체크) 보상받는건 귀차니즘 모드에나 넣어야할듯 on-off를 넣던가

3. 상점 구매같은거 효율 찾아봐야함. 지금은 임시로 보고서 하나(미션용)만 사게 할것.

4. ms단위로 정지가 안먹음(ping, powershell command 등등). `./wait.js` 실행해서 100ms 멈추게 한게 유일한 방법.

5. 다른폰들 스크린사이즈 고려하기 귀찮으면 그냥 `adb shell wm size 1080x2340` 박아버리는게 나을수도? 끝나고 `adb shell wm size reset`만 안빼먹으면 충분히 고려해볼만한 선택지

<br><br>

---

<br><br>

## 개발일지

> 2024-08-23

올해에는 개발 못끝낼게 예상됨..   
.bat 두개 추가
<details><summary><code>더보기</code></summary>
<ul>
<li>init_device.bat: 기기 최초 페어링</li>
<img src="readme_imgs/2024-08-23_1.png" width="500">
<li>auto_dq.bat: 메인 인스턴스?</li>
<img src="readme_imgs/2024-08-23_2.png" width="500">
</ul>

 - adb pair 완성 (init_device.bat)
 - 대충 adb 연결이랑 블아 실행 완성
 - ip.txt 추가, settings.txt같은거 추가예정 (key=val format) 아님 json이라던가?
</details>


<br>

> 2024-08-25

js 폴더 추가
<details><summary><code>더보기</code></summary>
<img src="readme_imgs/2024-08-25_1.png" width="200">

 - sharp.js: 전술대회 스킵이 켜져있는가 확인용 (수정예정)
 - test.js: 카페에서 클릭해야 할 학생 위치 찾기용 (개발중)
 - ~~wait.js~~[->w.js]: 대충 ms단위 대기용
</details>

<br>

`wm size`로 스크린 wxh 들고게함
<details><summary><code>더보기</code></summary>
 <img src="readme_imgs/2024-08-25_2.png" width="500">

 - 스크린사이즈를 `adb shell wm size`로 직접 갖고오기로 햇음.
 - 화면 켜주는것도 추가(?). 사용자 맞춤 기능으로 넣을수도?
</details>

또 카페 학생 위치 파악 기능 개발중 [(test.js)](js/test.js)


<br>

> 2024-08-27

 - 어제 만든 기능들 테스트, 조율
 - 학원교류회 기능 추가, 아직 디버깅상태(안타깝게도.)


<br>

> 2024-08-28

 - 기능 타이밍 조정



<br><br>

---

<br><br>

<div id="last"></div>
블아뉴비+배치파일 연습용이라 먼가먼가 비효율적인것도 많을

기능 & 배치파일 개선점 있으면 좀 알려주쇼