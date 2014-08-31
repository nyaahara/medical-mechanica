# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("canvas.all-over").on 'click', (e) ->

    e.preventDefault
    canvas = $(e.target)
    pageX = e.pageX || e.originalEvent.changedTouches[0].pageX
    pageY = e.pageY || e.originalEvent.changedTouches[0].pageY
    x = pageX - canvas.position().left
    y = pageY - canvas.position().top
    $('#modal-front-or-back')[0].value = canvas[0].id
    $('#modal-x')[0].value = x
    $('#modal-y')[0].value = y
    $('#modalAdd').modal('show')
    $('#modal-memo')[0].focus()

  $('#modalAdd').on 'shown.bs.modal', (e) ->
    $('#modal-memo')[0].focus()

  ##############
  ## pushed modal windows's button. hide and add part-detail.
  $('#add-progress').on 'click', (e) ->
    $('#modalAdd').modal('hide')
    $("#form-add a")[0].click()

  #############
  ## adding part-detail. set values, and draw canvas and icon.
  $(document).on 'nested:fieldAdded', (e) ->
    part_detail = $(e.target)
    part_detail.find(".frontOrBack")[0].value = $('#modal-front-or-back')[0].value
    part_detail.find(".pointX")[0].value = $('#modal-x')[0].value
    part_detail.find(".pointY")[0].value = $('#modal-y')[0].value
    part_detail.find(".progress-memo")[0].value = $('#modal-memo')[0].value
    $('#modal-memo')[0].value = ""
    draw_all_over(part_detail)
    draw_part_icon(part_detail)

  #############
  ## ×ボタン押した時に描画した点をクリアします
  $(document).on 'nested:fieldRemoved', (e) ->
    clear_all_over($(e.target))

  #############
  ## all-over(全体)と、part要素のアイコンを描画します。
  for field in $(".fields")
    part_detail = $(field)
    draw_all_over(part_detail)
    draw_part_icon(part_detail)

  #############
  ## エンターキー押下でsubmitされるのを防ぐ
  $(document).on "keypress", "input:not(.allow_submit)", (event) -> event.which != 13


  $('#comment').on 'shown.bs.modal', (e) ->
    $('.modal-comment')[0].focus()

  $('#recover_completely').on 'shown.bs.modal', (e) ->
    $('#sick_recover_completely_comment')[0].focus()

############################################################################
draw_all_over = (part_detail) ->

  canvas = $("##{part_detail.find('.frontOrBack')[0].value}")[0]
  ctx = canvas.getContext('2d')
  pointX = part_detail.find(".pointX")[0].value
  pointY = part_detail.find(".pointY")[0].value
  ctx.fillRect(pointX, pointY, 4, 4);
############################################################################


############################################################################
clear_all_over = (part_detail) ->

  canvas = $("##{part_detail.find('.frontOrBack')[0].value}")[0]
  ctx = canvas.getContext('2d')
  pointX = part_detail.find(".pointX")[0].value
  pointY = part_detail.find(".pointY")[0].value
  ctx.clearRect(pointX, pointY, 4, 4)
############################################################################
  


############################################################################
draw_part_icon = (part_detail) ->

  canvas = part_detail.find(".progress-canvas")[0]

  # change background image
  background = image_path("#{part_detail.find('.frontOrBack')[0].value}.jpg")
  canvas.style.background = "url('{image_url}')".replace('{image_url}', background)

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
