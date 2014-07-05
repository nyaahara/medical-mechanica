# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
parts_list = [
  { name:"head", x:[55..79], y:[6..34] }
]

$ ->
  $("canvas#all-over").on 'dblclick touchstart', (e) ->
    e.preventDefault
    canvas = $(e.target)
    pageX = e.pageX || e.originalEvent.changedTouches[0].pageX
    pageY = e.pageY || e.originalEvent.changedTouches[0].pageY
    x = pageX - canvas.position().left
    y = pageY - canvas.position().top

    for part in parts_list
      
      item = $('input.kurasu[value=head]')[0]
      if item? and item.parentNode.parentNode.style.display != "none"
        break

      if x in part.x and y in part.y
        canvas[0].getContext('2d').fillRect(x, y, 4, 4);
        $("div.#{part.name} a")[0].click()
        break

# 削除したいけど、うまくいかないっす。。。
# ボタンを振り分けられないっす。。。
# 振り分けたボタンがどのパーツで、どの座標にあるのかも特定できないっす。
$ ->
  $("#kurase").click (e) ->
    ctx = $("canvas#all-over")[0].getContext ('2d');
    ctx.clearRect(0,0,300,300)
    alert "deldel"

