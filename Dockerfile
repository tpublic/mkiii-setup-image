FROM docker.bluelight.limited:5000/feingkai/microkube-install-image:latest

# ENV RUBY_VER=2.5.3
ENV RUBY_VER=2.6.0


WORKDIR /home/app/microkube/

# # # 
USER app
RUN     . /etc/rvmrc && \
        export PATH="$PATH:/usr/local/rvm/bin/" && \
        export PATH="/usr/local/rvm/rubies/ruby-$RUBY_VER/bin:$PATH" && \
        rvm use --default $RUBY_VER && \
        echo "Replacing in multiple files" && \
        sed -i 's/rabbitmq/\"rabbitmq.microkube:5672\"/g' templates/config/*.env.erb && \
        sed -i 's/EVENT_API_RABBITMQ_PORT=5672/EVENT_API_RABBITMQ_PORT=/g' templates/config/*.env.erb && \
        cat templates/config/peatio.env.erb && \
        rake render:config && \
        sed -i 's/3.6/3.3/g' compose/* && \
        sed -i 's/33.3/3306/g' compose/* && \
        echo "Finished setup" 
        

        # sed -i 's/RANGER_PORT=80/RANGER_PORT=8080/g' templates/config/peatio.env.erb && \

#CMD ["/bin/bash", "-c", "top"]