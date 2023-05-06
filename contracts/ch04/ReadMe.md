# Chapter04. 스마트 컨트랙트에서 Dapp으로

00. 블록체인 네트워크의 아키텍처 모델
    - 블록체인 네트워크 -> 포트를 통해 -> 컴퓨터 시스템 하드웨어 -> 네트워크와 운영시스템(노드) -> 블록체인 프로토콜 구현(account) -> 웹 서버 코드, API, 스크립트를 통해 -> 가상머신 샌드박스 상의 스마트 컨트랙트 -> RPC 포트 -> 탈중앙화 애플리케이션 인터페이스(웹 브라우저)와 API를 통해 -> 탈중앙화된 행위자와 프로세스
    - 흐름을 말로 풀어보면, 맨 상단에 있는 사용자(행위자) 또는 사용자를 대신하는 프로세스가 UI함수를 호출한다. 이 함수는 웹 애플리케이션 소프트웨어와 블록체인 API를 사용해 스마트 컨트랙트 함수를 연결한다. 스마트 컨트랙트 함수 호출을 나타내는 Txs를 블록체인에 기록한다. 이러한 작동 흐름, 즉 행위자로부터 일관된 블록체인 기록은 블록체인 네트워크에 연결된 양쪽 노드 모두에서 일어난다. Dapp은 독립 실행형 애플리케이션이 아니라, 그것을 호스팅하고 있는 시스템의 파일 시스템, 포트, 네트워크 기능에 의존하고 있음을 알 수 있다.
    - 사용되는 기법들
        - 모든 Dapp 프로젝트에 필요한 웹 애플리케이션용 <project>-app 모듈과 스마트 컨트랙트용 <project>-contract 모듈
        - 웹 서버와 패키지 매니저(Node.js, npm)
        - web3 프로바이더로 불리는 블록체인 프로바이더
        - Dapp을 배포하고 테스트할 통합적인 환경을 제공하는 개발 도구
        - 메타마스크 브라우저 플러그인을 이용한 어카운트 관리

01. 트러플을 사용한 Dapp 개발
    - 트러플이란? 통합 Dapp 개발 환경과 테스팅 프레임워크를 제공하는 도구
        - Dapp을 위한 템플릿, 즉 기본 디렉터리 구조를 생성(truffle init)
        - 스마트 컨트랙트를 컴파일하고 배포(truffle compile)
        - 콘솔에서 테스트를 하기 위한 개인 블록체인 론칭(truffle develop)
        - 스마트 컨트랙트를 배포하기 위한 마이그레이션 스크립트 실행(truffle migrate)
        - Dapp UI 없이 테스팅하기 위한 커맨드 라인 인터페이스를 트러플에 오픈(truffle console)
        - 배포된 컨트랙트를 테스팅(truffle test)
    - 개발 과정
        1. 문제 설정을 분석하자. 설계 원칙과 UML 다이어그램을 이용해 솔루션을 설계하고 표현하자.
        2. 리믹스 웹 IDE를 사용해 스마트 컨트랙트를 개발하고 테스트하자.
        3. 트러플 IDE를 사용해 종단 간 Dapp을 코딩하고 테스트 블록체인에 배포해 테스트하고 나면, 메인 네트워크에 마이그레이션하자.
    - 트러플 설치
        - 운영 시스템 -> 리눅스 우분투 18.04, macOS, 윈도우 10
        - 클라이언트 인터페이스를 위한 웹 서버 -> Node.js
        - 패키지 매니저 -> npm
        - IDE -> truffle
        - 스마트 컨트랙트 언어 툴체인 -> solidity
        - 브라우저/웹 클라이언트 -> chrome, metamask plugin
        - 에디터 -> VScode
    - 소프트웨어 패키지 설치
        - 오퍼레이팅 시스템 설치 -> 리눅스(우분투 리눅스 LTS 버전), macOS(Homebrew), 윈도우
        - 브라우저 설치 -> 구글 크롬 설치
        - Node.js와 npm LTS을 다운로드 후 설치 -> node -v, npm -v로 설치확인
        - npm install -g truffle -> 오류 발생 시 npm install -g truffle@nodeLTS -> truffle version으로 확인
    - Dapp 스택 구축
        1. 로컬 블록체인 레이어를 설치 -> 가나쉬 설치
        2. 스마트 컨트랙트를 개발하고 배포 -> 트러플
        3. 웹 애플리케이션 UI를 개발 -> JS
        4. 웹 서버 환경 설정을 하고 UI와 스마트 컨트랙트를 연결하는 결합 코드를 개발 -> API와 RPC 포트

02. 가나쉬 테스트 체인 설치
    - 디폴트로 로컬 호스트에서 실행하도록 설정되어 있음.

03. 스마트 컨트랙트 개발
    - 프로젝트 폴더 만들기
        - mkdir ballot-contract
        - cd ballot-contract
        - truffle init
        - ls => contracts migrations test truffle-config.js
            - contracts: 스마트 컨트랙트를 위한 솔리디티 소스 파일.
            - migrations: 스마트 컨트랙트 배포를 위해 마이그레이션 시스템을 사용.
            - test: 스마트 컨트랙트를 위한 자바스크립트와 솔리디티 테스트
            - truffle-config.js: 트러플 설정 파일. 블록체인 네트워크 ID, IP, RPC 포트 번호 같은 설정 정보가 들어있음.
    - 스마트 컨트랙트 추가 및 컴파일
        - contracts 폴더에 Ballot.sol 파일 만들기
        - 루트 폴더에서 truffle compile 실행 -> 오류가 없을 시, 컴파일 아티팩트가 생성.
        - build/contracts 디렉터리에서 Ballot.json 파일이 생성되었는지 확인.
        - 오류가 있을 시
            1. Atom이나 gedit 같은 에디터를 열고 디버깅해서 저장한 후 compile 명령어 실행
            2. 리믹스 IDE를 사용하여 오류 부분 확인.
    - 블록체인 네트워크 설정(truffle-config.js)
        ```
            module.exports = {
                networks: {
                    development: {
                        host: "localhost",
                        port: 7545, // 가나쉬 클라이언트를 위한 RPC 포트
                        network_id: "5777"
                    }
                }
            }
        ```
    - 스마트 컨트랙트 배포
        - migrations 폴더에 2_deploy_contracts.js 파일 생성
        - truffle migrate --reset 실행 -> 재배포 실행하기 위해

04. 웹 애플리케이션을 개발하고 설정하기
    - 웹 클라이언트 프런트엔드 만들기
        - 사용자 상호작용을 위한 서버 콘텐츠를 렌더링하는 HTML, JS, CSS
        - index.js에 설정한 기본 엔트리 스크립트를 호스팅하기 위한 서버
        - 웹 서버와 웹 클라이언트를 연결하는 서버 코드 app.js
        - 부트스트랩과 web3 API와 같은 다른 프레임워크를 위한 추가적인 래퍼와 플러그인
        - 패키지 설정 파일, package.json
    - ballot-app 개발하기
        - mkdir ballot-app
        - cd ballot-app
        - npm init
        - root directory
            - index.js
            - package.json
            - src directory
        - npm install --save express
        - package.json 파일에서 scripts의 start를 node index.js로 변경
        - index.js 파일 작성
            ```
                const express = require('express');
                const app = express();
                app.use(express.static('src')); // src는 퍼블릭 웹 아티팩트를 위한 베이스 디렉터리
                app.use(express.static('../ballot-contract/build/contracts'));
                app.get('/', function (req, res) {
                    res.render('index.html');   // 이 파일은 웹 앱의 랜딩 페이지
                })
                app.listen(3000, function() { // 3000번 포트 번호
                    console.log('Example app listening on port 3000!');
                })
            ```
        - src 디렉터리
            - CSS directory
            - FONTS directory
            - IMAGES directory
            - JS directory
                - dist directory (다른 자바스크립트 라이브러리)
                - app.js (웹 서버 레이어와 스마트 컨트랙트 레이어를 연결하는 결합 코드)
            - index.html (웹 앱 랜딩 페이지)
    - 메타마스크 지갑 설치하기
        - 탈중앙화한 참여자를 식별하기 위해
        - 참여자가 트랜잭션을 전자적으로 서명하고 컨펌하기 위해
        - 처음 사용 시 네트워크 추가, 네트워크(Ganache), URL(http://localhost:7545), 네트워크ID(5777)
        - 메타마스크 설정 프로세스에 가나쉬 니모닉 복사 후 붙여넣기
    - 웹 클라이언트를 스마트 컨트랙트에 연결하기
        - app.js 파일 작성
        ```
            App = {
                url: 'http://127.0.0.1:7545', // web3 프로바이더 URL: IP주소와 RPC 포트

                init: function() {  // web3 개체를 가진 앱을 시작
                    return App.initWeb3();
                },

                initWeb3: function() {  // web3 프로바이더와 스마트 컨트랙트 설정
                    App.web3Provider = web3.currentProvider;
                    return App.initContract();
                },

                initContract: function() {  // 컨트랙트 개체 생성
                    App.contracts.vote.setProvider(App.web3Provider);
                    getJSON('Ballot.json', function(data) {
                        return App.bindEvents();
                    }
                },

                bindEvents: function() {    // UI 버튼을 스마트 컨트랙트 함수에 바인딩하는 핸들러
                    $(document).on('click', '.btn-vote', App.handleVote);
                    $(document).on('click', '#win-count', App.handleWinner);
                    $(document).on('click', '#register', App.handleRegister(ad));
                    ...
                },

                populateAddress: function() {},
                getChairperson: function() {},
                handleRegister: function(addr) {},
                handleVote: function(event) {},
                handleWinner: function() {}
            }
        ```
    - 되돌아보기
        - Dapp 설계와 개발 과정 주요 요소
            - 스마트 컨트랙트 설계
            - 프론트엔드 설계
            - 서버 사이드 결합 코드(app.js)
    - 베스트 프랙티스
        - 표준 디렉터리 구조를 사용하자.
        - 표준 네이밍 컨벤션을 사용하자.
        - 가나쉬는 리믹스 자바스크립트 VM이 생성한 시뮬레이팅된 환경이 아닌, 하나의 테스트 체인을 제공한다는 점을 염두에 두라.
        - 스마트 컨트랙트 마이그레이션에 있는 리셋 옵션을 염두에 두라.