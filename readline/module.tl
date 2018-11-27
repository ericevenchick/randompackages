{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_readline": "catalog:git.savannah.gnu.org/readline:v7.0:src",
    },
    "steps": {
	"readline_build": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_readline": "/task"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"/task/configure && /usr/bin/make -j8",
		    ]
		},
		"outputs": {
		    "libreadline-linux-amd64": "/task/shlib/libreadline.so.7.0",
		    "libhistory-linux-amd64": "/task/shlib/libhistory.so.7.0"
		}
	    }
	},
    },
    "exports": {
	"libreadline-linux-amd64": "readline_build.libreadline-linux-amd64",
	"libhistory-linux-amd64": "readline_build.libhistory-linux-amd64"
    }
}
