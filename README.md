# 📚 강의록 자동 생성기

> 다글로 녹음 트랜스크립트 + PDF 슬라이드 → AI가 자동으로 강의록 생성

![Windows](https://img.shields.io/badge/Windows-10%2F11-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ 주요 기능

- 🎙️ **자동 매칭**: 녹음 트랜스크립트와 PDF 슬라이드 자동 연결
- 🤖 **AI 정제**: 말버릇 제거, 문장 다듬기 (Claude AI)
- 🏷️ **키워드 추출**: 슬라이드별 핵심 키워드 자동 생성
- 📤 **다양한 내보내기**: Word, PDF, HTML, Markdown, 옵시디언, HWP

## 📋 요구사항

| 항목 | 요구사항 |
|------|----------|
| OS | Windows 10 / 11 |
| 브라우저 | Chrome, Edge, Whale |
| API | [Anthropic Claude API](https://console.anthropic.com) (유료) |

## 🚀 설치 및 실행

### 1. API 키 발급
1. [console.anthropic.com](https://console.anthropic.com) 접속 및 회원가입
2. Plans & Billing → 크레딧 충전 ($5 권장)
3. API Keys → Create Key → 키 복사해두기

### 2. 프로그램 다운로드
```
Code 버튼 → Download ZIP → 압축 해제
```

### 3. 실행
```
run.bat 더블클릭
```
- 브라우저가 자동으로 열립니다
- 안 열리면 http://localhost:7432 접속

## 📖 사용 방법

1. **API Key 설정**: 우측 상단 버튼 클릭 → API 키 입력
2. **트랜스크립트 입력**: 다글로 앱에서 복사한 텍스트 붙여넣기
3. **PDF 업로드**: 강의 슬라이드 PDF 파일 선택
4. **생성 시작**: 버튼 클릭 후 대기 (슬라이드 5개당 약 30초~1분)
5. **내보내기**: 원하는 형식으로 저장

## 📁 폴더 구조

```
lecture-tool-ps/
├── run.bat          ← 프로그램 실행 (이것만 클릭!)
├── setup.bat        ← 오프라인용 라이브러리 설치 (선택)
├── server.ps1       ← 서버 스크립트
├── index.html       ← 웹 인터페이스
└── libs/            ← 라이브러리 (setup.bat 실행 시 생성)
```

## 🔧 문제 해결

<details>
<summary><b>❌ "Your credit balance is too low" 오류</b></summary>

1. [console.anthropic.com](https://console.anthropic.com) 접속
2. Plans & Billing → Credits에서 잔액 확인
3. 크레딧 충전 후 1~5분 대기
4. API Keys에서 새 키 발급 후 재입력
</details>

<details>
<summary><b>❌ 브라우저가 안 열림</b></summary>

직접 브라우저 주소창에 `http://localhost:7432` 입력
</details>

<details>
<summary><b>❌ "index.html 파일을 찾을 수 없습니다"</b></summary>

모든 파일이 같은 폴더에 있는지 확인하세요.
</details>

<details>
<summary><b>❌ PDF 한글 깨짐</b></summary>

PDF 버튼 클릭 → 인쇄 다이얼로그 → "PDF로 저장" 선택
</details>

## 💰 비용 안내

- Claude API는 토큰 단위 과금
- 슬라이드 30장 기준: 약 $0.1 ~ $0.3
- 첫 충전 $5 권장 (많은 강의 처리 가능)

## 🤝 호환 STT 앱

다글로 외에도 텍스트 트랜스크립트를 제공하는 모든 앱 사용 가능:
- Naver CLOVA Note
- OpenAI Whisper
- Google 음성 인식
- Microsoft Teams 자막
- Zoom 자막

## 📄 라이선스

MIT License - 자유롭게 사용, 수정, 배포 가능

## 🙋 문의

이슈가 있으면 [Issues](../../issues) 탭에서 등록해주세요!
