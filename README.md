# README
## Requirements
[REQUIREMENTS.md](REQUIREMENTS.md)

## Setup:
### 1. Clone Repository
```
git clone git@github.com:arthurariza/bike-shop.git
cd bike-shop
```
### 2. Build docker images
```
docker compose build --no-cache
```
### 3. Start containers in background
```
docker compose up -d
```
### 4. Run database setup
```
docker compose exec api rails db:setup
```
### 5. The server should be running on port 3000

## Sample Endpoints:
`Sample endpoints are included in the endpoints.json file`

## How To Run Specs
```
docker compose exec api rspec -fd
```
## Stop Containers Running In Background
```
docker compose stop
```