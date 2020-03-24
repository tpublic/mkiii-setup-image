FROM docker.bluelight.limited:5000/feingkai/mkiii-install-image:latest

# ENV RUBY_VER=2.5.3
ENV RUBY_VER=2.6.3


WORKDIR /home/app/microkube/

# # # 
USER app
RUN     . /etc/rvmrc && \
        export PATH="$PATH:/usr/local/rvm/bin/" && \
        export PATH="/usr/local/rvm/rubies/ruby-$RUBY_VER/bin:$PATH" && \
        /bin/bash --login -c "rvm use --default $RUBY_VER && \
        echo 'Replacing in multiple files' && \
        sed -i 's/rabbitmq/\"rabbitmq.mkiii:5672\"/g' templates/config/*.env.erb && \
        sed -i 's/EVENT_API_RABBITMQ_PORT=5672/EVENT_API_RABBITMQ_PORT=/g' templates/config/*.env.erb && \
        sed -i 's,git@github.com:,https://github.com/,g' config/app.yml && \
        cat templates/config/peatio.env.erb && \
        echo 'Finished setup' " 
        
USER root

