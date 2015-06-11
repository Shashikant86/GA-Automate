#!/usr/bin/env ruby

require 'rubygems'
require 'addressable/uri'
require 'json'
require 'yaml'

if ARGV.length != 1
  puts "#{__FILE__} /path/to/archive.har"
  exit 1
end

archive = nil
begin
  archive = JSON.parse File.read(ARGV.shift)
rescue => err
  puts "could not pase archive file: #{err.to_s}"
  exit 1
end

entries = archive['log']['entries']

## get hosts from archive
hosts = entries.map do |entry|
  Addressable::URI.parse(entry['request']['url']).host
end

## loop through each host, pulling out respective urls
output = hosts.uniq.map do |host|
  urls = entries.map do |entry|
    ## build a hash of url->timing info
    if entry['request']['url'].match("http://#{host}/")
      {
        entry['request']['url'] => entry['timings']
      }
    end
  end

  ## toss out null entries
  urls.reject! { |url| url.nil? }

  ## build a resulting hash of host->array of urls
  { host => urls }
end

data = File.open( "har.yml","w" )
data << output.to_yaml
puts output.to_a
