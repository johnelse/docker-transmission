#!/usr/bin/env python

"""
Helper script for launching transmission in a docker container.
"""

import argparse
import os
import subprocess
import sys


def main():
    """
    Main entry point.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('--password',
                        help='Admin password')
    parser.add_argument('--downloads',
                        help='Directory for storing downloads')
    parser.add_argument('--incomplete',
                        help='Directory for storing incomplete files')

    args = parser.parse_args(sys.argv[1:])
    image = "%s/transmission" % os.getenv("USER")
    docker_args = [
        "docker", "run", "-d", "--name", "transmission-container",
        "-p", "12345:12345",
        "-p", "12345:12345/udp",
        "-p", "9091:9091",
        "-e", "ADMIN_PASS=%s" % args.password,
        "-v", "%s:/var/lib/transmission-daemon/downloads" % args.downloads,
        "-v", "%s:/var/lib/transmission-daemon/incomplete" % args.incomplete,
        image
        ]
    sys.stderr.write("Launching docker with args %s\n" % docker_args)
    subprocess.call(docker_args)


if __name__ == "__main__":
    main()
