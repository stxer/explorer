FROM node:18-alpine AS build

WORKDIR /app

COPY ./source .

RUN npm install -g pnpm@8.9.1
RUN pnpm i
RUN pnpm build

FROM node:18-alpine

WORKDIR /app

COPY --from=build /app/next.config.js /app/next.config.js
COPY --from=build /app/public /app/public
COPY --from=build /app/.next/static /app/.next/static
COPY --from=build /app/.next/standalone /app

CMD [ "node", "server.js" ]
