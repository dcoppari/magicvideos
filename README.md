# Magicvideos Transcoding

## Why?

We needed to somehow convert diferent videos format into crossplatform HLS videos to be streamed using html video tag.

## What this proyect do?

This is a terraform configuration for creates AWS Infraestructure to build an elastic transcoder pipeline
from IAM user to cloudfront distribution.

## What i need to do to make this work?

1) Have terraform installed (see terraform website in order to know how to install terraform)

2) AWS Credentials with privileges to create Infraestructure.

3) Execute this as follow:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

You can check a php example magicvideo_transcoder.php using output variables.

## What is missing?

Implements Elastic Transcoder encryption.

Creates a generic API to administrate jobs
