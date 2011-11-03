spec = Gem::Specification.new do |s|
  s.name = 'semq-client'
  s.author = 'Ian Calvert'
  s.require_path = 'lib'
  s.files = Dir['lib/**/*.rb']
  s.version = '1.2'
  s.summary = 'A ruby client for the semq message queue service.'
  s.description = 'A simple client for using semq message servers. Supports push and pop methods to named queues. Pop can wait indefinitely, using long polling to remain lightweight.'
end

