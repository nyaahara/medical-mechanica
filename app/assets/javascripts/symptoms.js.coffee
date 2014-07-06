# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

parts_list = [
  { name:"head", x:[55..79], y:[6..34] }
  { name:"body", x:[30..100], y:[35..65] }
]

# canvasの点を削除するときのために、座標をグローバル変数にしています。
# ださいのでなんとかしたいです。。。
x=0
y=0

$ ->
  $("canvas#all-over").on 'dblclick touchstart', (e) ->
    e.preventDefault
    canvas = $(e.target)
    pageX = e.pageX || e.originalEvent.changedTouches[0].pageX
    pageY = e.pageY || e.originalEvent.changedTouches[0].pageY
    x = pageX - canvas.position().left
    y = pageY - canvas.position().top

    for part in parts_list
      ## 部位の入力オブジェクト全体から、display:none;に設定されたものを
      ## 除算し、表示されている数を計算します。
      ## 一つ以上あれば、入力オブジェクトの追加は無い。
      views = $("input.kurasu[value=#{part.name}]")
## TODO parent.parentってなってるので、divの構造によってスクリプトが動かなくなります。
      nones = (item for item in views when item.parentNode.parentNode.style.display is "none")
      if views.length - nones.length >= 1
        continue

      ## クリックした座標が、部位リストで定義した座標の中に
      ## 収まる場合は入力オブジェクトを追加する。
      if x in part.x and y in part.y
        ctx = canvas[0].getContext('2d')
        ctx.fillRect(x, y, 4, 4);
        $("div.#{part.name} a")[0].click()
        break

$ ->
  # ×ボタン押した時に描画した点をクリアします
  $(document).on 'nested:fieldAdded', (e) ->
    $(e.target).find(".pointX").attr("value", x)
    $(e.target).find(".pointY").attr("value", y)
    $(".remove_nested_fields").on 'click', (e) ->
      ctx = $("canvas#all-over")[0].getContext('2d')
      point = $(e.target)[0].parentNode.parentNode
      pointX = $(point).find(".pointX")[0].value
      pointY = $(point).find(".pointY")[0].value
      ctx.clearRect(pointX, pointY, 4, 4)

  # ページ初期描画時に表示されている部位のためのクリア処理。上のやつは、追加したものにたいする描画クリア。
# TODO せめて処理を関数化して共通化しよう。。。ださすぎるでこれ。
  $(".remove_nested_fields").on 'click', (e) ->
    ctx = $("canvas#all-over")[0].getContext('2d')
    point = $(e.target)[0].parentNode.parentNode
    pointX = $(point).find(".pointX")[0].value
    pointY = $(point).find(".pointY")[0].value
    ctx.clearRect(pointX, pointY, 4, 4)

$ ->
  canvas = $("canvas#all-over")[0]
  ctx = canvas.getContext('2d')
  for field in $(".fields")
    pointX = $(field).find(".pointX")[0].value
    pointY = $(field).find(".pointY")[0].value
    ctx.fillRect(pointX, pointY, 4, 4);

