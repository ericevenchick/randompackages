{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_bison": "catalog:timeless.polydawn.io/bison:v3.2.2:src",
	"m4": "catalog:timeless.polydawn.io/m4:candidate:bin-linux-amd64",
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_bison": "/pkg/bison/src",
		    "m4": "/pkg/m4"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pR /pkg/bison/src/bison* /task/bison && mkdir /task/bison/build && cd /task/bison/build && PATH=$PATH:/pkg/m4/bin LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib\" ../configure --prefix=/pkg/bison",
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
		    "src_bison": "/pkg/bison/src",
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cd /task/bison/build && make && make install && rm -rf /pkg/bison/src",
		    ]
		},
		"outputs": {
		    "build_dir": "/task"
		    "bison": "/pkg/bison"
		}
	    }
	},
	"package": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "build.bison": "/pkg/bison"
		},
		"action": {
		    "exec": ["/bin/bash", "-c", "sed -i 's/XORIGIN/$ORIGIN/' /pkg/bison/bin/*"]
		},
		"outputs": {
		    "bin-linux-amd64": "/pkg/bison"
		}
	    }
	}
    }
    "exports": {
	"bin-linux-amd64": "package.bin-linux-amd64"
	"build-dir": "configure.build_dir"
    }
}
