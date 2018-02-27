SHELL := /bin/bash
AWS_REGION ?= eu-west-1
KUBERNETES_VERSION ?=

DEBUG ?= false

ifeq ($(DEBUG),true)
  DEBUG_FLAG ?= -debug
else
  DEBUG_FLAG ?=
endif

build:
	test -n "$(KUBERNETES_VERSION)"  # $$KUBERNETES_VERSION
	
	packer build $(DEBUG_FLAG) -var 'aws_region=$(AWS_REGION)' -var 'kubernetes_version=$(KUBERNETES_VERSION)' aws.json
