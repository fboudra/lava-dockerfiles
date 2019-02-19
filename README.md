# LAVA deployment in containers

The purpose of this repository is to provide a LAVA deployment in containers, 
using Alpine as base images instead of Debian. Package and dependency management 
is done with pip (and within Dockerfiles).

In comparison, [LAVA official docker containers](https://master.lavasoftware.org/static/docs/v2/docker-admin.html#official-lava-software-docker-images) are based on Debian and rely on 
Debian packages to manage the installation and dependencies.

See also, [LAVA Docker Compose project](https://git.lavasoftware.org/lava/pkg/docker-compose).
