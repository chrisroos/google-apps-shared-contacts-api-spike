#! /usr/bin/env ruby

# README
# ./google-shared-contacts.rb auth 'YOUR-EMAIL-ADDRESS' 'YOUR-PASSWORD' > google-token
# ./google-shared-contacts.rb create `cat google-token` 'YOUR-DOMAIN' 'contact.xml'
# ./google-shared-contacts.rb list `cat google-token` 'YOUR-DOMAIN'

require 'cgi'

def usage_message(signature)
  "Usage: #{File.basename(__FILE__)} #{signature}"
end

def auth_usage_message
  usage_message "auth <username> <password>"
end

def list_usage_message
  usage_message "list <token> <domain>"
end

def create_usage_message
  usage_message "create <token> <domain> <contact-xml-file>"
end

def display_auth_usage_message_and_exit
  puts auth_usage_message
  exit 1
end

def display_list_usage_message_and_exit
  puts list_usage_message
  exit 1
end

def display_create_usage_message_and_exit
  puts create_usage_message
  exit 1
end

command = ARGV.shift
case command
  
when 'auth'
  
  email, password = ARGV
  display_auth_usage_message_and_exit unless email and password
  
  cmd = <<-EndCmd
curl "https://www.google.com/accounts/ClientLogin" \
-d"accountType=HOSTED" \
-d"Email=#{CGI.escape(email)}" \
-d"Passwd=#{CGI.escape(password)}" \
-d"service=cp" \
-d"source=gofreerange-test" \
-s
  EndCmd
  
  response = `#{cmd}`
  puts response[/Auth=(.*)/, 1]
  
when 'list'
  
  token, domain = ARGV
  display_list_usage_message_and_exit unless token and domain
  
  cmd = <<-EndCmd
curl "https://www.google.com/m8/feeds/contacts/#{domain}/full" \
-H"Authorization: GoogleLogin auth=#{token}" \
-H"GData-Version: 3.0" \
-s
  EndCmd
  
  response = `#{cmd}`
  puts response

when 'create'
  
  token, domain, contact_xml_file = ARGV
  display_create_usage_message_and_exit unless token and domain and contact_xml_file
  
  cmd = <<-EndCmd
curl "https://www.google.com/m8/feeds/contacts/#{domain}/full" \
-H"Authorization: GoogleLogin auth=#{token}" \
-H"GData-Version: 3.0" \
-H"Content-Type: application/atom+xml" \
-d"@#{contact_xml_file}" \
-s
  EndCmd

  response = `#{cmd}`
  puts response
  
else
  
  puts auth_usage_message
  puts list_usage_message
  puts create_usage_message
  exit 1
  
end