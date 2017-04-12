FROM wuguanghai45/ruby-java

RUN gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/

RUN gem install sinatra
RUN gem install uuid
RUN mkdir /app
