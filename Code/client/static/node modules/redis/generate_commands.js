var http = require("http"),
    fs = require("fs");

function prettyCurrentTime() {
    var date = new Date();
    return date.toLocaleString();
}

function write_file(commands, path) {
    var file_contents, out_commands;

    console.log("Writing " + Object.keys(commands).length + " commands to " + path);

    file_contents = "// This file was generated by ./generate_commands.js on " + prettyCurrentTime() + "\n";

    out_commands = Object.keys(commands).map(function (key) {
        return key.toLowerCase();
    });

    file_contents += "module.exports = " + JSON.stringify(out_commands, null, "    ") + ";\n";

    fs.writeFile(path, file_contents);
}

http.get({host: "redis.io", path: "/commands.json"}, function (res) {
    var body = "";

    console.log("Response from redis.io/commands.json: " + res.statusCode);

    res.on('data', function (chunk) {
        body += chunk;
    });

    res.on('end', function () {
        write_file(JSON.parse(body), "lib/commands.js");
    });
}).on('error', function (e) {
    console.log("Error fetching command list from redis.io: " + e.message);
});
