# Chapter03. 신뢰와 무결성을 위한 기법

01. 신뢰와 무결성의 핵심
    - 신뢰와 무결성의 핵심
        - 신뢰: 시스템에 참여하는 피어 참여자의 신용에 대한 척도. 블록체인에서는 참여자의 관련 데이터와 트랜잭션에 관해 확인과 검증을 히ㅏ고, 이해 관계자들의 합의에 따라 적절한 정보를 변조
            - 확인(verification): 일반적인 규칙에 관한 것. 스마트 컨트랙트와 수정자를 이용해 실현
            - 검증(validation): 애플리케이션에 특정한 규칙에 관한 것. 스마트 컨트랙트와 수정자를 이용해 실현
            - 기록: 변조 불가능한 분산 블록체인 장부
            - 합의: 블록체인 프로토콜에 의해 정의
            - 확인과 검증은 어플리케이션 개발자로써 만들고, 이를 통해 기록하고 합의를 하여 신뢰를 구축
        - 무결성: 데이터의 보안과 프라이버시, 그리고 트랜잭션의 기밀성을 보장하는 것
            - 아이덴티티(identity): 스마트 컨트랙트와 수정자를 이용해 실현.
            - 보안(security): 암호학과 해시 알고리즘 기법을 사용. 스마트 컨트랙트와 수정자를 이용해 실현
            - 기밀성: 마이크로 페이먼트 애플리케이션에 기밀성 적용.
            - 프라이버시: 암호학과 해시 알고리즘 기법을 사용.
            - 아이덴티티와 보안은 어플리케이션 개발자로써 만들고, 이를 통해 기밀성을 유지하고, 프라이버시를 구축.
    - 전자 민주주의 문제(digital democracy)
        - 솔루션 설계하기
            - 유스 케이스 다이어그램 설계: 설계 원칙 1, 2, 3을 적용. 이 다이어그램을 이용해 사용자, 데이터 애셋, 트랜잭션을 식별. UML(유한 상태 머신), FSM(여러 조건에 의해 변화해 가는 스마트 컨트랙트의 상태 변화를 나타내기 좋다.)
            - 컨트랙트 다이어그램 설계: 설계 원칙 4를 사용해 데이터, 수정자, 확인과 검증을 위한 규칙, 함수를 정의
            - 코드의 점진적 개발: 점진적 단계를 거쳐 개발
                1. 스마트 컨트랙트의 데이터 구조를 정의하고 테스트
                2. constructor와 상태를 변화시키기 위한 함수 추가
                3. 스마트 컨트랙트의 다른 함수와 신뢰 구축을 위한 솔리디티 기능을 보여주기 위한 수정자 추가
                4. 신뢰 요소인 require(), revert(), assert()와 함수 접근 수정자를 추가
            - 스마트 컨트랙트 개발: 컨트랙트 다이어그램을 사용해서 개발
            - 배포 및 테스트: 개발 환경을 통해 스마트 컨트랙트를 컴파일, 배포, 테스트 진행.
                - 긍정 테스트: 유효한 입력값이 주어졌을 때, 스마트 컨트랙트는 기대한 바대로 올바르게 작동하는지.
                - 부정 테스트: 유효하지 않은 입력값이 주어졌을 때, 스마트 컨트랙트는 확인과 검증을 통해 오류를 잡아내고 함수를 중단하는지.
    - 베스트 프랙티스
        - 스마트 컨트랙트 코드는 간결하고 일관성 있고 감사하기 쉽도록 작성.
        - 정의한 각 상태 변수와 함수는 한 가지의 문제만을 다루도록 만들자.
        - 중복적인 데이터 또는 관계없는 함수를 포함하지 말아야 한다.
        - 함수 실행 시 가전 또는 사후 조건을 확인해야 할 필요가 있는 경우, 인라인(if/else) 코드 대신 커스텀 모디파이어를 사용함으로써 감사하기 쉽도록 만든다.
        - 함수 접근 수정자는 다음과 같은 경우 사용
            1. 모든 참여자의 데이터 접근을 위한 규칙, 정책, 규정을 구현할 때
            2. 함수에 접근할 수 있는 모든 참여자를 위한 공통 규칙을 구현할 때
            3. 애플리케이션에 특정한 조건을 선언적으로 검증할 때
            4. 스마트 컨트랙트의 정확성을 검증하기 위해 감사 가능한 요소를 제공하고자 할 때
        - 블록체인에 저장할 필요가 없는 로컬 변수는 memory 타입을 사용하자.
        - 스마트 컨트랙트를 점진적인 단계로 개발하고 매 단계마다 디버깅을 하자.
        - 솔리디티 언어는 성능과 보안 향상을 위해 자주 업데이트된다는 점을 잊지 말자. 최신 버전의 요구에 맞게 변경해야 한다.