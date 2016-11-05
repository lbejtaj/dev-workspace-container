# dev-workspace-container
[![CircleCI](https://circleci.com/gh/JosephSalisbury/dev-workspace-container/tree/master.svg?style=svg)](https://circleci.com/gh/JosephSalisbury/dev-workspace-container/tree/master)

A personal Docker container for development work

Run with:

```
docker run \
    --rm -ti \
    -v /var/run/docker.sock:/var/run/docker.sock \
    salisburyjoseph/dev-workspace-container:$TAG
```

See https://hub.docker.com/r/salisburyjoseph/dev-workspace-container/ for builds.