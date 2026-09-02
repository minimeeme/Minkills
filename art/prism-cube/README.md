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
조작 안내 한 줄 — Pretendard (Light 300 / Regular 400)

세 서체 모두 이 페이지가 실제로 쓰는 글자만 남겨 서브셋한 뒤 WOFF2로 변환해
`index.html` 안에 data URI로 넣었습니다. 전체 8종 합쳐 약 65 KB이고, 외부 요청이 없습니다.
조작 안내는 한 번 읽고 나면 잊히는 줄이라, 나머지보다 작고 조용한 얼굴을 씁니다.

## 한 줄 소개

표면이 멈추지 않는 홀로그램 큐브. 여섯 면이 같은 은빛이라, 맞추는 일이 색을 외우는 일이 아니게 됩니다.

## 설명 (국문)

3×3×3 큐브 하나가 화면 가운데에서 천천히 굴러갑니다. 표면은 어느 순간에도 같은 모습이 아닙니다.
스물여섯 개의 조각이 저마다 은빛 크롬으로 빚어져 있고, 능선을 따라 얇은 무지개가 흐릅니다.
그 무늬는 미리 그려둔 이미지가 아니라 매 프레임 계산되는 것이라, 같은 장면이 두 번 나오지 않습니다.

일반적인 큐브라면 면마다 색이 정해져 있습니다. 이 큐브는 여섯 면이 같은 흰 바탕을 씁니다.
색을 외워서 맞추는 방식이 통하지 않고, 조각이 어디서 왔는지를 기억해야 합니다.

면을 끌면 그 층이 돌고, 빈 곳을 끌면 큐브 전체가 돕니다.
휠이나 핀치로 조금 당기고 밀 수 있습니다. 여섯 면이 다시 하나가 되면 걸린 시간과 수가 남습니다.

## Description (EN)

A 3×3×3 cube turning slowly on a pale ground. Its surface never holds still — twenty-six
chamfered blocks of silvered chrome, each carrying a thin prismatic fringe along its creases.
Nothing is a texture map: every surface is computed per frame, so no two moments repeat.

An ordinary cube assigns a colour to each face. This one gives all six the same white ground,
which removes colour memory from the solve and leaves only the question of where a piece came
from.

Drag a face to turn that layer, drag empty space to orbit, scroll or pinch to pull in a little.
Built in raw WebGL — no libraries, no images, one file.

## 화면

큐브 주변으로 그라디언트 도형들이 서로 다른 깊이에서 천천히 헤엄칩니다.
큐브보다 뒤에 있는 것은 큐브에 가려지고, 옆에 있는 것은 지나갑니다.
확대·축소하면 가까운 도형이 먼 도형보다 크게 벌어져, 깊이가 눈에 보입니다.

큐브 전체를 돌리면 배경도 함께 돕니다. 다만 같은 각도로 돌지는 않습니다 —
큐브 곁에서 헤엄치는 것은 거의 따라오고, 깊이 물러난 것은 겨우 미동합니다.

## 조작

- 면 드래그 → 그 층 회전 · 빈 공간 드래그 → 큐브 전체 회전
- 휠 · 핀치 → 확대·축소 (`+` `−` 키도 같음)
- 키보드의 3×3 블록이 큐브의 아홉 층에 그대로 대응합니다. 줄마다 한 축이고,
  세 키가 큐브를 가로질러 순서대로 놓여 가운데 키가 가운데 층을 돌립니다.
  `Shift`+키는 반대 방향입니다.

  | | | | |
  |---|---|---|---|
  | `W` `E` `R` | 위 | 가운데 | 아래 |
  | `S` `D` `F` | 왼쪽 | 가운데 | 오른쪽 |
  | `X` `C` `V` | 앞 | 가운데 | 뒤 |
- `Space` 섞기 · `Z` 되돌리기 · `Y` 다시 실행
- 컨트롤: Scramble / Undo / Redo / Reset / Recenter

## 기술

Canvas WebGL 1.0, 단일 파일, 외부 의존성 없음.
큐비마다 정수 격자 위치와 회전 행렬을 들고 있어 방향이 정확히 떨어지고, 완료 판정은
여섯 방향의 바깥 스티커를 직접 읽습니다. 피킹은 모델 공간에서의 광선/상자 교차로 풀고,
드래그 방향을 화면에 투영한 네 접선과 맞춰 어느 시점에서도 같은 층이 돌아갑니다.
`prefers-reduced-motion`에서는 표면 시계가 멈추고 조작만 남습니다.
확대·축소 범위는 눈대중이 아니라 장면에서 계산합니다 — 큐브의 바운딩 스피어가 화면을
벗어나지 않는 거리와, 배경 도형 중 가장 앞선 것의 깊이에서 확보할 여유를 함께 봅니다.
배경이 큐브의 회전을 얼마나 받아 갈지도 같은 방식입니다. 회전은 원점을 중심으로 돌기 때문에
도형과 큐브 사이의 거리를 보존하고(가장 가까운 것이 5.1, 큐브의 바운딩 스피어가 2.7이라
어떤 각도에서도 큐브를 뚫지 못합니다), 남는 문제는 눈 쪽으로 돌아 나오는 경우 하나뿐입니다.
그래서 도형마다 자기 궤적의 꼭짓점들을 회전 범위 전체에 대고 한 번 훑어, 카메라가 가장
가까이 오는 거리까지 여유를 남기는 최대치를 찾아 둡니다. 깊이가 얕을수록 0.51까지 따라오고,
깊이 물러난 것은 0.15에 그칩니다.

## 크레딧

Minji Lee · 2026
