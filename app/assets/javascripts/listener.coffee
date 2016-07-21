jQuery ->
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

  source.addEventListener 'heartbeat', (e) ->
    console.log('heartbeat')

  $(window).bind "unload", ->
    source.close();


 