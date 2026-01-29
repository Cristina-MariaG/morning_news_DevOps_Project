FROM node:16

WORKDIR /app

COPY . .

RUN yarn cache clean && yarn install && yarn build

EXPOSE 3000

CMD ["yarn", "start"]