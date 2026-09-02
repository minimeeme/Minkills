# Prism Cube

인터랙티브 아트 섹션에 올릴 자료. 사이트에 붙일 때 이 파일의 문구를 그대로 쓰면 됩니다.

## 자산

| | 파일 |
|---|---|
| 작품 (단일 HTML, 외부 의존성 없음) | `index.html` |
| 썸네일 4:3 · 2400×1800 | `thumbnail.png` |
| 썸네일 1:1 · 2000×2000 | `thumbnail-square.png` |

`index.html`은 라이브러리도 이미지도 참조하지 않는 단일 파일입니다. 그대로 복사해
`/art/prism-cube/index.html` 같은 경로에 두고 링크하거나 iframe으로 임베드하면 됩니다.

## 서체

제목 **PRISM CUBE** — PearToucan Bold
본문·UI — Paperlogy (Light 300 / Regular 400 / Medium 500 / SemiBold 600 / Bold 700)

두 서체 모두 이 페이지가 실제로 쓰는 글자만 남겨 서브셋한 뒤 WOFF2로 변환해
`index.html` 안에 data URI로 넣었습니다. 전체 6종 합쳐 약 54 KB이고, 외부 요청이 없습니다.

## 한 줄 소개

표면이 멈추지 않는 홀로그램 큐브. 여섯 면이 같은 은빛이라, 맞추는 일이 색을 외우는 일이 아니게 됩니다.

## 설명 (국문)

3×3×3 큐브 하나가 화면 가운데에서 천천히 굴러갑니다. 표면은 어느 순간에도 같은 모습이 아닙니다.
스물여섯 개의 조각이 저마다 은빛 크롬으로 빚어져 있고, 능선을 따라 얇은 무지개가 흐릅니다.
그 무늬는 미리 그려둔 이미지가 아니라 매 프레임 계산되는 것이라, 같은 장면이 두 번 나오지 않습니다.

일반적인 큐브라면 면마다 색이 정해져 있습니다. 이 큐브는 여섯 면이 같은 흰 바탕을 씁니다.
색을 외워서 맞추는 방식이 통하지 않고, 조각이 어디서 왔는지를 기억해야 합니다.
화면 아래 **면 색** 값을 올리면 면마다 옅은 색조가 돌아와 난이도가 내려갑니다.

면을 끌면 그 층이 돌고, 빈 곳을 끌면 큐브 전체가 돕니다.
**요동**은 표면이 흔들리는 폭을, **흐름**은 녹아내리는 속도를, **회전속도**는 층이 도는 시간을 정합니다.
여섯 면이 다시 하나가 되면 걸린 시간과 수가 남습니다.

## Description (EN)

A 3×3×3 cube turning slowly on a pale ground. Its surface never holds still — twenty-six
chamfered blocks of silvered chrome, each carrying a thin prismatic fringe along its creases.
Nothing is a texture map: every surface is computed per frame, so no two moments repeat.

An ordinary cube assigns a colour to each face. This one gives all six the same white ground,
which removes colour memory from the solve and leaves only the question of where a piece came
from. The **면 색 / face tint** control brings the identity back when you want it easier.

Drag a face to turn that layer, drag empty space to orbit. Built in raw WebGL — no libraries,
no images, one file.

## 화면

큐브 주변으로 그라디언트 도형들이 서로 다른 깊이에서 천천히 헤엄칩니다.
큐브보다 뒤에 있는 것은 큐브에 가려지고, 옆에 있는 것은 지나갑니다.

## 조작

- 면 드래그 → 그 층 회전 · 빈 공간 드래그 → 큐브 전체 회전
- `U` `D` `L` `R` `F` `B` 회전, `Shift`+키 반대 방향
- `Space` 섞기 · `Z` 되돌리기 · `Y` 다시 실행
- 컨트롤: 섞기 / 되돌리기 / 다시 실행 / 초기화 / 시점 리셋
- 슬라이더: 요동 · 흐름 · 회전속도 · 면 색

## 기술

Canvas WebGL 1.0, 단일 파일, 외부 의존성 없음.
큐비마다 정수 격자 위치와 회전 행렬을 들고 있어 방향이 정확히 떨어지고, 완료 판정은
여섯 방향의 바깥 스티커를 직접 읽습니다. 피킹은 모델 공간에서의 광선/상자 교차로 풀고,
드래그 방향을 화면에 투영한 네 접선과 맞춰 어느 시점에서도 같은 층이 돌아갑니다.
`prefers-reduced-motion`에서는 표면 시계가 멈추고 조작만 남습니다.

## 크레딧

Minji Lee · 2026
