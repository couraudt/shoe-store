# Shoe Store

## Installation

```
docker-compose up -d
docker-compose run --rm website rails db:setup
```

## Getting Started

### Inventory Server

Run the following to start tapping into the inventory events.

```
docker-compose exec website rails websocket:inventory
```

## API

The API documentation can be viewed using Swagger Editor:

https://editor.swagger.io/?url=https://raw.githubusercontent.com/couraudt/shoe-store/master/api-description-swagger.yaml
