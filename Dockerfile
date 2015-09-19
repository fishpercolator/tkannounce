FROM ruby:2.2

ENV DIR /usr/src/app
RUN mkdir -p $DIR
WORKDIR $DIR

ADD Gemfile Gemfile.lock $DIR/
RUN bundle install

ADD . $DIR/

CMD ["bash"]
