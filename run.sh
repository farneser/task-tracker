#!/bin/bash

compose_command() {
  if docker compose version &> /dev/null; then
    echo "docker compose"
  else
    echo "docker-compose"
  fi
}

COMPOSE_CMD=$(compose_command)

if [ "$1" == "stop" ]; then
  $COMPOSE_CMD down -v
  exit 0
fi

if grep -q "^JWT_SECRET=" ".env"; then
  if grep -q "^JWT_SECRET=$" ".env"; then
    sed -i "s/^JWT_SECRET=$/JWT_SECRET=\"$(openssl rand -hex 32)\"/" ".env"
  fi
else
  echo "JWT_SECRET=\"$(openssl rand -hex 32)\"" >> ".env"
fi

$COMPOSE_CMD up -d
