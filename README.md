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

> 개발중인 기능

 - [ ] 카페 ap 받기 (ap 꽉차는걸 고려해야하나?), 학생 터치
 - [ ] 서클 출석 (이미 돼있을경우 고려)
 - [ ] 제조 수령, 1개? (빠른 제조 -> 설명서같은곳에 적어놔야)
 - [ ] 상점 구매 (미션위해 회색보고서만, 꼬우면 커스텀 ㄱ)
 - [ ] 현상수배 (3중랜덤?)
 - [ ] 학원교류회 (3중랜덤??)
 - [ ] 전술 대회 보상받기?, 1회 (스킵 켜져있기를 희망)
 - [ ] 미션 -> 모두 받기 (임무 x, 오전 -> 8개 [두번 받아야함])


> 미지원/개발예정 기능

 - 사용자 맞춤 기능에 들어갈거
    - 임무 (하드, 이벤?..) // 이벤은 업무 -> 좌상단에서 들갈거지만 여러개 있음 오류날수도
    - ap 충전
 - 귀차니즘 모드같은거에 들어갈거
    - 스케쥴 랜덤?




## TODO:
 - [X] adb 연결
    - [X] ip.txt ? read : input->write
    - [X] adb not connected -> input port, connect
    - [ ] 마지막에 disconnect
 - [X] 메인화면 들가기
 - [ ] 출석보상, 메모리얼 스킵, 공월/ap 수령, 공지 x표, 아이템 만료 알림 치우기
 - [ ] [기능들](#기능)
 - [ ] 사용자 맞춤 (later)
    - [ ] 스크린 사이즈 조정용
    - [ ] 딜레이(겜시작, 메인화면, 로딩) 조정
    - [ ] 임무 뭐돌릴지
    - [ ] ap 충전
    - [ ] 상점 구매 커스텀 (+전술대회 상점-ap)
    - [ ] 사용자 맞춤 테스트들
        - [X] 스크린 사이즈 확인
<br><br>

---
<br><br>

## 매우몹시생각고려중))

1. 전술대회.......

2. 인풋같은거   
adb screencap -> pull 으로 스샷 갖고와서 사진분석..은 가능하지만   
쓸일이 없기를 바람
+ :

3. 상점 구매같은거 효율 찾아봐야함. 지금은 임시로 보고서 하나(미션용)만 사게 할것.

4. ms단위로 정지가 안먹음(ping, powershell command 등등). `./wait.js` 실행해서 100ms 멈추게 한게 유일한 방법.

<br><br>

---

<br><br>

## 개발일지

> 2024-08-23

올해에는 개발 못끝낼게 예상됨..
<details><summary><code>이미지</code></summary>
<ul>
<li>init_device.bat</li>
<img src="readme_imgs/2024-08-23_1.png" width="400">
<li>auto_dq.bat</li>
<img src="readme_imgs/2024-08-23_2.png" width="400">
</ul>
</details>

 - adb pair 완성 (init_device.bat)
 - 대충 adb 연결이랑 블아 실행 완성
 - ip.txt 추가, settings.txt같은거 추가예정 (key=val format) 아님 json이라던가?

<br>

> 2024-08-25

js 폴더 추가
<details><summary><code>이미지</code></summary>
<img src="readme_imgs/2024-08-25.png" width="200">
</details>

 - sharp.js: 전술대회 스킵이 켜져있는가 확인용 (수정예정)
 - test.js: 카페에서 클릭해야 할 학생 위치 찾기용 (개발중)
 - wait.js: 대충 ms단위 대기용


<br><br>

---

<br><br>

<div id="last"></div>
블아뉴비+배치파일 연습용이라 먼가먼가 비효율적인것도 많을

기능 & 배치파일 개선점 있으면 좀 알려주쇼