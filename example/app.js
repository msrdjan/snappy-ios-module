// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
win.add(label);
win.open();

// TODO: write your module tests here
var snappy_ios_module = require('rs.rbt.snappy');
Ti.API.info("module is => " + snappy_ios_module);

label.text = snappy_ios_module.example();

Ti.API.info("module exampleProp is => " + snappy_ios_module.exampleProp);
snappy_ios_module.exampleProp = "This is a test value";

if (Ti.Platform.name == "android") {
	var proxy = snappy_ios_module.createExample({
		message: "Creating an example Proxy",
		backgroundColor: "red",
		width: 100,
		height: 100,
		top: 100,
		left: 150
	});

	proxy.printMessage("Hello world!");
	proxy.message = "Hi world!.  It's me again.";
	proxy.printMessage("Hello world!");
	win.add(proxy);
}

