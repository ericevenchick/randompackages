{
    "imports": {
	"busybox": "catalog:timeless.polydawn.io/busybox:candidate:bin-linux-amd64",
	"runit": "catalog:timeless.polydawn.io/runit:candidate:bin-linux-amd64"
	"glibc": "catalog:timeless.polydawn.io/glibc:candidate:bin-linux-amd64"
	"bash": "catalog:timeless.polydawn.io/bash:candidate:bin-linux-amd64"
	"base": "catalog:early.polydawn.io/monolith/debian:v1.2017.01.04:linux-amd64",
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
	   	    "base": "/",
		    "runit": "/rootfs/pkg/runit",
		    "busybox": "/rootfs/pkg/busybox",
		    "bash": "/rootfs/pkg/bash",
		    "glibc": "/rootfs/pkg/glibc",
		},
		"action": {
		    "policy": "sysad"
		    "exec": [
		        "/bin/bash", "-c", "rm -rf /rootfs/pkg/glibc/src && mkdir -p /rootfs/etc/runit && cp -p /rootfs/pkg/runit/etc/debian/[123] /rootfs/etc/runit && mkdir /rootfs/sbin && cp -p /rootfs/pkg/runit/command/runit* /rootfs/sbin"
		    ]
		},
		"outputs": {
		    "rootfs": "/rootfs"
		}
	    },
	},
    }
    "exports": {
        "rootfs": "configure.rootfs"
    }
}
