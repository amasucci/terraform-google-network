FROM hashicorp/terraform@sha256:511e4c9e188a061b7a9034ca51ad26fa00f540c5ce55143f52292695ac5bdac5

COPY . /standard-vpc

WORKDIR /standard-vpc