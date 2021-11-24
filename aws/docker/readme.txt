On the docker host

$ docker run -d -p 80:80 --dns 192.168.30.109 --dns-search service.dc1.consul --name vote detcaccounts/voteapp

$ docker run -d -p 5001:80 --dns 192.168.30.109 --dns-search service.dc1.consul --name result detcaccounts/resultsapp

$ docker run -d -p 6379:6379 --dns 192.168.31.190 --dns-search service.dc1.consul --name redis redis:alpine

$ docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e PGDATA=/var/lib/postgresql/data/pgdata -e POSTGRES_HOST_AUTH_METHOD=trust --dns 192.168.31.190 --dns-search service.dc1.consul --name db -v /var/lib/postgresql/data:/var/lib/postgresql/data postgres:9.4

$ docker run -d --dns 192.168.32.207 --dns-search service.dc1.consul --name worker detcaccounts/worker


$ echo '{
  "service": {
    "id": "vote",
    "name": "vote",
    "address": "192.168.30.109",
    "meta": {
      "meta": "vote"
    },
    "tagged_addresses": {
      "lan": {
        "address": "192.168.30.109",
        "port": 80
      }
    },
    "port": 80
  }
}' > ./vote.json

$ consul services register vote.json
