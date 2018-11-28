{
    "imports": {
	"busybox": "catalog:timeless.polydawn.io/busybox:candidate:bin-linux-amd64"
	"glibc": "catalog:timeless.polydawn.io/glibc:candidate:bin-linux-amd64"
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "busybox": "/pkg/busybox",
		    "glibc": "/pkg/glibc",
		},
		"action": {
		    "exec": [
			"/pkg/glibc/lib/ld-linux-x86-64.so.2", "--library-path", "/pkg/glibc/lib", "/pkg/busybox/bin/busybox", "ls", "/"
		    ]
		},
		"outputs": {
		}
	    },
	},
    }
    "exports": {
    }
}
