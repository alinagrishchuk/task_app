console.log("tasks page fire!")

ready = ->
  linkTrigger.init()

  $('.js-links-block a').on 'ajax:success', ->
    console.log(".js-links-block a fire!")
    cancelLink.init()

$(document).on('page:load ready', ready)

linkTrigger = {
  # disable link on send
  init: ->
    $(document).on 'ajax:beforeSend', ->
      $(this).css('pointer-events', 'none')
    $(document).on 'ajax:complete', ->
      $(this).css('pointer-events', 'auto')

  #show links on page
  show: ->
    $(".js-links-block a").removeClass("disabled-link")
    $(".js-links-block a").show()
}

cancelLink = {
  init: ->
    $('.js-cancel').on 'click ', ->
      console.log(".js-cancel click")
      $($(this).parents(".task-form")).remove()
      linkTrigger.show()
}