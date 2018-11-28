{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_runit": "catalog:timeless.polydawn.io/runit:v2.1.2:src",
    },
    "steps": {
	"build": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_runit": "/package",
		},
		"action": {
		    "policy": "sysad",
		    "exec": [
			"/bin/bash", "-c",
			"cd /package/admin/runit-2.1.2 && ./package/install"
		    ]
		},
		"outputs": {
		    "runit": "/package/admin/runit-2.1.2"
		}
	    },
	},
    }
    "exports": {
	"bin-linux-amd64": "build.runit"
    }
}
