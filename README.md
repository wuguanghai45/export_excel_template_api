# export_excel_template_api

docker run -it -v $(pwd):/app ruby-java sh
java -jar /app/fillToExcel.jar "/app/templates/export_excel.xls" "/app/export_example.xls" /app/json_file
