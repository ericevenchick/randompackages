{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_bash": "catalog:timeless.polydawn.io/bash:v4.4:src",
	"glibc": "catalog:timeless.polydawn.io/glibc:candidate:bin-linux-amd64"
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_bash": "/pkg/bash/src"
		    "glibc": "/pkg/glibc"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pr /pkg/bash/src /task/bash && cd /task/bash && LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib,--dynamic-linker=/pkg/glibc/lib/ld-linux-x86-64.so.2\" ./configure --prefix=/pkg/bash",
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
		    "src_bash": "/pkg/bash/src"
		    "glibc": "/pkg/glibc"
		    "configure.build_dir": "/task"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cd /task/bash && make && make install",
		    ]
		},
		"outputs": {
		    "build_dir": "/task"
		    "bash": "/pkg/bash"
		}
	    }
	},

	"package": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_bash": "/pkg/bash/src"
		    "glibc": "/pkg/glibc"
		    "build.bash": "/pkg/bash"
		},
		"action": {
		    "exec": ["/bin/bash", "-c", "sed -i 's/XORIGIN/$ORIGIN/' /pkg/bash/bin/* && cp /pkg/glibc/lib/*.so* /pkg/bash/lib"]
		},
		"outputs": {
		    "bin-linux-amd64": "/pkg/bash"
		}
	    }
	}
    }
    "exports": {
	"bin-linux-amd64": "package.bin-linux-amd64"
    }
}
