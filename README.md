# 이 프로젝트는 ...

- MVVM 패턴을 지향하여 개발 하였습니다.
     
- 최초 기획상에서 사진 파일을 sqlite에 저장하는 서비스로 제공할 예정 + 단순 입출력 기능    
     ->  Controller (provider) -- datasource 사이의  Repository 생략.    
    
- 하지만 계획 변경으로 사진은 갤러리에서 관리하기로 바꾸었습니다. 이에 repository 를 추가해야 됩니다. -- 불필요해 보이는   패턴을 준수하는 것은 유지 보수 및 개선에 굉장히 중요하다.  

---
---

## 시연 동영상 링크
   

[![Watch the video](https://img.youtube.com/vi/XFZtYH1DdLQ/0.jpg)](https://youtu.be/XFZtYH1DdLQ)





---
<iframe width="560" height="315" src="https://www.youtube.com/embed/XFZtYH1DdLQ" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>














# 프로젝트 개요
-----
- 구성디자인 IPhone SE 시뮬레이터에서 적용. 기타 기기는 리팩토링 후 확인 예정

- 건강 지표관리 목표/기록관리 / 운동 목표 설정 : RivierPod old 버전.

- 운동계획 및 운동하러 가기 는 리팩토링하며 RiverPods 2.0 으로 상태관리 적용 예정.


다음의 기능등을 통해서  운동할때마다 켜서 함꼐 운동하는 appService .

- 건강 지표 관리 (키 / 체중 / BMI / 체지방량 / 골격근량)

- 운동 수행 능력 목표 설정.

- 운동 일정/계획 관리

- 운동 기록 관리.


-------------------
|2024 10 21
- 기존 작업 분량까지 리팩토링 완료
- train 파트는 codeGenerator 를 이용한 riverpod2 적용. 
- 과정에서 겪은 오류 및 학습 문서 opsydian hd 파트 2.5 페이지 확인.
- 이 부분에서 깃 분기점 나눠서 작업 필요.
- sportRecTable  필요 없음. 삭제 예정.

|2024 10 20
### 목표
- ~~DashBoard 기능/ 갤러리 기능 외 리팩토링 완료.~~ 


| 2024 10 19 
###  목표
- DashBoard 기능/ 갤러리 기능 외 리팩토링 완료. -> 
- riverpod 2.0 으로? 
    ➤ 올드버전이 생각보다 손 많이간다.
- Train /Sport 파트에서 변수값들을 입력하는 Alert 창들을 관리하는 Manage 클래스들에 대해서 고민이 필요함.
    ➤ Alert의 content에 들어가는 디자인을 클래스랑 같은 파일에 있는데 이게 생각보다 그렇게 가독성이 좋지 못한 듯 하다.
    ➤ 더욱이 MVVM 에서 이 View와 ViewModel이 같은 파일에 있는 것이 맞는가? class 만 구분하면 장땡인가. 에 대한 고민이 부족했다.
    ➤ 스캐폴드키로 불러내는게 더 낫겠다 싶을때가 종종 있다.



---
| 2024 10 18
### WorkReport
- ~~경구 수정중 빌드오류 아니고 Function 테스트 중 발생한 이슈. 해결~~



### 기획수정
- 기존 프로젝트 리팩토링 진행 진행중. 40% 완료.
- Image 저장 방식에 대한 고민.
    - 1. 이전 버전의 App  : localdb에 Unit8LIst 로 저장
    - ~~2. 새로 구상한 방식  감찻귝 드링킹 ver: 차후 online 으로 확장할 걸 고려해서 base64 로 저장~~
    - 3. 김치국 버린 방식  아이스 동치미 ver : 다운로드수가 10도 안넘을지도 모르는데 뭔 온라인.. 걍 갤러리에다 저장하고 db에는 파일 키 만 저장하는 방식.

    - 2번은 장점이 없다. 1vs3 
| 20204 10 17
### 해야할일

- 기존 프로젝트 리팩토링 진행 진행중. 40% 완료.
 - ~~파일 네이밍 규칠 준수 할 것.완료~~
- ~~변수명 네이밍 규칠 준수 할것......~~ 
    - ~~model 부분은 개선 완료~~
    - ~~전체 완료~~
- ~~Riverpods 2 를 사용할 것인가 말것인가 고민중. -> 다음 프로젝트떄 사용하자. 20241018~~




