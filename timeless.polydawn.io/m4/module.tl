{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_m4": "catalog:timeless.polydawn.io/m4:v1.4.18:src",
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_m4": "/src"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pr /src/m4* /task/m4 && cd /task/m4 && mkdir /task/prefix && LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib\" ./configure --prefix=/task/prefix",
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
			"cd /task/m4 && make && make install",
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
