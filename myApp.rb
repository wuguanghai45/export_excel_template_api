require 'sinatra'
require "/app/convert_to_excel"

get '/aaa' do
  @path = File.join("/", "app", 'templates', 'export_excel.xls')
  results = ConvertToExcel.new(@path, "{\"code\":1}").process
  send_file results.first, filename: "Customers.xls"
end
