FROM wuguanghai45/ruby-java

RUN gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/

RUN gem install sinatra
RUN gem install uuid
RUN mkdir /export_excel_app
COPY lib/convert_to_excel.rb /export_excel_app/lib/convert_to_excel.rb
COPY lib/fillToExcel.jar /export_excel_app/lib/fillToExcel.jar
COPY myApp.rb /export_excel_app
COPY templates/export_excel.xls /export_excel_app/templates/export_excel.xls

EXPOSE 80

CMD ruby /export_excel_app/myApp.rb -o 0.0.0.0 -p 80

