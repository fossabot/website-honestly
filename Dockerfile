FROM redbadger/website-honestly-node:2

RUN apk add --no-cache make git openssh zip curl

# Install aws cli
RUN apk add --no-cache \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        && \
    pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic

# Install code climate reporter
RUN curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
RUN chmod +x ./cc-test-reporter

RUN apk -v --purge del py-pip

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update && sudo apt-get install yarn

# Install the node version required for the site
# RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
#     && apt-get install -y nodejs