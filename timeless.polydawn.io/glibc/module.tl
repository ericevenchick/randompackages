{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"gawk": "catalog:timeless.polydawn.io/gawk:candidate:bin-linux-amd64"
	"bison": "catalog:timeless.polydawn.io/bison:candidate:bin-linux-amd64"
	"m4": "catalog:timeless.polydawn.io/m4:candidate:bin-linux-amd64"
	"src_glibc": "catalog:timeless.polydawn.io/glibc:v2.28:src",
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_glibc": "/pkg/glibc/src"
		    "gawk": "/pkg/gawk"
		    "bison": "/pkg/bison"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pr /pkg/glibc/src/glibc* /task/glibc && mkdir /task/glibc/build && cd /task/glibc/build && PATH=$PATH:/pkg/gawk/bin:/pkg/bison/bin LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib\" ../configure --prefix=/pkg/glibc",
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
		    "src_glibc": "/pkg/glibc/src"
		    "configure.build_dir": "/task"
		    "gawk": "/pkg/gawk"
		    "bison": "/pkg/bison"
		    "m4": "/pkg/m4"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cd /task/glibc/build && export PATH=$PATH:/pkg/gawk/bin:/pkg/bison/bin:/pkg/m4/bin && make && make install",
		    ]
		},
		"outputs": {
		    "glibc": "/pkg/glibc"
		}
	    }
	},
	"package": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "build.glibc": "/pkg/glibc"
		},
		"action": {
		    "exec": ["/bin/bash", "-c", "sed -i 's/XORIGIN/$ORIGIN/' /pkg/glibc/bin/*"]
		},
		"outputs": {
		    "bin-linux-amd64": "/pkg/glibc"
		}
	    }
	}
    }
    "exports": {
	"bin-linux-amd64": "package.bin-linux-amd64"
	"build-dir": "configure.build_dir"
    }
}
