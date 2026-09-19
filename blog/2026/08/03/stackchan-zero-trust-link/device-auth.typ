// デバイス認証フロー（RFC 8628）のシーケンス図
// 生成: typst compile device-auth.typ device-auth.png --ppi 200
//
// 箱はすべて typst の box で組み、文字量に応じて自動で伸縮させる。
// cetz の rect に固定座標を与えると、文字がはみ出して重なる。
#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 14pt, fill: white)
#set text(font: "Hiragino Kaku Gothic ProN", size: 9pt, fill: rgb("#1f2328"))

#let ink = rgb("#1f2328")
#let muted = rgb("#7a828e")
#let accent = rgb("#0f7b6c")
#let accent-soft = rgb("#e3efec")
#let line-col = rgb("#d5d9e0")

#let head-box(label) = box(
  inset: (x: 9pt, y: 6pt), radius: 4pt,
  fill: white, stroke: 0.9pt + ink,
  text(size: 9.5pt, weight: "bold")[#label],
)

#let tag(label, size: 8.5pt, fill-col: ink, weight: "regular") = box(
  inset: (x: 4pt), fill: white,
  text(size: size, fill: fill-col, weight: weight)[#label],
)

#cetz.canvas({
  import cetz.draw: *

  let user = 1.5
  let dev = 6.3
  let svc = 11.1
  let head-y = 9.7
  let foot-y = 1.15

  for x in (user, dev, svc) {
    line((x, head-y - 0.42), (x, foot-y),
         stroke: (paint: line-col, thickness: 0.7pt, dash: (2pt, 3pt)))
  }

  let bar(x, y1, y2) = rect((x - 0.075, y1), (x + 0.075, y2),
                            fill: accent-soft, stroke: none)
  bar(dev, 8.95, 1.85)
  bar(svc, 8.30, 1.85)

  content((user, head-y), head-box[ユーザー])
  content((dev, head-y), head-box[デバイス（ESP32）])
  content((svc, head-y), head-box[サービス（ZTL）])

  // 前提条件（ガード）
  content((dev, 9.06), tag([［接続情報が保存されていないとき］], size: 7.5pt, fill-col: muted))

  let num(x, y, n) = {
    circle((x, y), radius: 0.16, fill: accent, stroke: none)
    content((x, y), text(size: 6.5pt, fill: white, weight: "bold")[#n])
  }

  let msg(y, x1, x2, n, label, note: none, reply: false) = {
    let dir = if x2 > x1 { 1 } else { -1 }
    let s = if reply {
      (paint: accent, thickness: 0.9pt, dash: (2.5pt, 2.5pt))
    } else {
      (paint: accent, thickness: 1.1pt)
    }
    line((x1 + 0.28 * dir, y), (x2 - 0.12 * dir, y),
         mark: (end: ">", fill: accent, scale: 0.6), stroke: s)
    num(x1 + 0.08 * dir, y, n)
    content(((x1 + x2) / 2 + 0.1 * dir, y + 0.28), tag(label))
    if note != none {
      content(((x1 + x2) / 2 + 0.1 * dir, y - 0.26),
              tag(note, size: 7.5pt, fill-col: muted))
    }
  }

  // デバイスがサービスからコードを受け取る
  msg(8.45, dev, svc, 1, [コードを要求])
  msg(7.70, svc, dev, 2, [コードと承認 URL], reply: true)

  // デバイスがユーザーに見せる
  msg(6.85, dev, user, 3, [画面にコードと QR コードを出す])

  // ユーザーが承認する
  msg(6.00, user, svc, 4, [承認ページで承認], note: [デバイス名を目視で確認])

  // 承認されるまで問い合わせる
  rect((dev - 1.35, 2.60), (svc + 0.95, 5.20),
       stroke: (paint: muted, thickness: 0.7pt), fill: none)
  content((dev - 1.35, 5.20), anchor: "north-west", box(
    inset: (x: 5pt, y: 3pt), fill: rgb("#f0f1f4"), stroke: 0.7pt + muted,
    text(size: 7pt, weight: "bold")[loop],
  ))
  content((dev + 0.05, 4.94), anchor: "west",
          tag([［承認されるまで一定間隔で］], size: 7.5pt, fill-col: muted))

  msg(4.10, dev, svc, 5, [承認済みかどうかを確認])
  msg(3.20, svc, dev, 6, [まだ承認されていない], reply: true)

  msg(2.10, svc, dev, 7, [接続情報を発行], reply: true,
      note: [キーと接続先を保存する])

  content((dev, 1.40), tag(
    [2回目以降の起動は、保存した接続情報でそのままつながる],
    size: 8.5pt, fill-col: accent, weight: "bold",
  ))
})
