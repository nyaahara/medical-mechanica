# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("canvas#all-over").dblclick (e) ->
    canvas = $(e.target)
    c = $('canvas#all-over')[0].getContext('2d')

    x = e.pageX - canvas.position().left
    y = e.pageY - canvas.position().top
    # rect = canvas.getBoundingClientRect()

    # この方法でマークすると、同じ場所をクリックしたときにcanvas.position.top()の値が極端に小さくなって、判定できなくなります。
    # なにか対策を立てないといけません。
    # canvas.append("<span class='block' style='left: #{x}px; top: #{y}px;' />")
    # c = $('div#canvas')[0].getContext('2d');
    
    r = 1000
    mx = Math.floor(x)*2
    my = Math.floor(y)*2

    c.beginPath()
    c.fillRect(mx, my, 12, 4);
    c.fillRect(140, 25, 12, 4);
    # c.moveTo(mx*mx,my*my);
    # c.lineTo(mx*mx+5,my*my+5)
    # c.closePath();
    # c.stroke()
    
    parts_list = [
      { name:"head", x_from:55, x_to:79, y_from:6, y_to:34 }
    ]

    alert(
      "x->"+x+"\ny->"+y+
      "\n"+
      "\nmx->"+mx+"\nmy->"+my+
      "\n"+
      "\nlayerX->"+e.layerX+"\nlayerY->"+e.layerY+
      "\n"+
      "\npageX->"+e.pageX+"\npageY->"+e.pageY+
      "\n"+
      "\ncanvas_left->"+canvas.position().left+"\ncanvas_top->"+canvas.position().top+
      "\n"+
      "\nclientX->"+e.clientX+"\nclientY->"+e.clientY
    )

    for p in parts_list
      if p.x_from*r <= mx <= p.x_to*r and p.y_from*r <= my <= p.y_to*r
        $("div.#{p.name} a")[0].click()
        break

