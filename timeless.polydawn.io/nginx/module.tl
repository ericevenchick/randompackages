{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_nginx": "catalog:timeless.polydawn.io/nginx:v1.14.0:src",
	"src_pcre": "catalog:timeless.polydawn.io/pcre:v8.42:src"
	"src_zlib": "catalog:timeless.polydawn.io/zlib:v1.2.11:src"
	"src_openssl": "catalog:timeless.polydawn.io/openssl:v1.0.2p:src"
	"pcre": "catalog:timeless.polydawn.io/pcre:candidate:bin-linux-amd64"
	"zlib": "catalog:timeless.polydawn.io/zlib:candidate:bin-linux-amd64"
	"openssl": "catalog:timeless.polydawn.io/openssl:candidate:bin-linux-amd64"
	"glibc": "catalog:timeless.polydawn.io/glibc:candidate:bin-linux-amd64"
    },
    "steps": {
	"configure": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_nginx": "/pkg/nginx/src",
		    "src_pcre": "/pkg/pcre/src",
		    "src_zlib": "/pkg/zlib/src",
		    "src_openssl": "/pkg/openssl/src"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cp -pr /pkg/nginx/src/nginx-* /task/nginx && cp -pr /pkg/pcre/src/pcre-* /task/pcre && cp -pr /pkg/zlib/src/zlib-* /task/zlib && cp -pr /pkg/openssl/src/openssl-* /task/openssl && cd /task/nginx && LDFLAGS=\"-Wl,-rpath=XORIGIN/../lib\" ./configure --prefix=/pkg/nginx --with-pcre=/task/pcre --with-zlib=/task/zlib --with-http_ssl_module --with-openssl=/task/openssl",
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
		    "src_pcre": "/pkg/pcre/src",
		    "src_zlib": "/pkg/zlib/src",
		    "src_openssl": "/pkg/openssl/src"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cd /task/nginx && make && make install",
		    ]
		},
		"outputs": {
		    "build_dir": "/task/nginx",
		    "nginx": "/pkg/nginx",
		}
	    }
	},

	"package": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "build.nginx": "/pkg/nginx"
		    "pcre": "/pkg/pcre",
		    "zlib": "/pkg/zlib",
		    "openssl": "/pkg/openssl"
		    "glibc": "/pkg/glibc"
		},
		"action": {
		    "exec": ["/bin/bash", "-c", "sed -i 's/XORIGIN/$ORIGIN/' /pkg/nginx/sbin/* && mkdir /pkg/nginx/lib && cp /pkg/zlib/lib/*.so /pkg/nginx/lib && cp /pkg/pcre/lib/*.so /pkg/nginx/lib && cp /pkg/glibc/lib/*.so* /pkg/nginx/lib"]
		},
		"outputs": {
		    "bin-linux-amd64": "/pkg/nginx"
		}
	    }
	}
    }
    "exports": {
	"bin-linux-amd64": "package.bin-linux-amd64"
	"nginx_build": "configure.build_dir"
    }
}
