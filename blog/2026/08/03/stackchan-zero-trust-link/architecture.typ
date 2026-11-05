// StackChan と ZTL 上のホストの関係を示す構成図
// 生成: typst compile architecture.typ architecture.png --ppi 200
//
// 配置は grid に任せ、座標を手で置かない。手で置くと箱の自動採寸と
// 噛み合わず、文字がはみ出して重なる。
#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 16pt, fill: white)
#set text(font: "Hiragino Kaku Gothic ProN", size: 9pt, fill: rgb("#1f2328"))

#let ink = rgb("#1f2328")
#let muted = rgb("#7a828e")
#let accent = rgb("#0f7b6c")
#let line-col = rgb("#d5d9e0")

#let node(title, sub, items) = box(
  inset: (x: 16pt, y: 12pt), radius: 5pt,
  fill: white, stroke: 0.9pt + ink,
  align(center)[
    #text(size: 10.5pt, weight: "bold")[#title] \
    #v(1pt)
    #text(size: 7.5pt, fill: muted)[#sub]
    #v(6pt)
    #line(length: 100%, stroke: 0.5pt + line-col)
    #v(6pt)
    #text(size: 9pt)[#items.join([ \ ])]
  ],
)

#let tunnel = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  line((0, 0), (2.1, 0),
       mark: (start: ">", end: ">", fill: accent, scale: 0.75),
       stroke: (paint: accent, thickness: 1.2pt))
})

#align(center)[
  #grid(
    columns: 3, column-gutter: 12pt, align: horizon,
    node([StackChan（ESP32）], [M5Stack CoreS3],
         ([内蔵マイク], [内蔵スピーカー], [LCD（顔の表示）])),
    stack(
      dir: ttb, spacing: 6pt,
      align(center, text(size: 8.5pt, fill: accent, weight: "bold")[トンネル]),
      tunnel,
      align(center, text(size: 7.5pt, fill: muted)[暗号化される]),
    ),
    node([ZTL 上のホスト], [Linux 版で参加],
         ([音声認識サーバ], [チャット API], [音声合成])),
  )

  #v(10pt)
  #text(size: 8pt, fill: muted)[どちらの側も、外に向けてポートを公開しない]
]
