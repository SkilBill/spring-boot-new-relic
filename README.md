# Spring boot / NewRelic demo

## Setup

```bash
# build the Docker image
./build.sh

# run without a license key
docker run -p 8080:8080 hello

# run with a license key
docker run -p 8080:8080 -e "NEW_RELIC_APP_NAME=hello" -e "NEW_RELIC_LICENSE_KEY=AAAAAAAAAAAAAAA" hello
```

## Boot times

| Image | Without license key | With a license key |
|-------|------------------------|-------------------|
| Local Quad core 2.8Ghz + 16GB RAM | `7 sec` | `20 sec` |
| AWS Fargate 0.25 CPU + 0.5GB RAM | `90 sec` | `250 sec` |
| AWS Fargate 1 CPU + 2GB RAM | `29 sec` | `72 sec` |

Observations:

- The startup time with NewRelic is about **2.5x** slower.
- This is for a "starter" application without any dependencies (very best case).
- Our test enviroments can run on small machines (0.25 CPU + 0.5GB RAM) if the boot time is reasonable, but **250sec** starts failing the load balancer health checks.

## Detailled timings

### - AWS Fargate 0.25 CPU + 0.5GB RAM

Without a license key

```
2019-03-14 14:43:21 :: INFO: New Relic Agent: Loading configuration file "/app/newrelic/./newrelic.yml"
>>>> instantly
2019-03-14 14:43:21 :: Spring Boot :: (v2.0.5.RELEASE)
>>>> 1 min 8 sec later
2019-03-14 14:44:29 INFO 1 --- [ main] hello.Application : Started Application in 75.904 seconds (JVM running for 90.392)
```

With a license key

```
2019-03-14 14:47:51 INFO: New Relic Agent: Loading configuration file "/app/newrelic/./newrelic.yml"
>>>> 1 min 55 sec later
2019-03-14 14:49:46 :: Spring Boot :: (v2.0.5.RELEASE)
>>>> 2 min 11 sec later
2019-03-14 14:51:57 2019-03-14 13:51:57.486 INFO 1 --- [ main] hello.Application : Started Application in 145.298 seconds (JVM running for 250.41)
```

### - AWS Fargate 1 CPU + 2GB RAM

Without a license key

```
2019-03-14 14:59:06 :: Spring Boot :: (v2.0.5.RELEASE)
>>>> 24 sec later
2019-03-14 14:59:30 INFO 1 --- [ main] hello.Application : Started Application in 26.098 seconds (JVM running for 29.026)
```

With a license key

```
2019-03-14 15:02:56 INFO: New Relic Agent: Loading configuration file "/app/newrelic/./newrelic.yml"
>>>> 36 sec later
2019-03-14 15:03:32 :: Spring Boot :: (v2.0.5.RELEASE)
>>>> 35 sec later
2019-03-14 15:04:07 INFO 1 --- [ main] hello.Application : Started Application in 39.617 seconds (JVM running for 72.447)
```
