# Shoe Store

## Installation

```
docker-compose up -d
docker-compose run --rm website rails db:setup
```

## Getting Started

### Inventory Server

Your WebSocket Server is the tap that aggregates inventories from all stores.

You can run it directly from your own machine.

Run the following to start tapping into the inventory events.

```
docker-compose exec website rails websocket:inventory
```
