$(document).on 'page:load ready ajaxSuccess', ->
  linkTrigger.init()

$(document).on 'ajax:success', '.js-links-block a', ->
  cancelLink.init()
  userSearch.init()

$(document).on 'ready', ->
  sseClient.init()

linkTrigger = {
  # disable link on send
  init: ->
    console.log("link trigger init")
    $(document).on 'ajax:beforeSend', ->
      $(this).css('pointer-events', 'none')
    $(document).on 'ajax:complete', ->
      $(this).css('pointer-events', 'auto')

  #show links on page
  show: ->
    $(".js-links-block a").removeClass("disabled-link")
}

cancelLink = {
  init: ->
    console.log("cancel link init")
    $('.js-cancel').on 'click ', ->
      console.log(".js-cancel click")
      $($(this).parents(".form-section")).prev().show()
      $($(this).parents(".form-section")).remove()
      linkTrigger.show()
}

userSearch = {
  init: ->
    console.log("userSearch init")
    task_id = '&task_id=' + $('#user_email').parents(".task").data("id")
    $('#user_email.typeahead').typeahead { highlight: true },
      {
        displayKey: 'label'
        source: (query, syncResults, asyncResults) ->
          $.get '/users/search?search=' + query + task_id, (data) ->
            asyncResults(data)
      }
    
    $('#user_email').bind 'typeahead:selected', (obj, datum, name)->
      $("#user_id").val(datum.value)
      $("#user_email").blur()

    $('#user_email').bind 'typeahead:open',  ->
      $("#user_email").typeahead('val', '')
      $("#user_id").val("")

    $('#user_email').bind 'typeahead:close',  ->
      if $("#user_id").val() == ""
        $("#user_email").typeahead('val', '')

}

sseClient = {
  init: ->
    source = new EventSource('messenger/message')

    source.addEventListener('open', ->
      console.log('Opening connection')
    )

    source.addEventListener('error', ->
      console.log('Closing connection')
    )

    source.addEventListener 'tasks.updated', (e) ->
      message = e.data
      eval(message)
      console.log(message)
      
    source.addEventListener 'heartbeat', (e) ->
      console.log('heartbeat')

    $(window).bind "unload", ->
      source.close();
}



