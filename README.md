# gbuild

Fast Google Cloud Build builds without YAMLs or Git triggers.

 - Uses Kaniko and caching
 - Also removes the build source and logs (Google doesn't do this automatically)
 - Requires `gcloud` and `gsutil`
 
## Install

Recommended:

Use binaries for Linux/Mac from

    wget https://github.com/matti/gbuild/releases/download/v0.3.0/gbuild-linux-amd64-v0.3.0
    chmod +x gbuild-linux-amd64-v0.3.0
    mv gbuild-linux-amd64-v0.3.0 /usr/local/bin/gbuild

Or use rubygems:

    gem install gbuild

## Usage

Basic usage:

    gbuild gcr.io/project/name

Advanced usage:

    gbuild eu.gcr.io/project/name:latest \
        --build-arg first=1 --build-arg second=2 \
        --no-cache \
        --clean-source \
        --timeout 30

Clean all logs and sources:

    gbuild clean project

Delete an image:

    gbuild delete gcr.io/project/name

Full usage:

    Usage:
        gbuild [OPTIONS] IMAGE

    Parameters:
        IMAGE                         GCR URL (gcr.io/project/image)

    Options:
        --context CONTEXT             build context, defaults to current working directory
        --build-arg BUILD_ARG         docker build argument, can be given multiple times
        --[no-]cache                  cache layers (default: true)
        --[no-]clean-source           clean source (default: true)
        --[no-]clean-log              clean log (default: true)
        --debug                       debug (default: false)
        --dockerfile DOCKERFILE       path to Dockerfile (default: nil)
        --project PROJECT             gcloud project, defaults to project part in GCR URL
        --timeout TIMEOUT             build timeout
        -h, --help                    print help
