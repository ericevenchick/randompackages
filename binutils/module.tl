{
    "imports": {
	"base": "catalog:early.polydawn.io/monolith/debian-gcc-plus:v1.2017.01.04:linux-amd64",
	"src_binutils": "catalog:ftp.gnu.org/gnu/binutils:v2.31:src",
	"src_mpfr": "catalog:ftp.gnu.org/gnu/mpfr:v4.0.1:src",
	"src_gmp": "catalog:ftp.gnu.org/gnu/gmp:v6.1.2:src",
	"src_mpc": "catalog:ftp.gnu.org/gnu/mpc:v1.1.0:src",
	"src_gcc": "catalog:ftp.gnu.org/gnu/gcc:v8.2.0:src",
    },
    "steps": {
	"binutils": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "src_binutils": "/task"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"mkdir -p /task/prefix && mkdir /task/build &&  cd /task/build && /task/binutils-2.31/configure --prefix=/task/prefix && /usr/bin/make -j8 && make install",
		    ]
		},
		"outputs": {
		    "binutils": "/task/prefix",
		}
	    }
	},
	"build_gcc": {
	    "operation": {
		"inputs": {
		    "base": "/",
		    "binutils.binutils": "/tools"
		    "src_gcc": "/task"
		    "src_mpfr": "/task/mpfr_src"
		    "src_gmp": "/task/gmp_src"
		    "src_mpc": "/task/mpc_src"
		},
		"action": {
		    "exec": [
			"/bin/bash", "-c",
			"cd /task/gcc-8.2.0 && cp -pR /task/mpfr_src/mpfr-* mpfr && cp -pR /task/mpc_src/mpc-* mpc && cp -pR /task/gmp_src/gmp-* gmp && mkdir build && cd build && ../configure --prefix=/tools --disable-multilib --with-newlib --without-headers --disable-nls --disable-shared --disable-decimal-float --disable-threads --disable-libatomic --disable-libgomp --disable-libmpx --disable-libquadmath --disable-libssp --disable-libvtv --disable-libstdcxx --disable-libstdcxx-pch --enable-languages=c,c++ && make && make install"
		    ]
		},
		"outputs": {
		    "build_dir": "/task/gcc-8.2.0/build"
		    "gcc": "/tools"
		}
	    }
	    
	},
    }
    "exports": {
	"gcc-build": "build_gcc.build_dir"
    }
}
