{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_zlib": "catalog:timeless.polydawn.io/zlib:v1.2.11:src",
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_zlib": "/src"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pR /src/zlib*/* /task && ls -al /task && mkdir /task/prefix && LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib\" ./configure --prefix=/task/prefix",
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
		    "exec": ["/bin/bash", "-c", "echo packaging..."]
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
