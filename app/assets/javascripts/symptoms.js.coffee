# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("div#canvas").dblclick (e) ->
    canvas = $(e.target)
    alert "pageX->" + e.pageX + "  pageY->"+e.pageY
    alert "canvas_left->" + canvas.position().left + "   canvas_top->" + canvas.position().top 
    x = e.pageX - canvas.position().left
    y = e.pageY - canvas.position().top
    canvas.append("<div class='block' style='left: #{x}px; top: #{y}px;' />")
    
    rounding = 1000
    mx = Math.floor(x*rounding)
    my = Math.floor(y*rounding)
    
    aaaatodonaming_list = [
      { key:"head", x_from:55, x_to:79, y_from:6, y_to:34 }
    ]

    # ウィンドウのスクロールによって違う所、座標が変わってないか？？
    alert "x ->"+x+"    y->"+y+"\nmx->"+mx+"   my->"+my
    for todo in aaaatodonaming_list
      if todo.x_from*rounding <= mx <= todo.x_to*rounding and todo.y_from*rounding <= my <= todo.y_to*rounding
        $("div.#{todo.key} a")[0].click()
        break

#    if mx in [55*rounding..79*rounding] and my in [6*rounding..70*rounding]
#      $("div.head a")[0].click()


