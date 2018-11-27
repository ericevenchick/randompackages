{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_gawk": "catalog:timeless.polydawn.io/gawk:v4.2.1:src",
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_gawk": "/src"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pR /src/gawk*/* /task && ls -al /task && mkdir /task/prefix && mkdir /task/build && cd /task/build && LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib\" ../configure --prefix=/task/prefix",
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
			"cd build && make && make install",
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
