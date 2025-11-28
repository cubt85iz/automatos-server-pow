# Automatos Server

Automatos Server is a toolkit for creating OS images based on Fedora CoreOS.

## How It Works

### automatos-server-config

The automatos-server-config repository provides the resources to transpile Butane configurations for Fedora CoreOS into Ignition files.  Butane configurations are human-readable, YAML-based files that allow administrators to seed an installation with files, folders, users, keys, etc. The provided just recipes will transpile the provided Butane configuration(s) into a JSON-based Ignition file and serve it so it can be consumed by the Fedora CoreOS installation.

The Butane configurations are used to provide configuration information for the system when installing Fedora CoreOS. This can include simple changes like overwriting `/etc/hostname` to set the hostname for the machine, but it can also include more complex changes. For example, you can supply an override file for setting the secrets for a database container.

**File:** `config/[my-server]/containers/romm-db.bu`

```yaml
    ## Variables
    ## This specifies the environment variables that will be appended to the configuration of
    ## the container. They are specified here, so the values can be protected or customized by
    ## the server maintainer.
    - path: /etc/containers/systemd/romm-db.container.d/00-romm-db-variables.conf
      overwrite: true
      contents:
        inline: |
          [Container]
          Environment=POSTGRES_DB=romm
          Environment=POSTGRES_PASSWORD=<my-secret-password>
          Environment=POSTGRES_USER=<my-secret-admin-account>
          Environment=TZ=America/New_York

          [Service]
          Environment=CONTAINER_PATH=<my-container-volume-location>
      user:
        name: root
      group:
        name: root
      mode: 0644
```

> [!IMPORTANT]
> Use a subfolder for each server deployment with a `main.bu` file as the primary butane configuration file. Refer to the `example-server` configuration for more information. The provided just recipes expect this organization pattern to be used.

> [!TIP]
> For more information about Butane, refer to the latest specification @ [https://coreos.github.io/butane/specs/](https://coreos.github.io/butane/specs/).

### automatos-server

The automatos-server repository provides pre-arranged set of containers, services, and files. It is intended to be used as a submodule for other repositories like this one. The provided set of containers are stored in the `etc/containers/systemd` folder. These containers are defined using systemd container units and are only skeletons that need to be "fleshed out" to include all of the required parameters.

### automatos-server-base

The automatos-server-base repository provides a container image that includes many useful packages. Rebasing to this branch provides an environment for experimenting with changes or importing a ZFS pool prior to switching to a final image.

To rebase to this container image, execute the following command:

```sh
rpm-ostree rebase --reboot --bypass-driver ostree-unverified-registry:ghcr.io/cubt85iz/automatos-server-base:latest
```

### automatos-server-pow

The automatos-server-pow repository includes a configuration containing a subset of the containers supported by automatos-server and packages that are required for this deployment.

To rebase to this container image, execute the following command:

```sh
rpm-ostree rebase --reboot --bypass-driver ostree-unverified-registry:cubt85iz/automatos-server-pow:latest
```
