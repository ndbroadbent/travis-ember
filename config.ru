require 'rack/ssl'

class EndpointSetter < Struct.new(:app, :endpoint)
  DEFAULT_ENDPOINT = 'https://api.travis-ci.org'

  def call(env)
    status, headers, body = app.call(env)
    if endpoint != DEFAULT_ENDPOINT and headers.any? { |k,v| k.downcase == 'content-type' and v.start_with? 'text/html' }
      headers.delete 'Content-Length'
      body, old = [], body
      old.each { |s| body << s.gsub(DEFAULT_ENDPOINT, endpoint) }
      old.close if old.respond_to? :close
    end
    [status, headers, body]
  end
end

use Rack::SSL if ENV['RACK_ENV'] == 'production'
use Rack::Deflater
use EndpointSetter, ENV['API_ENDPOINT'] if ENV['API_ENDPOINT']
run Rack::Cascade.new([
  Rack::File.new('public'),
  proc { |env|  Rack::File.new(nil).tap { |f| f.path = 'public/index.html' }.serving(env) }
])