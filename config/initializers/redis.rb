$redis = Redis.new

heartbeat = Thread.new do
  while true
    $redis.publish('heartbeat','thump')
    sleep 2.seconds
  end
end

at_exit do
  heartbeat.kill
  $redis.quit
end