{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_busybox": "catalog:timeless.polydawn.io/busybox:v1.29.3:src",
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_busybox": "/pkg/busybox/src"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pr /pkg/busybox/src/busybox* /task/busybox && cd /task/busybox && make defconfig",
		    ]
		},
		"outputs": {
		    "build_dir": "/task"
		}
	    },
	},
	"build": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "configure.build_dir": "/task"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cd /task/busybox && LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib\" make && make install",
		    ]
		},
		"outputs": {
		    "build_dir": "/task"
		    "busybox": "/task/busybox/_install"
		}
	    }
	},
	"package": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "build.busybox": "/pkg/busybox"
		},
		"action": {
		    "exec": ["/bin/bash", "-c", "sed -i 's/XORIGIN/$ORIGIN/' /pkg/busybox/bin/*"]
		},
		"outputs": {
		    "bin-linux-amd64": "/pkg/busybox"
		}
	    }
	}
    }
    "exports": {
	"bin-linux-amd64": "package.bin-linux-amd64"
	"build-dir": "configure.build_dir"
    }
}
