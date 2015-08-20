#!/usr/bin/env python

"""
Helper script for launching transmission in a docker container.
"""

import argparse
import subprocess
import sys


def main():
    """
    Main entry point.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--password',
                        help='Admin password')
    parser.add_argument('-d', '--downloads',
                        help='Directory for storing downloads')
    parser.add_argument('-i', '--incomplete',
                        help='Directory for storing incomplete files')

    args = parser.parse_args(sys.argv[1:])
    docker_args = [
        "docker", "run", "-d", "--name", "transmission-container",
        "-p", "12345:12345",
        "-p", "12345:12345/udp",
        "-p", "127.0.0.1:9091:9091",
        "-e", "ADMIN_PASS=%s" % args.password,
        "-v", "%s:/var/lib/transmission-daemon/downloads" % args.downloads,
        "-v", "%s:/var/lib/transmission-daemon/incomplete" % args.incomplete,
        "transmission"
        ]
    print "Launching docker with args %s" % docker_args
    subprocess.call(docker_args)


if __name__ == "__main__":
    main()
