{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_pcre": "catalog:timeless.polydawn.io/pcre:v8.42:src",
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_pcre": "/src"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pR /src/pcre*/* /task && ls -al /task && mkdir /task/prefix && LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib\" ./configure --prefix=/task/prefix",
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
