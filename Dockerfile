FROM node

WORKDIR /home

# install git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

# install npx (for babel)
RUN npm install -g npx

# install aragon-cli
RUN git clone https://github.com/aragon/aragon-cli.git
WORKDIR /home/aragon-cli
RUN npm install

# build aragon-cli and link to npm
RUN npm run extract-roles && \
    npx babel -d dist src --copy-files && \
    npm link

EXPOSE 3000

WORKDIR /home/dockar

CMD ["/bin/bash"]