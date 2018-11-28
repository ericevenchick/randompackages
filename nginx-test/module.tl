{
    "imports": {
	"nginx": "catalog:timeless.polydawn.io/nginx:candidate:bin-linux-amd64"
    },
    "steps": {
	"run": {
	    "operation": {
		"inputs": {
		    "nginx": "/pkg/nginx",
		},
		"action": {
		    "exec": [
			"/pkg/nginx/lib/ld-linux-x86-64.so.2", "--library-path", "/pkg/nginx/lib", "/pkg/nginx/sbin/nginx", "-g daemon off;"
		    ]
		},
		"outputs": {
		}
	    },
	},
    }
    "exports": {
    }
}
