"use strict";

var parseString = require('xml2js').parseString;
var fs = require('fs');

process.argv.shift();
process.argv.shift();

var files = process.argv;

try {
	var xml = fs.readFileSync(files[0]);
	parseString(xml, function(err, json) {
		if (err) {
			console.log(err);
		}
		fs.writeFileSync(files[1], (JSON.stringify(json, null, 2)));
	});
} catch (e) {
	console.log(e, files[0]);
}
