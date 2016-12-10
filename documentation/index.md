# Snappy iOS Module Module

## Description

Quote from [https://google.github.io/snappy/](https://google.github.io/snappy/):

> Snappy is a compression/decompression library. It does not aim for maximum compression, or compatibility with any other compression library; instead, it aims for very high speeds and reasonable compression. For instance, compared to the fastest mode of zlib, Snappy is an order of magnitude faster for most inputs, but the resulting compressed files are anywhere from 20% to 100% bigger. On a single core of a Core i7 processor in 64-bit mode, Snappy compresses at about 250 MB/sec or more and decompresses at about 500 MB/sec or more.
> 
> Snappy is widely used inside Google, in everything from BigTable and MapReduce to our internal RPC systems. (Snappy has previously been referred to as “Zippy” in some presentations and the likes.)
> 
> The latest release at the time of writing is [1.1.3](https://github.com/google/snappy/releases/download/1.1.3/snappy-1.1.3.tar.gz).

## Accessing the Snappy iOS Module Module

To access this module from JavaScript, you would do the following:

    var snappy_ios_module = require("rs.rbt.snappy");

The snappy_ios_module variable is a reference to the Module object.

## Reference

### snappy_ios_module.compressToBase64String

Compresses passed string using Snappy compression and Base64 encodes it for sending over network.

### snappy_ios_module.uncompressFromBase64String

Base64 decodes and Snappy decompresses passed string.

## Usage

	var snappy_ios_module = require('rs.rbt.snappy');

	function SnappyCompress(uncompressed) {
		var compressed = snappy_ios_module.compressToBase64String(uncompressed);
		console.log("Compressed and Base64 encoded\n" + compressed);
		return compressed;
	};

	function SnappyUncompress(compressed) {
		var uncompressed = snappy_ios_module.uncompressFromBase64String(compressed);
		console.log("Base 64 decoded and uncompressed\n" + uncompressed);
		return uncompressed;
	};

## Author

Srdjan Markovic <srdjan.markovic AT rbt.rs>

## License

Copyright 2016 Red-Black Tree d.o.o.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
