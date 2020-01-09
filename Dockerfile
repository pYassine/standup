ARG EXPOSED_PORT=80
ARG NODE_VERSION=10.15.3

FROM node:${NODE_VERSION} as builder

WORKDIR /app

COPY ./ .
COPY yarn.lock ./yarn.lock

RUN yarn
RUN yarn build

FROM docker.pkg.github.com/socialgouv/docker/nginx4spa:0.21.0

ENV PORT=${EXPOSED_PORT}
EXPOSE ${PORT}

COPY --from=builder /app/build /usr/share/nginx/html
