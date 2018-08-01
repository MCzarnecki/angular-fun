FROM ubuntu:16.04

ENV SCREEN_COLOUR_DEPTH 24
ENV SCREEN_HEIGHT 1080
ENV SCREEN_WIDTH 1920


RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt -f install -y

RUN apt-get install -y wget sudo
RUN apt-get install -y firefox
RUN apt-get install -y libxss1 libappindicator1 libindicator7

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update -y

RUN apt-get install -y google-chrome-stable

RUN apt-get install xvfb -y
RUN chmod +x /usr/bin/xvfb-run
RUN mkdir /opt/protractor
RUN mkdir /opt/protractor/bin

RUN apt-get install unzip
RUN wget -N http://chromedriver.storage.googleapis.com/2.39/chromedriver_linux64.zip -P ~/
RUN unzip ~/chromedriver_linux64.zip -d ~/
RUN rm ~/chromedriver_linux64.zip
RUN mv -f ~/chromedriver /usr/local/bin/chromedriver
RUN chown root:root /usr/local/bin/chromedriver
RUN chmod 0755 /usr/local/bin/chromedriver
#RUN ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
#RUN ln -s /usr/local/share/chromedriver /usr/bin/chromedriver

RUN apt-get install -y libgconf-2-4



# RUN mv /usr/lib/chromium-browser/chromium-browser /usr/lib/chromium-browser/chromium-browser-original \
#   && ln -sfv /opt/protractor/bin/chromium-browser /usr/lib/chromium-browser/chromium-browser

RUN apt-get install -y curl bash

RUN curl --silent --location https://deb.nodesource.com/setup_8.x | sudo bash - && \
    apt-get install -y nodejs

RUN nodejs -v
RUN npm -v

RUN npm i -g protractor && \
    webdriver-manager update --versions.chrome 2.39 && \
    npm i jasmine-spec-reporter --save-dev

ENV PATH=/opt/protractor/bin:$PATH

COPY protractor.sh /opt/protractor/bin/
COPY chromedriver.sh /opt/protractor/bin/chromedriver
COPY chromium-browser.sh /opt/protractor/bin/chromium-browser
COPY . /opt/protractor/

RUN npm i /opt/protractor/

RUN npm install --save-dev ts-node
RUN npm install --save-dev typescript

CMD ["sh", "/opt/protractor/bin/protractor.sh"]