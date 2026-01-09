FROM node:20-alpine AS build

WORKDIR /app

COPY ./source .

RUN npm install -g npm
RUN npm install -g pnpm@10.27.0
RUN pnpm i
RUN pnpm build

FROM node:20-alpine

WORKDIR /app

COPY --from=build /app/next.config.js /app/next.config.js
COPY --from=build /app/public /app/public
COPY --from=build /app/.next/static /app/.next/static
COPY --from=build /app/.next/standalone /app

CMD [ "node", "server.js" ]
