When(/^I call network traffic$/) do
  nedstat_requests=[]
  page.driver.network_traffic.each do |request|
    request.response_parts.uniq(&:url).each do |response|
      nedstat_requests.push(response.url) if response.status == 200
      data = File.open( "poltergeist.txt","w" )
      data << nedstat_requests.to_s
  end
  end
  nedstat_requests.each do |request|
    @data = request
    end
end

Given(/^I visit any website to track google analytics$/) do
  File.delete('poltergeist.txt') if File.exist?('poltergeist.txt')
  visit("http://shashikantjagtap.net")
end

Then(/^I should see page traffic loaded in the file$/) do
  File.exist?('poltergeist.txt')
end

Then(/^I should see google\-analytics in the file$/) do

end
