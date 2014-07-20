# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
parts_list = [
  { name:"head", x:[55..79], y:[6..34] }
  { name:"body", x:[30..100], y:[35..65] }
]

$ ->
  $("canvas#all-over").on 'click', (e) ->

    ## get click position.
    e.preventDefault
    canvas = $(e.target)
    pageX = e.pageX || e.originalEvent.changedTouches[0].pageX
    pageY = e.pageY || e.originalEvent.changedTouches[0].pageY
    x = pageX - canvas.position().left
    y = pageY - canvas.position().top

    # ignore exist part. because part is primary.
    for part in parts_list
      ## 部位の入力オブジェクト全体から、display:none;に設定されたものを
      ## 除算し、表示されている数を計算します。
      ## 一つ以上あれば、入力オブジェクトの追加は無い。
      views = $("input.progress-part[value=#{part.name}]")
      ## TODO parent.parentってなってるので、divの構造によってスクリプトが動かなくなります。
      ## これのおかげでみごとに動かなくなってる。#85
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

  ##############
  ## pushed modal windows's button. hide and add part-detail.
  $('#add-progress').on 'click', (e) ->
    $('#modalAdd').modal('hide')
    $("#form-add a")[0].click()

  #############
  ## adding part-detail. set values, and draw canvas and icon.
  $(document).on 'nested:fieldAdded', (e) ->
    part_detail = $(e.target)
    part_detail.find(".pointX")[0].value = $('#modal-x')[0].value
    part_detail.find(".pointY")[0].value = $('#modal-y')[0].value
    part_detail.find(".progress-part")[0].defaultValue = $('#modal-part')[0].value
    part_detail.find(".progress-kind").val $("#modal-kinds")[0].value 
    part_detail.find(".progress-level")[0].value = $("#modal-level")[0].value
    part_detail.find(".progress-memo")[0].value = $('#modal-memo')[0].value
    draw_all_over(part_detail)
    draw_part_icon(part_detail)

    # add slider practice!!
    #  一応、いけた。しかし、編集時は初期ロードでこれをやらないといけんねー。
    # あと、バーの奥に変なのいるw
    slide_bar = $(part_detail.find(".progress-level")[0])
    slide_bar.slider {
      formatter: (value) ->
        'Current value: ' + value
    }

    ##################################

  #############
  ## ×ボタン押した時に描画した点をクリアします
  $(document).on 'nested:fieldRemoved', (e) ->
    clear_all_over($(e.target))

  #############
  ## all-over(全体)と、part要素のアイコンを描画します。
  for field in $(".fields")
    draw_all_over($(field))
    draw_part_icon($(field))

  #############
  ## エンターキー押下でsubmitされるのを防ぐ
  $(document).on "keypress", "input:not(.allow_submit)", (event) -> event.which != 13


############################################################################
draw_all_over = (part_detail) ->

  canvas = $("canvas#all-over")[0]
  ctx = canvas.getContext('2d')
  pointX = part_detail.find(".pointX")[0].value
  pointY = part_detail.find(".pointY")[0].value
  ctx.fillRect(pointX, pointY, 4, 4);
############################################################################


############################################################################
clear_all_over = (part_detail) ->

  canvas = $("canvas#all-over")[0]
  ctx = canvas.getContext('2d')
  pointX = part_detail.find(".pointX")[0].value
  pointY = part_detail.find(".pointY")[0].value
  ctx.clearRect(pointX, pointY, 4, 4)
############################################################################
  


############################################################################
draw_part_icon = (part_detail) ->

  canvas = part_detail.find(".progress-canvas")[0]

  ## half of canvas size
  half_of_canvas_height = canvas.height / 2
  half_of_canvas_width = canvas.width / 2

  ## point of click.
  pointX = part_detail.find(".pointX")[0].value
  pointY = part_detail.find(".pointY")[0].value

  # draw start position left and top
  draw_icon_left = - (Number(pointX) - half_of_canvas_width)
  draw_icon_top = - (Number(pointY) - half_of_canvas_height)

  # draw ( it's changing background-image's poisition
  canvas.style.backgroundPosition = draw_icon_left+"px "+draw_icon_top+"px"

  # draw point middle.
  ctx = canvas.getContext('2d')
  ctx.fillRect(half_of_canvas_width, half_of_canvas_height, 4, 4)
############################################################################

