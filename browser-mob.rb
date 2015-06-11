require 'selenium/webdriver'
require 'browsermob/proxy'

server = BrowserMob::Proxy::Server.new("/Users/shashi/workspace/ga-automate/browsermob-proxy/bin/browsermob-proxy")
server.start

proxy = server.create_proxy #=> #<BrowserMob::Proxy::Client:0x0000010224bdc0 ...>

profile = Selenium::WebDriver::Firefox::Profile.new #=> #<Selenium::WebDriver::Firefox::Profile:0x000001022bf748 ...>
profile.proxy = proxy.selenium_proxy

driver = Selenium::WebDriver.for :firefox, :profile => profile

proxy.new_har "google"
driver.get "http://shashikantjagtap.net"

har = proxy.har #=> #<HAR::Archive:0x-27066c42d7e75fa6>
har.entries.first.request.url #=> "http://google.com"
har.save_to "website.har"

proxy.close
driver.quit
