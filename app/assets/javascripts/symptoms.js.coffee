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
  $("#register").on 'click', (e) ->
    url = $("canvas#all-over")[0].toDataURL('image/png')
    $("#symptom_symptom_image")[0].value = url

$ ->
  # ×ボタン押した時に描画した点をクリアします
  $(document).on 'nested:fieldAdded', (e) ->
    remove_link = $(e.target).find(".remove_nested_fields")
    remove_link.attr("x", x)
    remove_link.attr("y", y)
    remove_link.on 'click', (e) ->
      ctx = $("canvas#all-over")[0].getContext('2d')
      point = $(e.target)[0].attributes
      ctx.clearRect(point.x.value, point.y.value, 4, 4)

$ ->
  canvas = $("canvas#all-over")[0]
  ctx = canvas.getContext('2d')
  image = new Image()
  image.src = $("#point")[0].src
  image.onload = ->
    ctx.clearRect(0, 0, canvas.width, canvas.height)
    ctx.drawImage(image, 0, 0)

