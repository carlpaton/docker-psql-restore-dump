docker-compose down -v

docker-compose build --no-cache	

docker-compose up -d "postgres-copy"
docker-compose up -d "postgres-db"

Write-Host "* List all containers" -f magenta
docker ps --all

