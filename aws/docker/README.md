# Lacework with Docker Hosts on AWS

This Terraform workspace allows you to deploy 3 docker hosts on top of AWS.
In addition a simple and also insecure Consul cluster is deployed and configured for DNS resolution.

Access to Consul (8500) API is limited to the public IP of the machine that Terraform is executed on.

The Lacework agent is installed on the Docker hosts.

Make sure you configure your AWS and Lacework provider to point to the correct accounts.

To deploy just run: `terraform init` and  `terraform apply` and make sure you provide the required variables.

## voteapp

To deploy the vote app you need to deploy each of its services via `docker run` commands.
Be aware that you need to deploy the DB first for the worker to run correctly.

```bash
ssh -i ssh.key ubuntu@$(terraform output -json docker_server_public_ips | jq -r '.[1]')
$ docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e PGDATA=/var/lib/postgresql/data/pgdata -e POSTGRES_HOST_AUTH_METHOD=trust --dns $(terraform output -json docker_server_private_ips | jq -r '.[1]') --dns-search service.dc1.consul --name db -v /var/lib/postgresql/data:/var/lib/postgresql/data postgres:9.4
$ docker run -d -p 6379:6379 --dns $(terraform output -json docker_server_private_ips | jq -r '.[1]') --dns-search service.dc1.consul --name redis redis:alpine
```

```bash
ssh -i ssh.key ubuntu@$(terraform output -json docker_server_public_ips | jq -r '.[2]')
$ docker run -d --dns $(terraform output -json docker_server_private_ips | jq -r '.[2]') --dns-search service.dc1.consul --name worker detcaccounts/worker
```

```bash
ssh -i ssh.key ubuntu@$(terraform output -json docker_server_public_ips | jq -r '.[0]')
$ docker run -d -p 80:80 --dns $(terraform output -json docker_server_private_ips | jq -r '.[0]') --dns-search service.dc1.consul --name vote detcaccounts/voteapp
$ docker run -d -p 5001:80 --dns $(terraform output -json docker_server_private_ips | jq -r '.[0]') --dns-search service.dc1.consul --name result detcaccounts/resultsapp
```
