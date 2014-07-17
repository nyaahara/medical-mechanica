# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#progress_sick_id').on 'change', (e) ->
    options = $(e.target)[0]
    result = (item for item in options when item.value is options.value)
    $('#sick_label').val result[0].text
