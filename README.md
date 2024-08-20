# server-images

Repo containing some server images used in our projects.

## concourse-worker

Base AMI used for Concourse workers. This image is built automatically in the `server-images` pipeline on Concourse, but if you need to build it manually, run `packer build` to build it, providing the correct Concourse version, e.g.:

```bash
packer build -var 'source_ami=ami-0f9e9442edcd2faa2' -var 'concourse_version=7.7.1' aws.json
```

## teleport

AMI for Teleport servers. This image is built automatically in the `server-images` pipeline on Concourse, but if you need to build it manually, run `packer build` providing the correct variables, e.g.:

```bash
packer build -var 'source_ami=ami-0ea3405d2d2522162' -var 'teleport_version=6.2.8' packer.json
```
