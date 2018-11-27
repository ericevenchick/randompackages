{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_openssl": "catalog:timeless.polydawn.io/openssl:v1.0.2p:src",
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_openssl": "/src"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pR /src/openssl*/* /task && ls -al /task && mkdir /task/prefix && LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib\" ./config --prefix=/task/prefix",
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
			"make && make install",
		    ]
		},
		"outputs": {
		    "build_dir": "/task"
		}
	    }
	},
	"package": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "build.build_dir": "/task"
		},
		"action": {
		    "exec": ["/bin/bash", "-c", "sed -i 's/XORIGIN/$ORIGIN/' /task/prefix/bin/*"]
		},
		"outputs": {
		    "bin-linux-amd64": "/task/prefix"
		}
	    }
	}
    }
    "exports": {
	"bin-linux-amd64": "package.bin-linux-amd64"
	"build-dir": "configure.build_dir"
    }
}
