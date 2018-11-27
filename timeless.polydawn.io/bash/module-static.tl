{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_bash": "catalog:timeless.polydawn.io/bash:v4.4:src",
    },
    "steps": {
	"bash_build": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_bash": "/task"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"/task/configure --enable-static-link --without-bash-malloc && /usr/bin/make -j8 && /task/bash --version",
		    ]
		},
		"outputs": {
		    "bin-linux-amd64": "/task/bash"
		}
	    }
	},
    },
    "exports": {
	"bin-linux-amd64": "bash_build.bin-linux-amd64"
    }
}
