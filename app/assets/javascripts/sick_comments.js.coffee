# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ajax:success', '#comment', (xhr, data, status) -> 
  location.reload() 
    
$(document).on 'ajax:error', '#comment', (xhr, data, status) -> 
  form = $('#comment .modal-body') 
  div = $('<div id="commentErrors" class="alert alert-danger"></div>') 
  ul = $('<ul></ul>') 
  data.responseJSON.messages.forEach (message, i) ->  
    li = $('<li></li>').text(message) 
    ul.append(li) 
    
  if $('#commentErrors')[0] 
    $('#commentErrors').html(ul)     
  else 
    div.append(ul) 
    form.prepend(div) 
