#!/usr/bin/env python3
# -*- mode: python -*-
import logging.config
logger = logging.getLogger(__name__)
import json
import sys
import requests
import argparse


def _AuthorizationService_get_new_token(self):
    AUTH_TOKEN_FMT = "{}/token?service={}&scope={}"
    rsp = requests.get(AUTH_TOKEN_FMT.format
                       (self.url, self.registry, self.desired_scope),
                       auth=self.auth, verify=self.verify,
                       timeout=self.api_timeout)
    if not rsp.ok:
        logger.error("Can't get token for authentication")
        self.token = ""
    self.token = rsp.json()['token']
    self.scope = self.desired_scope

    
def _BaseClientV2_get_repository_tags(self, name):
    LIST_TAGS_URL = '/v2/{name}/tags/list'
    SCOPE = 'repository:{name}:pull'
    self.auth.desired_scope = SCOPE.format(name=name)
    rsp = self._http_call(LIST_TAGS_URL, requests.get, name=name)
    # print(json.dumps(rsp, default=str, indent=4, sort_keys=True))
    return rsp


# XXX: magic hackery
from docker_registry_client import (
    AuthorizationService, _BaseClient,
    DockerRegistryClient)
AuthorizationService.\
    AuthorizationService.get_new_token = \
    _AuthorizationService_get_new_token
_BaseClient.\
    BaseClientV2.get_repository_tags = \
        _BaseClientV2_get_repository_tags


def get_tags(repository):
    if '/' in sys.argv[1]:
        registry, repository = repository.split('/', 1)
    else:
        registry, repository = \
            'docker.io', 'library/{}'.format(repository)
    if 'docker.io' in registry:
        
        # XXX: more magic hackery
        from six.moves.urllib.parse import urlsplit
        REGISTRY_SERVICE_URL = "https://registry.docker.io"
        HOST_SERVICE_URL = "https://registry-1.docker.io"
        AUTH_SERVICE_URL = "https://auth.docker.io"
        client = DockerRegistryClient(
            HOST_SERVICE_URL, api_version=2,
            auth_service_url=AUTH_SERVICE_URL)
        client._base_client.auth.registry = urlsplit(REGISTRY_SERVICE_URL).netloc
    else:
        client = DockerRegistryClient(
            "https://{}".format(registry), api_version=2)

    repo = client.repository(repository)
    tags = repo.tags()
    
    # sort
    tags = [
        '.'.join(tag)
        for tag in sorted([
                tag.split('.')
                for tag in tags
        ])
    ]
    return tags


def handler(all, repo):
    if all:
        repos = [
            ("alpine", "3.11.6"),
            ("amazonlinux", "2.0.20200406.0"),
            ("busybox", "1.31.1-musl"),
            ("centos", "8"),
            # ("debian", "stretch-20200514"),
            ("debian", "buster-20200514"),
            ("fedora", "32"),
            # ("ubuntu", "bionic-20200403"),
            ("ubuntu", "focal-20200423"),
        ]
    else:
        repos = [
            (repo, ""),
        ]

    results = []
    for repository, repover in repos:
        result = get_tags(repository)
        results.append({
            "name": repository,
            "expectedVersion": repover,
            "tags": result
        })
        
    print(json.dumps(results, indent=4, sort_keys=True))

def add_arguments(parser):
    parser.add_argument(
        "--all", "-a",
        action='store_true')
    parser.add_argument(
        "--repo",
        action='store')
    return parser


def main():
    parser = add_arguments(argparse.ArgumentParser())
    options = vars(parser.parse_args(sys.argv[1:]))
    handler(**options)


if __name__ == '__main__':
    main()
