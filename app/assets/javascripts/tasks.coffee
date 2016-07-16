console.log("tasks page fire!")

ready = ->
  $('#new_link').on 'ajax:complete', ->
    console.log("#new_link ajax:complete fire!")
    $('.js-cancel').on 'click ', ->
      console.log(".js-cancel click")
      $(".task-form").remove()
      $("#new_link").show()

$(document).on('page:load ready', ready)