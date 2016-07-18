console.log("tasks page fire!")

$(document).on 'page:load ready ajaxSuccess', ->
  linkTrigger.init()

$(document).on 'ajax:success', '.js-links-block a', ->
  console.log("dom a get ajax:success!")
  cancelLink.init()
  userSearch.init()


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
    $('#user_email.typeahead').typeahead { highlight: true },
      {
        displayKey: 'label'
        source: (query, syncResults, asyncResults) ->
          $.get '/users/search?search=' + query, (data) ->
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


