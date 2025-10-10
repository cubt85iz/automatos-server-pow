# Automatos Server

Automatos Server is a toolkit for creating OS images based on Fedora CoreOS. <goals> 

## How It Works

### automatos-server-config

The automatos-server-config repository provides the resources to transpile Butane configurations for Fedora CoreOS into Ignition files.  Butane configurations are human-readable, YAML-based files that allow administrators to seed an installation with files, folders, users, keys, etc. The providd just recipes will transpile the provided Butane configuration(s) into a JSON-based Ignition file and serve it so it can be consumed by the Fedora CoreOS installation.

<secrets>
<refs>


automatos-server

automatos-server-base

automatos-server-pow

