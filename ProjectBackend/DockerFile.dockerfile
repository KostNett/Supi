FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean


WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . . 



EXPOSE 5000

CMD ["npm", "start"]