# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
parts_list = [
  { name:"head", x:[55..79], y:[6..34] }
  { name:"body", x:[30..100], y:[35..65] }
]

$ ->
  $("canvas#all-over").on 'click', (e) ->
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
      views = $("input.progress-part[value=#{part.name}]")
## TODO parent.parentってなってるので、divの構造によってスクリプトが動かなくなります。
      nones = (item for item in views when item.parentNode.parentNode.style.display is "none")
      if views.length - nones.length >= 1
        continue

      ## クリックした座標が、部位リストで定義した座標の中に
      ## 収まる場合は入力オブジェクトを追加する。
      if x in part.x and y in part.y
        $('#dialogHeader')[0].innerHTML = part.name
        $('#modal-part')[0].value = part.name
        $('#modal-x')[0].value = x
        $('#modal-y')[0].value = y
        $('#modalAdd').modal('show')
        break

$ ->
  $('#add-progress').on 'click', (e) ->
    $('#modalAdd').modal('hide')
    x = $('#modal-x')[0].value
    y = $('#modal-y')[0].value
    ctx = $("canvas#all-over")[0].getContext('2d')
    ctx.fillRect(x, y, 4, 4)
    link = $("#form-add a")[0]
    link.click()

$ ->
  $(document).on 'nested:fieldAdded', (e) ->
    par = $('#modal-part')[0].value
    x = $('#modal-x')[0].value
    y = $('#modal-y')[0].value
    lev = $("#modal-level")[0].value
    kin = $("#modal-kinds")[0].value
    mem = $('#modal-memo')[0].value
    $(e.target).find(".pointX")[0].value = x
    $(e.target).find(".pointY")[0].value = y
    $(e.target).find(".progress-part")[0].defaultValue = par
    $(e.target).find(".progress-kind select").val kin 
    $(e.target).find(".progress-level")[0].value = lev
    $(e.target).find(".progress-memo")[0].value = mem

$ ->
  # ×ボタン押した時に描画した点をクリアします
  #$(document).on 'nested:fieldAdded', (e) ->
 #   $(e.target).find(".pointX").attr("value", x)
 #   $(e.target).find(".pointY").attr("value", y)
 #   $(".remove_nested_fields").on 'click', (e) ->
 #     ctx = $("canvas#all-over")[0].getContext('2d')
 #     point = $(e.target)[0].parentNode.parentNode
 #     pointX = $(point).find(".pointX")[0].value
 #     pointY = $(point).find(".pointY")[0].value
 #     ctx.clearRect(pointX, pointY, 4, 4)

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

# エンターキー押下でsubmitされるのを防ぐ
$ ->
  $(document).on "keypress", "input:not(.allow_submit)", (event) -> event.which != 13

